
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/api_service/app_url.dart';
import '../../../core/utils/custom_widgets/custom_appBar.dart';
import '../../../core/utils/custom_widgets/custom_image_view.dart';
import '../../../core/utils/custom_widgets/custom_searchBar.dart';
import '../../../core/utils/custom_widgets/custom_text.dart';
import '../../../core/utils/custom_widgets/custom_threeDots_indecator.dart';
import '../../../core/utils/global_variables.dart';
import '../../../core/utils/navigation_helper.dart';
import '../../../core/utils/theams/color_resource.dart';
import '../../booking/ui/booking_type.dart';
import '../viewmodel/symptoms_list_viewModel.dart';

class AllHealthIssuesListScreen extends StatefulWidget {
  const AllHealthIssuesListScreen({super.key});

  @override
  State<AllHealthIssuesListScreen> createState() => _AllHealthIssuesListScreenState();
}

class _AllHealthIssuesListScreenState extends State<AllHealthIssuesListScreen> {
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<AllHealthIssuesListViewmodel>(context, listen: false).fetchSymptoms();
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final itemWidth = (screenWidth - 16 * 2 - 12 * 3) / 4; // 16 padding, 3 gaps of 12px

    return Scaffold(
      backgroundColor: ColorResource.white,
      appBar: const CustomAppBar(title: "Select Health Issues"),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Consumer<AllHealthIssuesListViewmodel>(
          builder: (context, viewModel, _) {
            if (viewModel.isLoading) {
              return const Center(child: ThreeDotsLoader());
            }

            final symptoms = viewModel.categories;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // const SizedBox(height: 12),
                CustomSearchBar(
                  hintText: "Search...",
                  controller: searchController,
                  prefixIcon: Icon(Icons.search, color: Colors.grey.shade500),
                  onChanged: viewModel.updateSearchQuery,
                ),
                const SizedBox(height: 20),
                if (symptoms.isEmpty)
                  const Expanded(
                    child: Center(child: CustomText(text: "No Health Issues available.")),
                  )
                else
                  Expanded(
                    child: GridView.builder(
                      itemCount: symptoms.length,
                      padding: const EdgeInsets.only(bottom: 20),
                      physics: const BouncingScrollPhysics(),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4,
                        mainAxisSpacing: 16,
                        crossAxisSpacing: 12,
                        childAspectRatio: 0.72,
                      ),
                      itemBuilder: (context, index) {
                        final issue = symptoms[index];
                        return GestureDetector(
                          onTap: () {
                            if (issue.sId != null) {
                              globalSymptomId.add(issue.sId!);
                            }
                            navSlideFromRight(
                              context,
                              BookingTypeScreen(isBack: true, byPassSymptomsScreen: true),
                            );
                          },
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                width: 60,
                                height: 60,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(color: ColorResource.primaryBlue),
                                ),
                                child: Center(
                                  child: issue.image != null
                                      ? CustomImageView(
                                    imagePath: '${AppUrl.baseUrl}/${issue.image!}',
                                    height: 40,
                                    width: 40,
                                    fit: BoxFit.contain,
                                  )
                                      : const Icon(Icons.healing, color: Colors.grey),
                                ),
                              ),
                              const SizedBox(height: 8),
                              SizedBox(
                                width: itemWidth,
                                child: Text(
                                  issue.name ?? "",
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
                          ),
                        );
                      },
                    ),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}

