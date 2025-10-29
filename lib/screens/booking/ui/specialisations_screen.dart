import 'package:flutter/material.dart';
import 'package:health_care/core/utils/custom_widgets/custom_app_button.dart';
import 'package:health_care/core/utils/custom_widgets/custom_threeDots_indecator.dart';
import 'package:health_care/core/utils/global_variables.dart';
import 'package:health_care/core/utils/helper_functions/helpers_methods.dart';
import 'package:provider/provider.dart';
import '../../../core/api_service/app_url.dart';
import '../../../core/utils/custom_widgets/custom_appBar.dart';
import '../../../core/utils/custom_widgets/custom_image_view.dart';
import '../../../core/utils/custom_widgets/custom_searchBar.dart';
import '../../../core/utils/custom_widgets/custom_text.dart';
import '../../../core/utils/navigation_helper.dart';
import '../../../core/utils/theams/color_resource.dart';
import '../view_model/specialisation_viewModel.dart';
import 'consultant_List_screen.dart';

class SpecialisationsScreen extends StatefulWidget {
  final List<String> selectedCategoryIds;
  final bool isEmergency;
  const SpecialisationsScreen({super.key, required this.selectedCategoryIds,this.isEmergency = false});

  @override
  State<SpecialisationsScreen> createState() => _SpecialisationsScreenState();
}

class _SpecialisationsScreenState extends State<SpecialisationsScreen> {
  int selectedIndex = -1;
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<SpecialisationsViewModel>(context, listen: false).fetchSpecialisationData(widget.selectedCategoryIds);
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Consumer<SpecialisationsViewModel>(
      builder: (context, viewModel, child) {
        final filteredCategories = viewModel.filteredCategories;

        return Scaffold(
          backgroundColor: ColorResource.white,
          appBar: const CustomAppBar(title: 'Specialisations'),
          body: viewModel.isLoading
              ? const Center(child: ThreeDotsLoader())
              : SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomSearchBar(
                  hintText: "Search...",
                  prefixIcon: Icon(Icons.search, color: Colors.grey.shade500),
                  controller: searchController,
                  onChanged: (value) {
                    viewModel.updateSearchQuery(value);
                    setState(() {
                      selectedIndex = -1; // reset selection on search
                    });
                  },
                ),
                const SizedBox(height: 20),
                const CustomText(
                  text: 'Consult the Right Specialist',
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                const SizedBox(height: 20),
                if (filteredCategories.isNotEmpty)
                  LayoutBuilder(
                    builder: (context, constraints) {
                      final itemWidth = (constraints.maxWidth - 24) / 3;

                      return Wrap(
                        spacing: 12,
                        runSpacing: 12,
                        children: List.generate(filteredCategories.length, (index) {
                          final item = filteredCategories[index];
                          final isSelected = selectedIndex == index;

                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedIndex = index;
                              });
                            },
                            child: Container(
                              width: itemWidth,
                              height: 110,
                              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                              decoration: BoxDecoration(
                                color: isSelected ? ColorResource.lightBlue : Colors.white,
                                border: Border.all(
                                  color: isSelected
                                      ? ColorResource.primaryBlue
                                      : Colors.grey.shade200,
                                  width: isSelected ? 2 : 1,
                                ),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CustomImageView(
                                    imagePath: '${AppUrl.baseUrl}/${item.image}',
                                    height: 32,
                                    width: 32,
                                    fit: BoxFit.contain,
                                    placeHolder: "assets/images/emergencyIcon.png",
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
                                      color: isSelected
                                          ? ColorResource.primaryBlue
                                          : ColorResource.darkText,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }),
                      );
                    },
                  )
                else
                  const Padding(
                    padding: EdgeInsets.only(top: 40),
                    child: Text("No specialisations matched your search."),
                  ),
                const SizedBox(height: 30),
              ],
            ),
          ),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.all(16),
            child: CustomAppButton(
              label: 'Proceed',
              onPressed: () {
                if (selectedIndex == -1) {
                  HelperMethods.showCustomSnackbar(context, message: 'Please select a preferred category.');
                } else {
                  final selectedCategoryId = filteredCategories[selectedIndex].sId;
                  globalSpecializationCategoryId = selectedCategoryId!;
                  navSlideFromRight(context,ConsultantListScreen(isEmergency: widget.isEmergency,));
                }
              },
            ),
          ),
        );
      },
    );
  }
}