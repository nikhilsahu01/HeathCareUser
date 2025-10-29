import 'package:flutter/material.dart';
import 'package:health_care/core/utils/custom_widgets/custom_image_view.dart';
import 'package:health_care/core/utils/navigation_helper.dart';

import '../../../screens/home/view/bottom_controller.dart';
import '../theams/color_resource.dart';
import 'custom_app_button.dart';

class CustomDialogue extends StatelessWidget {
  final VoidCallback onPressed;
  final String message;

  const CustomDialogue({
    Key? key,
    required this.onPressed,
    required this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        navPushRemove(context: context, page: BottomNavController());
        return false;
      },
      child: Dialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomImageView(
                imagePath: 'assets/images/confirmReminderIcon.png',
                height: 80,
                width: 80,
              ),
              const SizedBox(height: 20),
              Text(
                message,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: ColorResource.darkText,
                ),
              ),
              const SizedBox(height: 24),
              CustomAppButton(
                label: "Done",
                onPressed: onPressed,
              )
            ],
          ),
        ),
      ),
    );
  }
}
