
import 'package:flutter/material.dart';
import 'package:health_care/core/utils/custom_widgets/custom_app_button.dart';
import 'package:health_care/core/utils/global_variables.dart';
import 'package:health_care/core/utils/navigation_helper.dart';
import 'package:health_care/core/utils/theams/color_resource.dart';

import '../ui/location_permission.dart';

class BookingDialog extends StatefulWidget {
  // final VoidCallback onContinue;
  final String bookingFor;


  const BookingDialog({super.key,
    // required this.onContinue
    required this.bookingFor
  });

  @override
  State<BookingDialog> createState() => _BookingDialogState();
}

class _BookingDialogState extends State<BookingDialog> {
  int selectedValue = 0;

  @override
  Widget build(BuildContext context) {
    // Make dialog width responsive based on screen width
    double dialogWidth = MediaQuery.of(context).size.width * 0.85;
    if (dialogWidth > 400) dialogWidth = 400;

    return Dialog(
      backgroundColor: ColorResource.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Container(
        width: dialogWidth,
        padding: const EdgeInsets.fromLTRB(24, 24, 24, 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Who you want to book For?',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 20),
            RadioListTile<int>(
              title: const Text('Yourself'),
              value: 0,
              groupValue: selectedValue,
              onChanged: (value) {
                setState(() {
                  selectedValue = value!;
                });
              },
              activeColor: ColorResource.primaryBlue,
              contentPadding: EdgeInsets.zero,
            ),
            RadioListTile<int>(
              title: const Text('Others'),
              value: 1,
              groupValue: selectedValue,
              onChanged: (value) {
                setState(() {
                  selectedValue = value!;
                });
              },
              activeColor: ColorResource.primaryBlue,
              contentPadding: EdgeInsets.zero,
            ),
            const SizedBox(height: 24),
            CustomAppButton(
              label: 'Continue',
              onPressed: () {
                print('Selected option index: $selectedValue');
                // navPush(context: context, page: LocationPermissionScreen());
                setState(() {
                  isYourselfBooking = selectedValue == 0? true : false;
                  bookingFor = widget.bookingFor;
                });
                navPushReplace(context: context, page: LocationPermissionScreen(
                  trauma: false,
                ));
                // widget.onContinue();
              },
            )
          ],
        ),
      ),
    );
  }
}