import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:health_care/core/utils/theams/color_resource.dart';
import 'package:health_care/screens/after_care/progress.dart';
import '../../../../core/utils/custom_widgets/custom_appBar.dart';
import '../../../../core/utils/custom_widgets/custom_app_button.dart';
import '../../../core/utils/custom_widgets/custom_image_view.dart';
import '../../../core/utils/custom_widgets/custom_text.dart';
import '../appointment_model/appointment_model.dart';
import '../daily_remainder_model/daily_remainder_model.dart';
import '../medicine_model/medicine_model.dart';

import 'package:provider/provider.dart';
import '../../appointments/viewModel/appointments_viewModel.dart';
import '../viewmodel/aftercare_viewmodel.dart';

class AfterCareScreen extends StatefulWidget {
  const AfterCareScreen({super.key});

  get isBack => null;

  @override
  State<AfterCareScreen> createState() => _AfterCareScreenState();
}

class _AfterCareScreenState extends State<AfterCareScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<AftercareViewModel>().fetchAftercareAppointments();
      context.read<AftercareViewModel>().fetchMedicines();
      context.read<AftercareViewModel>().fetchInstructions();
    });
  }

  double _progress = 0.5;
  // Removed static list variables

  void _showAddMedicineDialog() {
    final nameCtrl = TextEditingController();
    final dosageCtrl = TextEditingController();
    final timingCtrl = TextEditingController();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) {
        return Padding(
          padding: EdgeInsets.only(bottom: MediaQuery.of(ctx).viewInsets.bottom),
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(width: 40, height: 4, decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(10))),
                const SizedBox(height: 15),
                const Text('Add Medicine', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 20),
                TextField(
                  controller: nameCtrl,
                  decoration: InputDecoration(
                    labelText: 'Medicine Name (e.g., Paracetamol)',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                ),
                const SizedBox(height: 15),
                TextField(
                  controller: dosageCtrl,
                  decoration: InputDecoration(
                    labelText: 'Dosage (e.g., 1 Tablet)',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                ),
                const SizedBox(height: 15),
                TextField(
                  controller: timingCtrl,
                  decoration: InputDecoration(
                    labelText: 'Timing (e.g., After Lunch)',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                ),
                const SizedBox(height: 25),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      backgroundColor: ColorResource.primaryBlue,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                    onPressed: () {
                      if (nameCtrl.text.isNotEmpty && dosageCtrl.text.isNotEmpty && timingCtrl.text.isNotEmpty) {
                        context.read<AftercareViewModel>().addMedicine(
                          name: nameCtrl.text,
                          dosage: dosageCtrl.text,
                          timing: timingCtrl.text,
                        );
                        Navigator.pop(ctx);
                      }
                    },
                    child: const Text('Add Medicine', style: TextStyle(color: Colors.white, fontSize: 16)),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showDailyHealthCheckinDialog() {
    final painCtrl = TextEditingController(text: '0');
    final bpCtrl = TextEditingController();
    final sugarCtrl = TextEditingController();
    final tempCtrl = TextEditingController();
    final symptomsCtrl = TextEditingController();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) {
        return Padding(
          padding: EdgeInsets.only(bottom: MediaQuery.of(ctx).viewInsets.bottom),
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(width: 40, height: 4, decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(10))),
                  const SizedBox(height: 15),
                  const Text('Daily Health Check-in', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 20),
                  TextField(
                    controller: painCtrl,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Pain Level (0-10)',
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                  const SizedBox(height: 15),
                  TextField(
                    controller: bpCtrl,
                    decoration: InputDecoration(
                      labelText: 'Blood Pressure (e.g. 120/80)',
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                  const SizedBox(height: 15),
                  TextField(
                    controller: sugarCtrl,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Sugar Level (e.g. 110)',
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                  const SizedBox(height: 15),
                  TextField(
                    controller: tempCtrl,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Temperature (e.g. 98.6)',
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                  const SizedBox(height: 15),
                  TextField(
                    controller: symptomsCtrl,
                    maxLines: 2,
                    decoration: InputDecoration(
                      labelText: 'Any severe symptoms?',
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                  const SizedBox(height: 25),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        backgroundColor: ColorResource.primaryBlue,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                      onPressed: () async {
                        bool success = await context.read<AftercareViewModel>().submitHealthLog(
                          painLevel: int.tryParse(painCtrl.text) ?? 0,
                          bloodPressure: bpCtrl.text,
                          sugarLevel: int.tryParse(sugarCtrl.text) ?? 0,
                          temperature: double.tryParse(tempCtrl.text) ?? 98.6,
                          symptoms: symptomsCtrl.text,
                        );
                        Navigator.pop(ctx);
                        if (success && mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Health Log Submitted! Doctor notified.")),
                          );
                        }
                      },
                      child: const Text('Submit Data', style: TextStyle(color: Colors.white, fontSize: 16)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<AftercareViewModel>(context);

    return Scaffold(
      appBar: CustomAppBar(title: 'Aftercare', isBack: widget.isBack ?? true),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(left: 15, right: 15, bottom: 15),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: ColorResource.lightBlue,
                  borderRadius: BorderRadius.circular(6),
                ),
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: const EdgeInsets.all(5),
                  child: Column(
                    children: [
                      SizedBox(height: 5),
                      Center(
                        child: Text(
                          'Daily Dose Reminder',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(height: 8),
                      Divider(height: 1, color: Colors.white),
                      SizedBox(height: 5),
                      CustomAppButton(
                        label: '+Add Medicine',
                        onPressed: _showAddMedicineDialog,
                      ),
                      SizedBox(height: 15),
                      vm.medicines.isEmpty
                          ? Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('No medicines added yet.'),
                          )
                          : ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: vm.medicines.length,
                            itemBuilder: (context, index) {
                              final med = vm.medicines[index];
                              final isTaken = med.isTaken ?? false;
                              return Container(
                                margin: EdgeInsets.only(bottom: 10),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black12,
                                      blurRadius: 6,
                                      offset: Offset(0, 2),
                                    ),
                                  ],
                                ),
                                padding: EdgeInsets.symmetric(
                                  vertical: 14,
                                  horizontal: 8,
                                ),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          padding: EdgeInsets.all(12),
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color:
                                                isTaken
                                                    ? Colors.green.shade100
                                                    : Color(0xFFC9DFFE),
                                          ),
                                          child: CustomImageView(
                                            imagePath:
                                                'https://cdn-icons-png.flaticon.com/512/2551/2551677.png',
                                            width: 32,
                                            height: 32,
                                          ),
                                        ),
                                        SizedBox(width: 14),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              CustomText(
                                                text:
                                                    med.medicineName ??
                                                    "Medicine",
                                                fontSize: 16,
                                                color:
                                                    isTaken
                                                        ? Colors.grey
                                                        : Colors.black,
                                              ),
                                              CustomText(
                                                text: med.timing ?? "Timing",
                                                fontSize: 14,
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(width: 12),
                                        Container(
                                          width: 70,
                                          height: 70,
                                          decoration: BoxDecoration(
                                            color:
                                                isTaken
                                                    ? Colors.green
                                                    : ColorResource.pillBlue,
                                            borderRadius: BorderRadius.circular(
                                              12,
                                            ),
                                          ),
                                          child: Center(
                                            child: Text(
                                              (med.dosage ?? "1").replaceAll(
                                                " ",
                                                "\n",
                                              ),
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                color: Colors.white,
                                                fontSize: 14,
                                                height: 1.2,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 10),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: CustomAppButton(
                                            label: isTaken ? 'Undo' : 'Remind',
                                            color:
                                                isTaken
                                                    ? Colors.grey
                                                    : ColorResource.red,
                                            onPressed:
                                                isTaken
                                                    ? () {
                                                      vm.toggleMedicineStatus(
                                                        med.id!,
                                                        false,
                                                      );
                                                    }
                                                    : () {},
                                          ),
                                        ),
                                        const SizedBox(width: 10),
                                        Expanded(
                                          child: CustomAppButton(
                                            label:
                                                isTaken
                                                    ? 'Taken ✓'
                                                    : 'Take Now',
                                            color:
                                                isTaken
                                                    ? Colors.green
                                                    : ColorResource.green,
                                            onPressed:
                                                isTaken
                                                    ? () {}
                                                    : () {
                                                      vm.toggleMedicineStatus(
                                                        med.id!,
                                                        true,
                                                      );
                                                    },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 15),
              Container(
                decoration: BoxDecoration(
                  color: Color(0xffD8ECFF),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Padding(
                  padding: EdgeInsets.all(15),
                  child: Column(
                    children: [
                      Consumer<AppointmentViewModel>(
                        builder: (context, appointmentVm, _) {
                          final upcoming = appointmentVm.upcomingAppointments;
                          if (upcoming.isEmpty) {
                            return Center(
                              child: Text(
                                'No Upcoming Appointments',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey,
                                ),
                              ),
                            );
                          }
                          final nextApt = upcoming.first;
                          return Column(
                            children: [
                              Center(
                                child: Text(
                                  'Next Follow-up Appointment',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              SizedBox(height: 5),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.calendar_month,
                                    color: ColorResource.primaryBlue,
                                    size: 20,
                                  ),
                                  SizedBox(width: 8),
                                  Text(
                                    "${nextApt.appointmentDate ?? ''} at ${nextApt.timeSlot ?? ''}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          );
                        },
                      ),
                      Divider(height: 1, color: Colors.white),
                      SizedBox(height: 5),
                      vm.isLoading
                          ? const Center(child: CircularProgressIndicator())
                          : vm.aftercareAppointments.isEmpty
                          ? const Center(
                            child: Padding(
                              padding: EdgeInsets.all(8),
                              child: Text(
                                "No upcoming aftercare appointments.",
                              ),
                            ),
                          )
                          : ListView.builder(
                            itemCount: vm.aftercareAppointments.length,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              final appointdata =
                                  vm.aftercareAppointments[index];
                              final doctorName =
                                  appointdata['vendor']?['name'] ?? 'Doctor';
                              final dateandtime =
                                  "${appointdata['appointmentDate'] ?? ''} | ${appointdata['timeSlot'] ?? ''}";
                              final mode = appointdata['mode'] ?? 'Self';
                              final booking =
                                  appointdata['type'] ?? 'Video Call';
                              final id = appointdata['_id'];

                              return Column(
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        'Doctor :',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: ColorResource.darkText,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      Spacer(),
                                      Text(
                                        doctorName,
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: ColorResource.darkText,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 8),
                                  Row(
                                    children: [
                                      Text(
                                        'Date & Time :',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: ColorResource.darkText,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      Spacer(),
                                      Text(
                                        dateandtime,
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: ColorResource.darkText,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 8),
                                  Row(
                                    children: [
                                      Text(
                                        'Mode :',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: ColorResource.darkText,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      Spacer(),
                                      Text(
                                        mode,
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: ColorResource.darkText,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 8),
                                  Row(
                                    children: [
                                      Text(
                                        'Booking For :',
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: ColorResource.darkText,
                                        ),
                                      ),
                                      Spacer(),
                                      Text(
                                        booking,
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: ColorResource.darkText,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 20),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: CustomAppButton(
                                          label: 'Cancel',
                                          color: ColorResource.white,
                                          textColor: ColorResource.darkText,
                                          onPressed: () async {
                                            bool success = await vm
                                                .cancelAftercare(id);
                                            if (success) {
                                              ScaffoldMessenger.of(
                                                context,
                                              ).showSnackBar(
                                                const SnackBar(
                                                  content: Text(
                                                    "Appointment cancelled.",
                                                  ),
                                                ),
                                              );
                                            }
                                          },
                                        ),
                                      ),
                                      SizedBox(width: 15),
                                      Expanded(
                                        child: CustomAppButton(
                                          label: 'Reschedule',
                                          onPressed: () {
                                            ScaffoldMessenger.of(
                                              context,
                                            ).showSnackBar(
                                              const SnackBar(
                                                content: Text(
                                                  "Reschedule not available yet.",
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              );
                            },
                          ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(
                  color: ColorResource.lightPink,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: CustomText(text: 'Recovery Progress Tracker'),
                      ),
                      SizedBox(height: 5),
                      Divider(height: 1, color: Colors.white),
                      SizedBox(height: 5),
                      Row(
                        children: [
                          CustomText(
                            text: 'Daily Medicine Tracker',
                            fontWeight: FontWeight.normal,
                          ),
                          Spacer(),
                          CustomText(
                            text:
                                '${vm.medicines.where((m) => m.isTaken == true).length} / ${vm.medicines.length} Taken',
                            fontSize: 13,
                          ),
                        ],
                      ),
                      SizedBox(height: 5),
                      AutoProgressBar(
                        progress:
                            vm.medicines.isNotEmpty
                                ? (vm.medicines
                                        .where((m) => m.isTaken == true)
                                        .length /
                                    vm.medicines.length)
                                : 0.0,
                      ),
                      SizedBox(height: 10),
                      CustomText(
                        text: 'Pending Medicines:',
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                      ...vm.medicines
                          .where((m) => m.isTaken != true)
                          .map(
                            (m) => Padding(
                              padding: EdgeInsets.all(3),
                              child: Row(
                                children: [
                                  Container(
                                    width: 5,
                                    height: 5,
                                    decoration: BoxDecoration(
                                      color: ColorResource.primaryBlue,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                  SizedBox(width: 5),
                                  Text(
                                    '${m.medicineName} (${m.timing})',
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                          .toList(),
                      if (vm.medicines.where((m) => m.isTaken != true).isEmpty)
                        Padding(
                          padding: EdgeInsets.only(top: 8),
                          child: Text(
                            'All medicines taken for today! Great job.',
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.green,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      SizedBox(height: 10),                      SizedBox(height: 15),
                      if (vm.instructions.isNotEmpty) ...[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Doctor Instructions & Diet Plan',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                            const SizedBox(height: 10),
                            ...vm.instructions.map((inst) {
                              return Container(
                                margin: EdgeInsets.only(bottom: 10),
                                padding: EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('From: Dr. ${inst['vendor']?['name'] ?? 'Doctor'}', style: TextStyle(fontWeight: FontWeight.bold, color: ColorResource.primaryBlue)),
                                    SizedBox(height: 5),
                                    if (inst['instructions'] != null) Text('Instructions: ${inst['instructions']}'),
                                    if (inst['dietPlan'] != null) Text('Diet Plan: ${inst['dietPlan']}'),
                                    if (inst['precautions'] != null) Text('Precautions: ${inst['precautions']}'),
                                  ],
                                ),
                              );
                            }).toList(),
                          ],
                        ),
                      ],
                      SizedBox(height: 20),
                      CustomAppButton(
                        label: 'Daily Health Check-in',
                        onPressed: _showDailyHealthCheckinDialog,
                        color: ColorResource.primaryBlue,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              // Support Chat button
              CustomAppButton(
                label: 'Chat with Clinic Support',
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Chat feature coming soon!")),
                  );
                },
                color: Colors.green,
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

class FollowUpQuestion {
  String question;
  bool? answer;

  FollowUpQuestion(this.question, {this.answer});
}
