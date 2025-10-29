import 'package:flutter/material.dart';

import 'custom_app_button.dart';
import 'custom_image_view.dart';
import '../navigation_helper.dart';
import '../theams/color_resource.dart';
import '../../../screens/home/view/bottom_controller.dart';

class BookingCompletionDialogue extends StatelessWidget {
  final String message;
  final String? imagePath;
  final String? buttonText;

  const BookingCompletionDialogue({
    Key? key,
    required this.message,
    this.buttonText,
    this.imagePath
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
                imagePath: imagePath??'assets/images/confirmReminderIcon.png',
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
                label: buttonText??"Done",
                onPressed: (){
                  navPushRemove(context: context, page: BottomNavController());
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}