import 'package:flutter/material.dart';
import 'package:health_care/core/utils/custom_widgets/custom_text.dart';
import 'package:health_care/core/utils/navigation_helper.dart';

import '../theams/color_resource.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool isBack;
  final bool isProfile;

  const CustomAppBar({
    super.key,
    required this.title,
    this.isBack = true,
    this.isProfile = false,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = isProfile;
    final themeColor = isDark ? ColorResource.white : ColorResource.darkText;

    return Container(
      color: isDark ? ColorResource.primaryBlue : ColorResource.white,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
      child: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (isBack)
              GestureDetector(
                onTap: () => navPop(context: context),
                child: Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    color: ColorResource.primaryBlue,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Icon(Icons.arrow_back, size: 20, color: Colors.white),
                ),
              )
            else
              const SizedBox(width: 40),
            Expanded(
              child: Center(
                child: CustomText(
                  text: title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                  color: themeColor,

                ),
              ),
            ),
            const SizedBox(width: 40),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(80);
}
