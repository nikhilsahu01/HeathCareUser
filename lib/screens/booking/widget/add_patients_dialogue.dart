import 'package:flutter/material.dart';
import 'package:health_care/core/utils/custom_widgets/custom_threeDots_indecator.dart';
import 'package:health_care/core/utils/global_variables.dart';
import 'package:health_care/core/utils/helper_functions/helpers_methods.dart';
import 'package:provider/provider.dart';
import '../../../core/utils/custom_widgets/custom_app_button.dart';
import '../../../core/utils/navigation_helper.dart';
import '../../../core/utils/theams/color_resource.dart';
import '../../home/view/bottom_controller.dart';
import '../view_model/patients_viewmodel.dart';
import '../../../core/utils/custom_widgets/booking_completeDialogue.dart';


class AddPatientsDialogue extends StatefulWidget {
  final VoidCallback onPressed;
  final bool isEmergency;
  final String message;
  final String selectedDate;
  final String consultantId;
  final String selectedSlotTime;
  final String notes;
  final List<String> reminderList;

  const AddPatientsDialogue({
    Key? key,
    required this.onPressed,
    required this.message,
    required this.selectedDate,
    required this.consultantId,
    required this.selectedSlotTime,
    required this.reminderList,
    required this.notes,
    this.isEmergency = false,
  }) : super(key: key);

  @override
  State<AddPatientsDialogue> createState() => _AddPatientsDialogueState();
}

class _AddPatientsDialogueState extends State<AddPatientsDialogue> {
  String? selectedPatientId;
  final TextEditingController newPatientController = TextEditingController();
  bool showAddField = false;
  bool isSaving = false;
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      Provider.of<PatientsViewModel>(context, listen: false).fetchPatients();
    });
  }

  void addNewPatient(PatientsViewModel provider) async {
    final name = newPatientController.text.trim();
    if (name.length > 2) {
      final added = await provider.addPatient(name);
      if (added) {
        setState(() {
          selectedPatientId = provider.patients.firstWhere((p) => p.name == name).sId;
          showAddField = false;
          newPatientController.clear();
        });
      } else {
        HelperMethods.showCustomSnackbar(context, message: 'Failed to add patient');
      }
    } else {
      HelperMethods.showCustomSnackbar(context, message: 'Enter a valid name');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Consumer<PatientsViewModel>(
          builder: (context, provider, _) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Select Patient',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 16),

                provider.isLoading
                    ? const Center(child: ThreeDotsLoader())
                    : provider.patients.isEmpty
                    ? const Text("No patients found")
                    : ConstrainedBox(
                  constraints: const BoxConstraints(maxHeight: 220),
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: provider.patients.length,
                    itemBuilder: (context, index) {
                      final patient = provider.patients[index];
                      final isSelected = selectedPatientId == patient.sId;

                      return Card(
                        color: ColorResource.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                          side: BorderSide(
                            color: isSelected
                                ? ColorResource.primaryBlue
                                : Colors.grey.shade300,
                          ),
                        ),
                        child: ListTile(
                          leading: const CircleAvatar(
                            backgroundColor: Colors.blue,
                            child: Icon(Icons.person, color: Colors.white),
                          ),
                          title: Text(patient.name ?? "Unnamed"),
                          trailing: GestureDetector(
                            onTap: () async {
                              await provider.removePatient(patient.sId ?? '');
                              setState(() {
                                if (selectedPatientId == patient.sId) {
                                  selectedPatientId = null;
                                }
                              });
                            },
                            child: const CircleAvatar(
                              radius: 14,
                              backgroundColor: Colors.red,
                              child: Icon(Icons.close, size: 16, color: Colors.white),
                            ),
                          ),
                          onTap: () {
                            setState(() {
                              selectedPatientId = patient.sId;
                            });
                          },
                        ),
                      );
                    },
                  ),
                ),

                const SizedBox(height: 12),

                /// + Add New Patient Button
                Align(
                  alignment: Alignment.centerLeft,
                  child: TextButton.icon(
                    onPressed: () {
                      setState(() {
                        showAddField = !showAddField;
                      });
                    },
                    icon: const Icon(Icons.add, color: Colors.blue),
                    label: const Text('Add New Patient', style: TextStyle(color: Colors.blue)),
                  ),
                ),
                if (showAddField) ...[
                  const SizedBox(height: 10),
                  TextField(
                    controller: newPatientController,
                    decoration: InputDecoration(
                      hintText: 'Enter new patient name',
                      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  CustomAppButton(
                    label: "Add Patient",
                    onPressed: () => addNewPatient(provider),
                  ),
                ],

                const SizedBox(height: 24),

                if(!showAddField) /// Book Appointment Button
                  CustomAppButton(
                    label: "Book Appointment",
                    onPressed:isSaving
                        ?(){}
                        :() async {
                      if (selectedPatientId == null) {
                        HelperMethods.showCustomSnackbar(context, message: 'Please select a patient');
                        return;
                      }
                      setState(() => isSaving = true);
                      debugPrint('Selected Date: ${widget.selectedDate}');
                      debugPrint('Selected Slot: ${widget.selectedSlotTime}');
                      debugPrint('Selected Patient ID: $selectedPatientId');
                      String commaSeparated = globalSymptomName.join(', ');

                      // Book appointment and wait for result
                      final success = await Provider.of<PatientsViewModel>(context, listen: false).bookAppointment(
                        patientId: selectedPatientId!,
                        vendorId: widget.consultantId,
                        appointmentDate: widget.selectedDate,
                        timeSlot: widget.selectedSlotTime,
                        reminders: widget.reminderList,
                        type:globalTabType,
                        categoryId:globalSpecializationCategoryId,
                        notes:widget.notes?? commaSeparated,
                          isEmergency:widget.isEmergency

                      );

                      if (success) {
                        globalSymptomName.clear();
                        globalSymptomId.clear();
                        setState(() => isSaving= false);
                        // Close current AddPatientsDialogue
                        if (context.mounted) navPop(context: context);

                        // Show booking completion dialogue
                        if (context.mounted) {
                          showDialog(
                            context: context,
                            builder: (_) => BookingCompletionDialogue(
                              message: widget.message,
                              buttonText: 'Back to home',
                            ),
                          );
                        }
                      } else {
                        setState(() => isSaving= false);
                        HelperMethods.showCustomSnackbar(context, message: "Booking failed, please try again.");
                      }
                    },
                    child: isSaving
                          ?  const ThreeDotsLoader(color: ColorResource.white,)
                        : null,
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}
