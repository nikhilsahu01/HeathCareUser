import 'package:flutter/material.dart';
import '../../../../core/utils/custom_widgets/custom_app_button.dart';
import '../../../../core/utils/custom_widgets/custom_image_view.dart';
import '../../../../core/utils/theams/color_resource.dart';

class CustomFileUpload extends StatelessWidget {
  final VoidCallback onPressed;
  final String message;

  const CustomFileUpload({
    super.key,
    required this.onPressed,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomImageView(
                imagePath: 'assets/icons/galleryIcon.png',
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
                label: "Click here to upload",
                icon: Icons.upload_file,
                onPressed: onPressed,
              ),
            ],
          ),
        ),
        // ),
      );
  }
}