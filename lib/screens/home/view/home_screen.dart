import 'package:flutter/material.dart';
import 'package:health_care/core/utils/custom_widgets/custom_app_button.dart';
import 'package:health_care/core/utils/custom_widgets/custom_image_view.dart';
import 'package:health_care/core/utils/navigation_helper.dart';
import 'package:health_care/core/utils/theams/color_resource.dart';
import 'package:health_care/screens/home/view_model/home_viewModel.dart';
import 'package:provider/provider.dart';
import '../../../core/utils/custom_widgets/custom_refresh.dart';
import '../../../core/utils/custom_widgets/custom_text.dart';
import '../../../core/utils/custom_widgets/custom_threeDots_indecator.dart';
import '../../after_care/view/after_care_screen.dart';
import '../../appointments/view/appointments_Screen.dart';
import '../../booking/ui/booking_type.dart';
import '../../booking/ui/symptoms_list_screen.dart';
import '../../emergency_services/ui/emergency_services.dart';
import '../../location_screen/address_provider.dart';
import '../../services/my_health_record/view/my_health_records_screen.dart';
import '../widgets/CustomHomeAppBar.dart';
import '../widgets/circularButtonsRow.dart';
import '../widgets/healthIssues_widgets.dart';
import '../widgets/health_problems_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final pro = Provider.of<HomeViewModel>(context, listen: false);
      pro.fetchHomeData();
      Provider.of<AddressViewModel>(context, listen: false).fetchAddresses();
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return CustomRefreshIndicator( 
      onRefresh: ()=> Provider.of<HomeViewModel>(context, listen: false).fetchHomeData(),
      child: Scaffold(
        backgroundColor: ColorResource.white,
        appBar: CustomHomeAppBar(height: screenHeight),
        body: Consumer<HomeViewModel>(builder: (context, viewModel,child){
          if (viewModel.isLoading) {
            return Center(child: ThreeDotsLoader());
          }

          if (viewModel.errorMessage != null) {
            return Center(child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(viewModel.errorMessage!),
                CustomAppButton(label: 'Retry',color: ColorResource.white,textColor: ColorResource.primaryBlue, onPressed: (){
                  final pro = Provider.of<HomeViewModel>(context, listen: false);
                  pro.fetchHomeData();
                })
              ],
            ));
          }

          final homeData = viewModel.homeDataModel;
          return  Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          RichText(
                            text: TextSpan(
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 17,
                                color: ColorResource.darkText,
                              ),
                              children: [
                                TextSpan(text: "Upcoming Appointments "),
                                WidgetSpan(
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 2,
                                    ),
                                    decoration: BoxDecoration(
                                      color: ColorResource.primaryBlue,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Text(
                                      "3",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          GestureDetector(
                            child: Text(
                              "See All",
                              style: TextStyle(
                                color: ColorResource.primaryBlue,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            onTap: () {
                              navSlideFromRight(context,AppointmentScreen());
                            },
                          ),
                        ],
                      ),
                      SizedBox(height: screenHeight * 0.02),
                      ///appointment card container
                      Container(
                        decoration: BoxDecoration(
                          color: ColorResource.primaryBlue,
                          borderRadius: BorderRadius.circular(6),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.08),
                              blurRadius: 6,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        padding: EdgeInsets.all(14),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Container(
                                  child: CircleAvatar(
                                    radius: 28,
                                    backgroundImage: NetworkImage(
                                      'https://images.unsplash.com/photo-1607746882042-944635dfe10e?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80',
                                    ),
                                  ),
                                  height: 40,
                                ),
                                //SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Dr. Leena Bhusan",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14,
                                        ),
                                      ),
                                      SizedBox(height: 4),
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 8,
                                          vertical: 4,
                                        ),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(12),
                                        ),
                                        child: Text(
                                          "Dermatologist",
                                          style: TextStyle(
                                            color: ColorResource.primaryBlue,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 10,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    // Placeholder for call action
                                  },
                                  borderRadius: BorderRadius.circular(40),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.white,
                                    ),
                                    padding: EdgeInsets.all(8),
                                    child: Icon(
                                      Icons.call,
                                      color: ColorResource.primaryBlue,
                                      size: 24,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 14),
                            Container(
                              width: double.infinity,
                              child: Row(
                                children: [
                                  Container(
                                    width: (MediaQuery.of(context).size.width - 1) / 2-31,
                                    padding: EdgeInsets.symmetric(vertical: 14),
                                    decoration: BoxDecoration(
                                      color: ColorResource.gradientLightBlue,
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(6),
                                        bottomLeft: Radius.circular(6),
                                      ),
                                    ),
                                    alignment: Alignment.center,
                                    child: Text(
                                      "Tuesday 6 May",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 15,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: 1,
                                    height: 40,
                                    color: Colors.white.withOpacity(0.5),
                                  ),
                                  Container(
                                    width: (MediaQuery.of(context).size.width - 1) / 2-31,
                                    padding: EdgeInsets.symmetric(vertical: 14),
                                    decoration: BoxDecoration(
                                      color: ColorResource.gradientLightBlue,
                                      borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(6),
                                        bottomRight: Radius.circular(6),
                                      ),
                                    ),
                                    alignment: Alignment.center,
                                    child: Text(
                                      "10:30AM - 12:00AM",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 15,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.02),
                      Row(
                        children: [
                          Expanded(
                            child: CustomImageView(
                              onTap: (){
                                navSlideFromRight( context,const BookingTypeScreen(isBack: true,));
                              },
                              imagePath: 'assets/images/bookAppointmentHomeIcon.png',
                            ),
                          ),
                          SizedBox(width: 14),
                          Expanded(
                            child: CustomImageView(
                              imagePath: 'assets/images/myhelthRecHomeIcon.png',
                              onTap: (){
                                navSlideFromRight(context, const MyHealthAndRecords());
                              },
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: screenHeight * 0.02),
                      GestureDetector(
                        onTap: (){
                          navFade(context, const EmergencyServicesScreen());
                        },
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 6,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CustomImageView(
                                imagePath: 'assets/icons/emergencyIcon.png',
                                height: 42,
                                width: 42,
                              ),
                              const SizedBox(width: 10),
                              const Expanded(
                                child: Text(
                                  "Emergency Services",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 17,
                                  ),
                                ),
                              ),
                              CustomImageView(
                                imagePath: 'assets/images/forwardArrowRed.png',
                                height: 40,
                                width: 40,
                              ),
                            ],
                          ),
                        )
                      ),
                      SizedBox(height: screenHeight * 0.02),
                      CustomText(text: "Daily Dose Reminder"),
                      SizedBox(height: screenHeight * 0.02),
                      GestureDetector(
                        onTap: (){
                          navSlideFromRight(context, AfterCareScreen());
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 6,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          padding: EdgeInsets.symmetric(vertical: 14, horizontal: 8),
                          child: Row(
                            children: [
                              Container(
                                padding: EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color(0xFFC9DFFE),
                                ),
                                child: CustomImageView(
                                  imagePath:
                                  'https://cdn-icons-png.flaticon.com/512/2551/2551677.png',
                                  width: 48,
                                  height: 48,
                                ),
                              ),
                              SizedBox(width: 14),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CustomText(text: "Multivitamin", fontSize: 16),
                                    CustomText(text: "After Lunch", fontSize: 14),
                                  ],
                                ),
                              ),
                              SizedBox(width: 12),
                              Container(
                                width: 70,
                                height: 70,
                                decoration: BoxDecoration(
                                  color: ColorResource.pillBlue,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Center(
                                  child: Text(
                                    "1\nTablet",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                      fontSize: 16,
                                      height: 1.2,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.03),
                      FindDoctorCategoriesWidget(categories: homeData?.data?.categories ?? []),
                      SizedBox(height: screenHeight * 0.03),
                      CommonHealthIssueWidget(//todo this shdoul also cover whole row....
                        issues: homeData?.data?.symptoms?.map((symptom) {
                          return {
                            "iconPath": "${symptom.image}",
                            "label": symptom.name ?? "Unknown",
                            "symptomsId":symptom.sId?? '',
                          };
                        }).toList() ?? [],
                      ),
                      SizedBox(height: screenHeight * 0.02),
                      Container(
                        width: double.infinity,
                        color: ColorResource.lightGreenBackground,
                        padding: EdgeInsets.symmetric(vertical: 16),
                        child: CustomText(
                          text: "Together, We Make Healthcare Affordable and Accessible",
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.02),
                      const CircularButtonRow(),
                      SizedBox(height: screenHeight * 0.2),
                    ],
                  ),
                ),
              ),
            ],
          );
        })
      ),
    );
  }
}
