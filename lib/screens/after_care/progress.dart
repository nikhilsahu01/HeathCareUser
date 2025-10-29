import 'dart:async';
import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:health_care/core/utils/custom_widgets/custom_text.dart';
import 'package:health_care/core/utils/theams/color_resource.dart';

class AutoProgressBar extends StatelessWidget {
  final double progress;

  const AutoProgressBar({
    Key? key,
    required this.progress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double clampedProgress = progress.clamp(0.0, 1.0);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          children: [
            const CustomText(text: 'Progress', fontSize:13),
            const SizedBox(width: 70),
            Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child: CustomText(
                text: "${(clampedProgress * 100).toInt()}%",

                  fontWeight: FontWeight.bold,
                  fontSize: 16,

              ),
            ),
          ],
        ),

        // Progress Bar
        Center(
          child: Container(
            width: 300,
            height: 14,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(40),
              border: Border.all(color: Colors.black12),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(40),
              child: Align(
                alignment: Alignment.centerLeft,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: 300 * clampedProgress,
                  height: 14,
                  color: ColorResource.primaryBlue,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}