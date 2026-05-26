import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:health_care/core/utils/custom_widgets/custom_appBar.dart';
import 'package:health_care/core/utils/custom_widgets/custom_text.dart';
import 'package:health_care/core/utils/custom_widgets/custom_threeDots_indecator.dart';
import 'package:health_care/core/utils/global_variables.dart';
import 'package:health_care/core/utils/helper_functions/helpers_methods.dart';
import 'package:health_care/core/utils/theams/color_resource.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../core/utils/custom_widgets/custom_app_button.dart';
import '../../../core/utils/custom_widgets/custom_inputFiled.dart';
import '../model/slots_model.dart';
import '../view_model/book_appointments_viewModel.dart';
import '../widget/add_patients_dialogue.dart';



class BookAppointment extends StatefulWidget {
  final String consultantId;
  final bool isEmergency;


  const BookAppointment({super.key, required this.consultantId,this.isEmergency = false});

  @override
  State<BookAppointment> createState() => _BookAppointmentState();
}

class _BookAppointmentState extends State<BookAppointment> {
  DateTime selectedDate = DateTime.now();
  AvailableSlotsData? selectedSlot;
  List<String> selectedReminders = [];
  final TextEditingController notesController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<BookingSlotViewModel>(context, listen: false).getNewConsultantSlot(
        context: context,
        consultantId: widget.consultantId,
        date: selectedDate.toIso8601String().substring(0, 10),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<BookingSlotViewModel>(context);
    List<String> filteredReminderSlots = [];

    if (selectedSlot != null && selectedSlot!.start != null) {
      final selectedTime = DateFormat("HH:mm").parse(selectedSlot!.start!);
      filteredReminderSlots = provider.reminderSlots.where((slotTime) {
        final reminderTime = DateFormat("HH:mm").parse(slotTime);
        return reminderTime.isBefore(selectedTime) || reminderTime.isAtSameMomentAs(selectedTime);
      }).toList();
    }

    return Scaffold(
      backgroundColor: ColorResource.white,
      appBar: CustomAppBar(title: "Book Appointment"),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(text: "Select Appointment Date"),
              const SizedBox(height: 8),
              InkWell(
                onTap: () async {
                  DateTime? picked = await showDatePicker(
                    context: context,
                    initialDate: selectedDate,
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2100),
                  );
                  if (picked != null) {
                    setState(() {
                      selectedDate = picked;
                      selectedSlot = null;
                      selectedReminders.clear();
                    });
                    provider.getNewConsultantSlot(
                      context: context,
                      consultantId: widget.consultantId,
                      date: picked.toIso8601String().substring(0, 10),
                    );
                  }
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                    color: ColorResource.lightBlue,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: ColorResource.primaryBlue),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.calendar_today, size: 18),
                      const SizedBox(width: 12),
                      Text(
                        '${selectedDate.day}-${selectedDate.month}-${selectedDate.year}',
                        style: const TextStyle(fontSize: 16),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              CustomText(text: "Available Slots*"),
              const SizedBox(height: 12),
              provider.isLoading
                  ? const Center(child: ThreeDotsLoader())

                  : provider.slots.isEmpty
                  ? Padding(
                padding: const EdgeInsets.symmetric(vertical: 24),
                child: Center(
                  child: Text(
                    'No time slots available on this date.',
                    style: TextStyle(
                      color: Colors.red.shade600,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              )
                  : Wrap(
                spacing: 10,
                children: provider.slots.map((slot) {
                  final isSelected = selectedSlot?.start == slot.start;
                  return ChoiceChip(
                    label: Text('${slot.start ?? "N/A"} - ${slot.end}'),
                    selected: isSelected,
                    selectedColor: ColorResource.lightBlue,
                    backgroundColor: ColorResource.white,
                    showCheckmark: false,
                    onSelected: (_) {
                      setState(() {
                        selectedSlot = slot;
                        selectedReminders.clear();
                      });
                    },
                  );
                }).toList(),
              ),
              const SizedBox(height: 12),
              if (selectedSlot != null && filteredReminderSlots.isNotEmpty) ...[
                CustomText(text: "Reminder Slots"),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 10,
                  children: filteredReminderSlots.map((slot) {
                    final isSelected = selectedReminders.contains(slot);
                    return FilterChip(
                      label: Text(slot),
                      selected: isSelected,
                      selectedColor: ColorResource.lightBlue,
                      backgroundColor: ColorResource.white,
                      showCheckmark: false,
                      onSelected: (selected) {
                        setState(() {
                          if (selected) {
                            selectedReminders.add(slot);
                          } else {
                            selectedReminders.remove(slot);
                          }
                        });
                      },
                    );
                  }).toList(),
                ),
              ],
              const SizedBox(height: 24),
              CustomText(text: "Please Enter Brief description about your health.",fontSize: 14,),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                decoration: BoxDecoration(
                  color: ColorResource.lightBlue,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: ColorResource.primaryBlue),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: notesController,
                        decoration: InputDecoration(
                          fillColor:  ColorResource.lightBlue,
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          hintText: 'Enter your notes here', // Placeholder text
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: CustomAppButton(
          label: 'Book Appointment',
          onPressed: () {
            if (selectedSlot == null) {
              HelperMethods.showCustomSnackbar(context, message: 'Please select an available slot.');
              return;
            }
            final notes = notesController.text.trim().isEmpty
                ? globalSymptomName.join(', ')
                : notesController.text.trim();
            showDialog(
              context: context,
              builder: (_) => AddPatientsDialogue(
                isEmergency:widget.isEmergency,
                notes: notes,
                consultantId: widget.consultantId,
                selectedDate: selectedDate.toIso8601String().substring(0, 10),
                selectedSlotTime:  "${selectedSlot!.start ?? "N/A"} - ${selectedSlot!.end ?? "N/A"}",
                message: "Appointment Successfully Booked.",
                // reminderList: selectedReminders,
                reminderList: ['26:00'],//todo enable remider slots for getting the slots
                onPressed: () {},
              ),
            );
          },
        ),
      ),
    );
  }
}
