import 'package:flutter/material.dart';
import 'package:health_care/core/api_service/app_url.dart';
import 'package:health_care/core/utils/custom_widgets/custom_appBar.dart';
import 'package:health_care/core/utils/custom_widgets/custom_image_view.dart';
import 'package:health_care/core/utils/custom_widgets/custom_refresh.dart';
import 'package:health_care/core/utils/custom_widgets/custom_searchBar.dart';
import 'package:health_care/core/utils/custom_widgets/custom_text.dart';
import 'package:health_care/core/utils/navigation_helper.dart';
import 'package:health_care/core/utils/theams/color_resource.dart';
import 'package:provider/provider.dart';
import '../../../core/utils/custom_widgets/custom_app_button.dart';
import '../../../core/utils/custom_widgets/custom_threeDots_indecator.dart';
import '../../../core/utils/global_variables.dart';
import '../model/consultant_list_model.dart';
import '../view_model/consultants_list_viewModel.dart';
import 'book_appointment.dart';
import 'consultant_profile.dart';


class ConsultantListScreen extends StatefulWidget {
  final bool isEmergency;
  const ConsultantListScreen({super.key,this.isEmergency = false});

  @override
  State<ConsultantListScreen> createState() => _ConsultantListScreenState();
}

class _ConsultantListScreenState extends State<ConsultantListScreen> {
  final TextEditingController searchConsultantController = TextEditingController();

  final categories = ['In-clinic Appointment', 'Video Appointment'];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _fetchData());
  }


  void _fetchData() {
    final viewModel = Provider.of<ConsultantListViewModel>(context, listen: false);
    final tabType = globalTabType == 'inClinic' ? 'inclineConsultant' : 'videoConsultant';
    viewModel.fetchDoctors(globalSpecializationCategoryId, tabType);
    searchConsultantController.clear();
  }


  @override
  Widget build(BuildContext context) {
    return CustomRefreshIndicator(
      onRefresh: ()async{
        _fetchData();
      },
      child: Scaffold(
        backgroundColor: ColorResource.white,
        appBar: const CustomAppBar(title: 'Doctors'),
        body: Padding(
          padding: const EdgeInsets.only(bottom: 15, left: 15, right: 15),
          child: Column(
            children: [
              Consumer<ConsultantListViewModel>(
                builder: (context, provider, _) {
                  return CustomSearchBar(
                    hintText: "Search Consultant",
                    prefixIcon: Icon(Icons.search, color: Colors.grey.shade500),
                    controller: searchConsultantController,
                    onChanged: provider.filterDoctors,
                  );
                },
              ),
              const SizedBox(height: 20),
              _buildCategoryToggle(),
              const SizedBox(height: 20),
              Consumer<ConsultantListViewModel>(
                builder: (context, provider, _) {
                  if (provider.isLoading) {
                    return const Expanded(child: Center(child: ThreeDotsLoader()));
                  }

                  if (provider.doctors.isEmpty) {
                    return const Expanded(child: Center(child: Text("No doctors found.")));
                  }

                  return Expanded(
                    child: ListView.builder(
                      itemCount: provider.doctors.length,
                      itemBuilder: (context, index) {
                        final model = provider.doctors[index];
                        return _doctorCard(context, model);
                      },
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryToggle() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: categories.map((category) {
          final isSelected = (globalTabType == 'inClinic' && category == 'In-clinic Appointment') ||
              (globalTabType == 'videoAppointment' && category == 'Video Appointment');

          return Expanded(
            child: GestureDetector(
                onTap: () {
                  setState(() {
                    globalTabType = category == 'In-clinic Appointment' ? 'inClinic' : 'videoAppointment';
                  });
                  _fetchData();
                },
                child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: isSelected ? ColorResource.primaryBlue : Colors.transparent,
                  borderRadius: BorderRadius.circular(8),
                ),
                alignment: Alignment.center,
                child: Text(
                  category,
                  style: TextStyle(
                    color: isSelected ? Colors.white : Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _doctorCard(BuildContext context, ConsultantListData model) {
    return GestureDetector(
      onTap: (){
        navSlideFromRight(context,ConsultantDetailsScreen(consultantId: model.sId??'',) );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: ColorResource.lightBlue,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 28,
                  backgroundColor: Colors.transparent,
                  child: ClipOval(
                    child: CustomImageView(
                      imagePath: model.profileImage != null
                          ? '${AppUrl.baseUrl}/${model.profileImage!}'
                          : null,
                      height: 56,
                      width: 56,
                      fit: BoxFit.cover,
                      placeHolder: 'assets/images/imageNotFound.png',
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(text: model.name ?? "Unknown"),
                      const SizedBox(height: 4),
                      CustomText(
                        text: (model.department?.join(', ') ?? ''),
                        fontSize: 13,
                        color: Colors.black,
                      ),
                      CustomText(
                        text: '${model.yearOfExp ?? '0'} Years Experience',
                        fontSize: 13,
                        color: Colors.grey,
                      ),
                      Row(
                        children: [
                          const Icon(Icons.location_on, color: Colors.grey, size: 14),
                          const SizedBox(width: 4),
                          Expanded(
                            child: CustomText(
                              text: model.address ?? "N/A",
                              fontSize: 12,
                              color: Colors.grey,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),

                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            CustomText(
              text: '₹${globalTabType == 'inClinic' ? model.inClinicFee : model.videoConsultFee} Consultation Fee',
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: CustomAppButton(
                    onPressed: () {},
                    label: 'Contact',
                    borderColor: ColorResource.primaryBlue,
                    color: ColorResource.white,
                    textColor: ColorResource.primaryBlue,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child:
                  CustomAppButton(
                    onPressed: () {
                      navSlideFromRight(
                       context,
                        BookAppointment(
                          consultantId: model.sId ?? '',
                          isEmergency: widget.isEmergency,
                        ),
                      );
                    },
                    label: 'Book Now',
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

