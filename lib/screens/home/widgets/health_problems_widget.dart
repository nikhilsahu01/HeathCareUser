import 'package:flutter/material.dart';
import 'package:health_care/core/api_service/app_url.dart';
import 'package:health_care/core/utils/custom_widgets/custom_image_view.dart';
import 'package:health_care/core/utils/navigation_helper.dart';

import '../../../core/utils/custom_widgets/custom_app_button.dart';
import '../../../core/utils/custom_widgets/custom_text.dart';
import '../../../core/utils/global_variables.dart';
import '../../../core/utils/theams/color_resource.dart';
import '../../all_category_list/screen/categories_list_screen.dart';
import '../../booking/ui/booking_type.dart';
import '../model/home_model.dart';

class FindDoctorCategoriesWidget extends StatefulWidget {
  final List<Categories> categories;

  const FindDoctorCategoriesWidget({super.key, required this.categories});

  @override
  State<FindDoctorCategoriesWidget> createState() => _FindDoctorCategoriesWidgetState();
}

class _FindDoctorCategoriesWidgetState extends State<FindDoctorCategoriesWidget> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CustomText(text: "Find a Doctor for your Health Problem"),
        const SizedBox(height: 16),
        LayoutBuilder(
          builder: (context, constraints) {
            final itemWidth = (constraints.maxWidth - 24) / 3;

            return Wrap(
              spacing: 12,
              runSpacing: 12,
              children: List.generate(
                  widget.categories.length > 3 ? 3 : widget.categories.length,
                      (index) {
                    final item = widget.categories[index];
                    final isSelected = selectedIndex == index;

                    return GestureDetector(
              // children: List.generate(widget.categories.length, (index) {
              //   final item = widget.categories[index];
              //   final isSelected = selectedIndex == index;
              //
              //   return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedIndex = index;
                    });

                    globalSpecializationCategoryId = item.sId ?? '';
                    navSlideFromRight( context, BookingTypeScreen(isBack: true, byPassSymptomsAndCategoryScreen: true));
                  },
                  child: Container(
                    width: itemWidth,
                    height: 110,
                    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                    decoration: BoxDecoration(
                      color: isSelected ? ColorResource.lightBlue : Colors.white,
                      border: Border.all(
                        color: isSelected ? ColorResource.primaryBlue : Colors.grey.shade200,
                        width: isSelected ? 2 : 1,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomImageView(
                          imagePath: '${AppUrl.baseUrl}/${item.image}' ?? "assets/images/emergencyIcon.png", // Placeholder icon
                          height: 32,
                          width: 32,
                          fit: BoxFit.contain,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          item.name ?? "Unknown",
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: isSelected ? ColorResource.primaryBlue : ColorResource.darkText,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            );
          },
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(  onTap: () {
              navSlideFromRight(context, const CategoriesListScreen());
            }, child: Text("See More >>",style: TextStyle(fontWeight: FontWeight.w600,color: ColorResource.primaryBlue,),textAlign: TextAlign.center,)),
          ],
        ),
        // CustomAppButton(
        //   label: "See More",
        //   onPressed: () {
        //     navSlideFromRight(context, const CategoriesListScreen());
        //   },
        //   color: ColorResource.primaryBlue,
        //   textColor: Colors.white,
        //   borderColor: Colors.transparent,
        //   borderRadius: 12,
        //   height: 48,
        //   fontSize: 16,
        //   fontWeight: FontWeight.bold,
        // ),
      ],
    );
  }
}
