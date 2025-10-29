import 'package:flutter/material.dart';
import 'package:health_care/core/utils/custom_widgets/custom_text.dart';
import '../../../core/utils/custom_widgets/custom_image_view.dart';


class CircularButtonRow extends StatelessWidget {

  static const List<String> labels = [
    "35+ Crore Users Served",
    "10 Lakh+ App Downloads",
    "1 Lakh+ Daily Active Users",
  ];

  static const List<String> imagePaths = [
    "assets/images/healthHomeIcon.png",
    "assets/images/mobileHomeIcon.png",
    "assets/images/activeUserIcons.png",
  ];

  const CircularButtonRow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(labels.length, (index) {
        return _buildCircularButton(labels[index], imagePaths[index], screenWidth);
      }),
    );
  }

  Widget _buildCircularButton(String label, String imagePath, double screenWidth) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: CircleAvatar(
                radius: screenWidth * 0.1,
                backgroundColor: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomImageView(
                    imagePath: imagePath,
                    height: screenWidth * 0.08,
                    width: screenWidth * 0.08,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            CustomText(text: label, fontSize: 14, textAlign: TextAlign.center,),
          ],
        ),
      ),
    );
  }
}