import 'package:flutter/material.dart';
import 'package:health_care/core/utils/theams/color_resource.dart';

import 'package:flutter/material.dart';
import 'package:health_care/core/utils/theams/color_resource.dart';

class CustomAppButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final Color color;
  final Color textColor;
  final Color? borderColor;
  final double height;
  final double borderRadius;
  final double fontSize;
  final FontWeight fontWeight;
  final bool isOutlined;
  final Widget? child;
  final IconData? icon; // ✅ new field

  const CustomAppButton({
    Key? key,
    required this.label,
    required this.onPressed,
    this.color = ColorResource.primaryBlue,
    this.textColor = Colors.white,
    this.borderColor,
    this.height = 50,
    this.borderRadius = 12,
    this.fontSize = 16,
    this.fontWeight = FontWeight.w600,
    this.isOutlined = false,
    this.child,
    this.icon, // ✅ icon parameter
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isOutlineStyle = isOutlined || color == Colors.white;

    return SizedBox(
      height: height,
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: isOutlineStyle ? Colors.white : color,
          foregroundColor: textColor,
          side: isOutlineStyle
              ? BorderSide(color: borderColor ?? Colors.grey.shade400, width: 1.2)
              : BorderSide.none,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          textStyle: TextStyle(
            fontSize: fontSize,
            fontWeight: fontWeight,
          ),
          elevation: isOutlineStyle ? 0 : 2,
        ),
        onPressed: onPressed,
        child: child ??
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: fontSize,
                    fontWeight: fontWeight,
                    color: textColor,
                  ),
                ),
                if (icon != null) ...[
                  const SizedBox(width: 8),
                  Icon(
                    icon,
                    color: textColor,
                    size: fontSize + 2,
                  ),
                ]
              ],
            ),
      ),
    );
  }
}
