import 'package:flutter/material.dart';
import 'package:health_care/core/api_service/app_url.dart';
import 'package:health_care/core/utils/custom_widgets/custom_image_view.dart';

import '../../../core/utils/custom_widgets/custom_text.dart';
import '../../../core/utils/global_variables.dart';
import '../../../core/utils/navigation_helper.dart';
import '../../../core/utils/theams/color_resource.dart';
import '../../all_health_issues_list/view/all_health_issues_list.dart';
import '../../booking/ui/booking_type.dart';

class CommonHealthIssueWidget extends StatelessWidget {
  final List<Map<String, String>> issues;

  const CommonHealthIssueWidget({super.key, required this.issues});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    // Show max 3 issues + "See More +" if more available
    final visibleIssues = issues.length > 3 ? issues.sublist(0, 3) : issues;
    final showSeeMore = issues.length > 3;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CustomText(text: "Common Health Issue"),
        const SizedBox(height: 16),
        SizedBox(
          height: 110,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: visibleIssues.length + (showSeeMore ? 1 : 0),
            separatorBuilder: (context, index) => const SizedBox(width: 16),
            itemBuilder: (context, index) {
              if (showSeeMore && index == visibleIssues.length) {
                // See More button
                return Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        navSlideFromRight(context, const AllHealthIssuesListScreen());
                      },
                      child: Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: ColorResource.primaryBlue),
                        ),
                        child: const Center(
                          child: Text(
                            "More+",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 10,
                              color: ColorResource.darkText,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    const SizedBox(
                      width: 70,
                      child: Text(
                        "See More",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: ColorResource.darkText,
                        ),
                      ),
                    ),
                  ],
                );
              }

              final issue = visibleIssues[index];
              final isMore = issue['label'] == 'More';

              return Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      if (issue['symptomsId'] != null) {
                        globalSymptomId.add(issue['symptomsId']!);
                      }
                      navSlideFromRight(
                        context,
                        BookingTypeScreen(
                          isBack: true,
                          byPassSymptomsScreen: true,
                        ),
                      );
                    },
                    child: Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: ColorResource.primaryBlue),
                      ),
                      child: Center(
                        child: isMore
                            ? Text(
                          issue['iconPath'] ?? '',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: ColorResource.darkText,
                          ),
                        )
                            : CustomImageView(
                          imagePath: '${AppUrl.baseUrl}/${issue['iconPath']!}',
                          height: 42,
                          width: 42,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    width: 70,
                    child: Text(
                      issue['label']!,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: ColorResource.darkText,
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
