import 'package:flutter/material.dart';

import '../../../core/utils/custom_widgets/custom_app_button.dart';
import '../../../core/utils/custom_widgets/custom_image_view.dart';
import '../../../core/utils/navigation_helper.dart';
import '../../../core/utils/theams/color_resource.dart';
import '../../home/view/bottom_controller.dart';

class BookingConfirmationDialogue extends StatelessWidget {
  final VoidCallback onPressed;
  final String message;

  const BookingConfirmationDialogue({
    Key? key,
    required this.onPressed,
    required this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
      // WillPopScope(
      // onWillPop: () async {
      //   navPushRemove(context: context, page: BottomNavController());
      //   return false;
      // },
      // child:
      Dialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomImageView(
                imagePath: 'assets/icons/ambulanceIcon.png',
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: CustomAppButton(
                      label: "Yes",
                      onPressed: onPressed,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: CustomAppButton(
                      color: ColorResource.white,
                       textColor: ColorResource.primaryBlue,
                      borderColor: ColorResource.primaryBlue,
                      label: "No",
                      onPressed: () {
                        navPop(context: context);
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      // ),
    );
  }
}
