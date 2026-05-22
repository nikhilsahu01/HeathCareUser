import 'package:flutter/material.dart';
import 'package:health_care/core/utils/custom_widgets/custom_threeDots_indecator.dart';
import 'package:provider/provider.dart';
import '../../../core/api_service/app_url.dart';
import '../../../core/utils/custom_widgets/custom_appBar.dart';
import '../../../core/utils/custom_widgets/custom_image_view.dart';
import '../../../core/utils/custom_widgets/custom_searchBar.dart';
import '../../../core/utils/custom_widgets/custom_text.dart';
import '../../../core/utils/global_variables.dart';
import '../../../core/utils/navigation_helper.dart';
import '../../../core/utils/theams/color_resource.dart';
import '../../booking/ui/booking_type.dart';
import '../viewModel/categories_list_viewModel.dart';


class CategoriesListScreen extends StatefulWidget {
  const CategoriesListScreen({super.key});

  @override
  State<CategoriesListScreen> createState() => _CategoriesListScreenState();
}

class _CategoriesListScreenState extends State<CategoriesListScreen> {
  int selectedIndex = -1;
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<CategoriesListViewmodel>(context, listen: false).fetchCategories();
    });
  }

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorResource.white,
      appBar: const CustomAppBar(title: "Select Category"),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Consumer<CategoriesListViewmodel>(
          builder: (context, viewModel, _) {
            if (viewModel.isLoading) {
              return const Center(child: ThreeDotsLoader());
            }

            if (viewModel.categories.isEmpty) {
              return const Center(child: CustomText(text: "No categories available."));
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomSearchBar(
                  hintText: "Search...",
                  prefixIcon: Icon(Icons.search, color: Colors.grey.shade500),
                  controller: searchController,
                  onChanged: (value) {
                    viewModel.updateSearchQuery(value);
                    setState(() {
                      selectedIndex = -1;
                    });
                  },
                ),
                const SizedBox(height: 20),
                LayoutBuilder(
                  builder: (context, constraints) {
                    final itemWidth = (constraints.maxWidth - 24) / 3;
                    return Wrap(
                      spacing: 12,
                      runSpacing: 12,
                      children: List.generate(viewModel.categories.length, (index) {
                        final item = viewModel.categories[index];
                        final isSelected = selectedIndex == index;

                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedIndex = index;
                            });

                            globalSpecializationCategoryId = item.sId ?? '';
                            navSlideFromRight(context,BookingTypeScreen(isBack: true, byPassSymptomsAndCategoryScreen: true));
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
                                  imagePath: item.image != null
                                      ? '${AppUrl.baseUrl}/${item.image}'
                                      : "assets/images/emergencyIcon.png",
                                  height: 32,
                                  width: 32,
                                  fit: BoxFit.contain,
                                ),
                                const SizedBox(height: 8),
                                CustomText(
                                  text: item.name ?? "Unknown",
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: isSelected
                                      ? ColorResource.primaryBlue
                                      : ColorResource.darkText,
                                  textAlign: TextAlign.center,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                    );
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
