import 'package:flutter/material.dart';

import 'package:health_care/core/utils/navigation_helper.dart';
import 'package:health_care/core/utils/theams/color_resource.dart';
import 'package:health_care/screens/home/view_model/home_viewModel.dart';
import 'package:provider/provider.dart';
import '../../../core/utils/custom_widgets/custom_refresh.dart';
import '../../../core/utils/custom_widgets/custom_text.dart';
import '../../../core/utils/custom_widgets/custom_threeDots_indecator.dart';
import '../../after_care/view/after_care_screen.dart';
import '../../after_care/viewmodel/aftercare_viewmodel.dart';
import '../../appointments/view/appointments_Screen.dart';
import '../../appointments/viewModel/appointments_viewModel.dart';
import '../../booking/ui/booking_type.dart';
import '../../booking/ui/symptoms_list_screen.dart';
import '../../emergency_services/ui/emergency_services.dart';
import '../../location_screen/address_provider.dart';
import '../../services/my_health_record/view/my_health_records_screen.dart';
import '../widgets/CustomHomeAppBar.dart';
import '../widgets/circularButtonsRow.dart';
import '../widgets/healthIssues_widgets.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../widgets/health_problems_widget.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../core/api_service/app_url.dart';
import '../../../core/utils/helper_functions/helpers_methods.dart';
import '../../VideoCall/agoraVideoCall.dart';
import 'dart:async';
import 'package:intl/intl.dart';
//
// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});
//
//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }
//
// class _HomeScreenState extends State<HomeScreen> {
//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       final pro = Provider.of<HomeViewModel>(context, listen: false);
//       pro.fetchHomeData();
//       Provider.of<AddressViewModel>(context, listen: false).fetchAddresses();
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     double screenHeight = MediaQuery.of(context).size.height;
//     double screenWidth = MediaQuery.of(context).size.width;
//     return CustomRefreshIndicator(
//       onRefresh: ()=> Provider.of<HomeViewModel>(context, listen: false).fetchHomeData(),
//       child: Scaffold(
//         backgroundColor: ColorResource.white,
//         appBar: CustomHomeAppBar(height: screenHeight),
//         body: Consumer<HomeViewModel>(builder: (context, viewModel,child){
//           if (viewModel.isLoading) {
//             return Center(child: ThreeDotsLoader());
//           }
//
//           if (viewModel.errorMessage != null) {
//             return Center(child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Text(viewModel.errorMessage!),
//                 CustomAppButton(label: 'Retry',color: ColorResource.white,textColor: ColorResource.primaryBlue, onPressed: (){
//                   final pro = Provider.of<HomeViewModel>(context, listen: false);
//                   pro.fetchHomeData();
//                 })
//               ],
//             ));
//           }
//
//           final homeData = viewModel.homeDataModel;
//           return  Column(
//             children: [
//               Expanded(
//                 child: SingleChildScrollView(
//                   padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           RichText(
//                             text: TextSpan(
//                               style: TextStyle(
//                                 fontWeight: FontWeight.w600,
//                                 fontSize: 16,
//                                 color: ColorResource.darkText,
//                               ),
//                               children: [
//                                 TextSpan(text: "Upcoming Appointments "),
//                                 WidgetSpan(
//                                   child: Container(
//                                     padding: EdgeInsets.symmetric(
//                                       horizontal: 7,
//                                       vertical: 2,
//                                     ),
//                                     decoration: BoxDecoration(
//                                       color: ColorResource.primaryBlue,
//                                       borderRadius: BorderRadius.circular(12),
//                                     ),
//                                     child: Text(
//                                       "3",
//                                       style: TextStyle(
//                                         color: Colors.white,
//                                         fontWeight: FontWeight.bold,
//                                         fontSize: 12
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                           GestureDetector(
//                             child: Text(
//                               "See All",
//                               style: TextStyle(
//                                 color: ColorResource.primaryBlue,
//                                 fontWeight: FontWeight.w600,
//                                 fontSize: 12
//                               ),
//                             ),
//                             onTap: () {
//                               navSlideFromRight(context,AppointmentScreen());
//                             },
//                           ),
//                         ],
//                       ),
//                       SizedBox(height: screenHeight * 0.02),
//                       ///appointment card container
//                       Container(
//                         decoration: BoxDecoration(
//                           gradient: LinearGradient(
//                             begin: Alignment.topLeft,
//                             end: Alignment.bottomRight,
//                             colors: [
//                               ColorResource.primaryBlue,
//                               Color(0xFF5A9CFF),
//                             ],
//                           ),
//                           borderRadius: BorderRadius.circular(20),
//                           boxShadow: [
//                             BoxShadow(
//                               color: ColorResource.primaryBlue.withOpacity(0.25),
//                               blurRadius: 16,
//                               offset: Offset(0, 8),
//                             ),
//                           ],
//                         ),
//                         padding: EdgeInsets.all(14),
//                         child: Column(
//                           children: [
//                             Row(
//                               children: [
//                                 Container(
//                                   child: CircleAvatar(
//                                     radius: 30,
//                                     backgroundImage: NetworkImage(
//                                       'https://images.unsplash.com/photo-1607746882042-944635dfe10e?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80',
//                                     ),
//                                   ),
//                                   height: 40,
//                                 ),
//                                 //SizedBox(width: 12),
//                                 Expanded(
//                                   child: Column(
//                                     crossAxisAlignment: CrossAxisAlignment.start,
//                                     children: [
//                                       Text(
//                                         "Dr. Leena Bhusan",
//                                         style: TextStyle(
//                                           color: Colors.white,
//                                           fontWeight: FontWeight.w500,
//                                           fontSize: 14,
//                                         ),
//                                       ),
//                                       SizedBox(height: 4),
//                                       Container(
//                                         padding: EdgeInsets.symmetric(
//                                           horizontal: 10,
//                                           vertical: 4,
//                                         ),
//                                         decoration: BoxDecoration(
//                                           color: Colors.white.withOpacity(0.25),
//                                           borderRadius: BorderRadius.circular(16),
//                                         ),
//                                         child: Text(
//                                           "Dermatologist",
//                                           style: TextStyle(
//                                             color: Colors.white,
//                                             fontSize: 12,
//                                             fontWeight: FontWeight.w500,
//                                           ),
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                                 InkWell(
//                                   onTap: () {
//                                     // Placeholder for call action
//                                   },
//                                   borderRadius: BorderRadius.circular(40),
//                                   child: Container(
//                                     decoration: BoxDecoration(
//                                       shape: BoxShape.circle,
//                                       color: Colors.white,
//                                     ),
//                                     padding: EdgeInsets.all(8),
//                                     child: Icon(
//                                       Icons.call,
//                                       color: ColorResource.primaryBlue,
//                                       size: 24,
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             SizedBox(height: 14),
//                             Row(
//                               children: [
//                                 Expanded(
//                                   child: _buildTimeChip("Tue, 6 May", Icons.calendar_today),
//                                 ),
//                                 SizedBox(width: 12),
//                                 Expanded(
//                                   child: _buildTimeChip("10:30 AM", Icons.access_time),
//                                 ),
//                               ],
//                             ),
//
//                           ],
//                         ),
//                       ),
//                       SizedBox(height: screenHeight * 0.02),
//
//                       Row(
//                         children: [
//                           Expanded(
//                             child: CustomImageView(
//                               onTap: (){
//                                 navSlideFromRight( context,const BookingTypeScreen(isBack: true,));
//                               },
//                               imagePath: 'assets/images/bookAppointmentHomeIcon.png',
//                             ),
//                           ),
//                           SizedBox(width: 14),
//                           Expanded(
//                             child: CustomImageView(
//
//                               imagePath: 'assets/images/myhelthRecHomeIcon.png',
//                               onTap: (){
//                                 navSlideFromRight(context, const MyHealthAndRecords());
//                               },
//                             ),
//                           ),
//                         ],
//                       ),
//                       SizedBox(height: screenHeight * 0.02),
//
//
//                       GestureDetector(
//                         onTap: () => navFade(context, const EmergencyServicesScreen()),
//                         child: AnimatedContainer(
//                           duration: Duration(milliseconds: 200),
//                           decoration: BoxDecoration(
//                             gradient: LinearGradient(
//                               colors: [Colors.red.shade50, Colors.white],
//                               begin: Alignment.topLeft,
//                             ),
//                             borderRadius: BorderRadius.circular(24),
//                             border: Border.all(
//                               color: Colors.grey.shade200,
//                               width:  1,
//                             ),
//                             boxShadow: [
//                               BoxShadow(
//                                 color: Colors.red.withOpacity(0.12),
//                                 blurRadius: 16,
//                                 offset: Offset(0, 8),
//                               ),
//                             ],
//                           ),
//                           padding: EdgeInsets.all(20),
//                           child: Row(
//                             children: [
//                               Container(
//                                 padding: EdgeInsets.all(10),
//                                 decoration: BoxDecoration(
//                                   color: Colors.red.shade100,
//                                   shape: BoxShape.circle,
//                                 ),
//                                 child: Image.asset('assets/icons/emergencyIcon.png', height: 30),
//                               ),
//                               SizedBox(width: 20),
//                               Expanded(
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Text(
//                                       "Emergency Services",
//                                       style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600,color: Colors.black),
//                                     ),
//                                     SizedBox(height: 4),
//                                     Text(
//                                       "24/7 • Immediate Help",
//                                       style: TextStyle(color: Colors.red.shade700, fontSize: 12),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                               Icon(Icons.arrow_forward_ios, color: Colors.red.shade400),
//                             ],
//                           ),
//                         ),
//                       ),
//                       SizedBox(height: screenHeight * 0.02),
//                       CustomText(text: "Daily Dose Reminder"),
//                       SizedBox(height: screenHeight * 0.02),
//                       GestureDetector(
//                         onTap: (){
//                           navSlideFromRight(context, AfterCareScreen());
//                         },
//                         child: AnimatedContainer(
//                           duration: Duration(milliseconds: 200),
//                           decoration: BoxDecoration(
//                             color: Colors.white,
//                             borderRadius: BorderRadius.circular(12),
//                             boxShadow: [
//                               BoxShadow(
//                                 color: Colors.black12,
//                                 blurRadius: 6,
//                                 offset: Offset(0, 2),
//                               ),
//                             ],
//                           ),
//                           padding: EdgeInsets.symmetric(vertical: 10, horizontal: 8),
//                           child: Row(
//                             children: [
//                               Container(
//                                 padding: EdgeInsets.all(12),
//                                 decoration: BoxDecoration(
//                                   shape: BoxShape.circle,
//                                   color: Color(0xFFC9DFFE),
//                                 ),
//                                 child: CustomImageView(
//                                   imagePath:
//                                   'https://cdn-icons-png.flaticon.com/512/2551/2551677.png',
//                                   width: 40,
//                                   height: 40,
//                                 ),
//                               ),
//                               SizedBox(width: 14),
//                               Expanded(
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     CustomText(text: "Multivitamin", fontSize: 14),
//                                     CustomText(text: "After Lunch", fontSize: 12,fontWeight: FontWeight.w500,),
//                                   ],
//                                 ),
//                               ),
//                               SizedBox(width: 12),
//                               Container(
//                                 width: 70,
//                                 height: 70,
//                                 decoration: BoxDecoration(
//                                   color: Colors.white,
//                                   border: Border.all(
//                                     color: Colors.grey.shade200,
//                                     width:  1,
//                                   ),
//                                   // boxShadow: [
//                                   //   BoxShadow(
//                                   //     color: Colors.black.withOpacity(0.08),
//                                   //     blurRadius: 12,
//                                   //     offset: const Offset(0, 4),
//                                   //   ),
//                                   //   BoxShadow(
//                                   //     color: Colors.black.withOpacity(0.04),
//                                   //     blurRadius: 4,
//                                   //     offset: const Offset(0, 2),
//                                   //   ),
//                                   //   // BoxShadow(
//                                   //   //   color: Colors.black.withOpacity(0.1),
//                                   //   //   blurRadius: 6,
//                                   //   //   spreadRadius: 1,
//                                   //   //   offset: const Offset(0, 3),
//                                   //   // ),
//                                   // ],
//                                   borderRadius: BorderRadius.circular(12),
//                                 ),
//                                 child: Center(
//                                   child: Text(
//                                     "1\nTablet",
//                                     textAlign: TextAlign.center,
//                                     style: TextStyle(
//                                       fontWeight: FontWeight.w600,
//                                       color: Colors.black,
//                                       fontSize: 15,
//                                       height: 1.2,
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                       SizedBox(height: screenHeight * 0.03),
//                       FindDoctorCategoriesWidget(categories: homeData?.data?.categories ?? []),
//                       SizedBox(height: screenHeight * 0.03),
//                       CommonHealthIssueWidget(//todo this shdoul also cover whole row....
//                         issues: homeData?.data?.symptoms?.map((symptom) {
//                           return {
//                             "iconPath": "${symptom.image}",
//                             "label": symptom.name ?? "Unknown",
//                             "symptomsId":symptom.sId?? '',
//                           };
//                         }).toList() ?? [],
//                       ),
//                       SizedBox(height: screenHeight * 0.02),
//                       Container(
//                         width: double.infinity,
//                         color: ColorResource.lightGreenBackground,
//                         padding: EdgeInsets.symmetric(vertical: 16),
//                         child: CustomText(
//                           text: "Together, We Make Healthcare Affordable and Accessible",
//                           textAlign: TextAlign.center,
//                         ),
//                       ),
//                       SizedBox(height: screenHeight * 0.02),
//                       const CircularButtonRow(),
//                       SizedBox(height: screenHeight * 0.2),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           );
//         })
//       ),
//     );
//   }
//   Widget _buildTimeChip(String text, IconData icon) {
//     return Container(
//       padding: EdgeInsets.symmetric(vertical: 12),
//       decoration: BoxDecoration(
//         color: Colors.white.withOpacity(0.18),
//         borderRadius: BorderRadius.circular(12),
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Icon(icon, color: Colors.white, size: 18),
//           SizedBox(width: 8),
//           Text(
//             text,
//             style: TextStyle(
//               color: Colors.white,
//               fontWeight: FontWeight.w600,
//               fontSize: 15,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<String> banners = [
    "assets/icons/banner.jpg",
    "assets/icons/banner2.jpg",
    "assets/icons/banner.jpg",


  ];

  int currentIndex = 0;
  Timer? _appointmentTimer;
  Set<String> _alertedAppointments = {};
  dynamic _activeAppointment;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<HomeViewModel>(context, listen: false).fetchHomeData();
      Provider.of<AddressViewModel>(context, listen: false).fetchAddresses();
      Provider.of<AppointmentViewModel>(context, listen: false).fetchUpcomingAppointments();
      Provider.of<AftercareViewModel>(context, listen: false).fetchMedicines();
    });
    _startAppointmentTimer();
  }

  @override
  void dispose() {
    _appointmentTimer?.cancel();
    super.dispose();
  }

  void _startAppointmentTimer() {
    _appointmentTimer = Timer.periodic(const Duration(seconds: 15), (timer) {
      if (!mounted) return;
      final aptVm = Provider.of<AppointmentViewModel>(context, listen: false);
      final upcoming = aptVm.upcomingAppointments;
      if (upcoming.isEmpty) {
        if (_activeAppointment != null) setState(() => _activeAppointment = null);
        return;
      }

      final now = DateTime.now();
      bool foundActive = false;

      for (var apt in upcoming) {
        if (apt.appointmentDate != null && apt.timeSlot != null) {
          try {
            // Parse "2026-05-30" or similar date format and "10:30 AM"
            String dateStr = apt.appointmentDate!;
            // TimeSlot might be like "10:00 AM - 11:00 AM", we take the first part
            String timeStr = apt.timeSlot!.split('-')[0].trim();
            DateTime aptTime = DateFormat("yyyy-MM-dd h:mm a").parse("$dateStr $timeStr");

            final diff = now.difference(aptTime).inMinutes;

            // If within -5 to +15 minutes of appointment
            if (diff >= -5 && diff <= 15) {
              foundActive = true;
              if (_activeAppointment != apt) {
                setState(() => _activeAppointment = apt);
              }

              // Show popup if not alerted yet
              if (!_alertedAppointments.contains(apt.sId)) {
                _alertedAppointments.add(apt.sId!);
                _showJoinPopup(apt);
              }
              break; // Handle one active appointment at a time
            }
          } catch (e) {
            debugPrint("Error parsing appointment time: $e");
          }
        }
      }

      if (!foundActive && _activeAppointment != null) {
        setState(() => _activeAppointment = null);
      }
    });
  }

  void _showJoinPopup(dynamic apt) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: Row(
            children: [
              Icon(Icons.video_call, color: ColorResource.primaryBlue, size: 28),
              SizedBox(width: 10),
              Text('Appointment Ready!'),
            ],
          ),
          content: Text("Dr. ${apt.vendor?.name ?? 'Your Doctor'} is waiting for you to join the call."),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: Text("Later", style: TextStyle(color: Colors.grey)),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
              onPressed: () async {
                Navigator.pop(ctx);
                final appointmentId = apt.sId ?? '';
                try {
                  final response = await http.get(Uri.parse('${AppUrl.videoCall}/$appointmentId/0'));
                  if (response.statusCode == 200) {
                    final json = jsonDecode(response.body);
                    final token = json['data']['token'] ?? '';
                    final channel = json['data']['channelName'] ?? appointmentId;
                    if (token.isNotEmpty) {
                      navSlideFromRight(context, AgoraVideoCallScreen(
                        channelName: channel,
                        token: token,
                        uid: 0,
                        appointmentId: appointmentId,
                      ));
                    }
                  } else {
                     HelperMethods.showFloatingToast(context, message: 'Failed to join call');
                  }
                } catch (e) {
                   HelperMethods.showFloatingToast(context, message: 'Error joining call');
                }
              },
              child: Text("Join Now", style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {

    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: ColorResource.white,
      appBar: CustomHomeAppBar(height: screenHeight),

      body: Consumer<HomeViewModel>(
        builder: (context, viewModel, child) {

          if (viewModel.isLoading) {
            return const Center(child: ThreeDotsLoader());
          }

          final homeData = viewModel.homeDataModel;

          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                // const SizedBox(height: 10),

                /// SEARCH BAR


                // const SizedBox(height: 25),

                /// FIND SPECIALIST


                const SizedBox(height: 15),
                FindDoctorCategoriesWidget(categories: homeData?.data?.categories ?? []),

                if (_activeAppointment != null) ...[
                  const SizedBox(height: 15),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.red.shade50,
                      border: Border.all(color: Colors.red.shade200),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Icon(Icons.warning_amber_rounded, color: Colors.red),
                            const SizedBox(width: 10),
                            Expanded(child: Text("You have an active appointment right now!", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red.shade700))),
                          ],
                        ),
                        const SizedBox(height: 10),
                        ElevatedButton.icon(
                          icon: Icon(Icons.videocam, color: Colors.white),
                          label: Text("Join Call with Dr. ${_activeAppointment.vendor?.name ?? ''}", style: TextStyle(color: Colors.white)),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            minimumSize: Size(double.infinity, 45),
                          ),
                          onPressed: () async {
                            final appointmentId = _activeAppointment!.sId ?? '';
                            try {
                              final response = await http.get(Uri.parse('${AppUrl.videoCall}/$appointmentId/0'));
                              if (response.statusCode == 200) {
                                final json = jsonDecode(response.body);
                                final token = json['data']['token'] ?? '';
                                final channel = json['data']['channelName'] ?? appointmentId;
                                if (token.isNotEmpty) {
                                  navSlideFromRight(context, AgoraVideoCallScreen(
                                    channelName: channel,
                                    token: token,
                                    uid: 0,
                                    appointmentId: appointmentId,
                                  ));
                                }
                              } else {
                                HelperMethods.showFloatingToast(context, message: 'Failed to join call');
                              }
                            } catch (e) {
                              HelperMethods.showFloatingToast(context, message: 'Error joining call');
                            }
                          },
                        )
                      ],
                    ),
                  ),
                ],

                // SizedBox(
                //   height: 110,
                //   child: ListView(
                //     scrollDirection: Axis.horizontal,
                //     children: [
                //
                //       _specialistCard(
                //         "General\nPhysician",
                //         Icons.medical_services,
                //         true,
                //       ),
                //
                //       _specialistCard(
                //         "Skin & Hair",
                //         Icons.face,
                //         false,
                //       ),
                //
                //       _specialistCard(
                //         "Women's\nHealth",
                //         Icons.pregnant_woman,
                //         false,
                //       ),
                //
                //       _specialistCard(
                //         "Child\nSpecialist",
                //         Icons.child_care,
                //         false,
                //       ),
                //     ],
                //   ),
                // ),

                const SizedBox(height: 15),
                //                       Row(
                //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //         children: [
                //           RichText(
                //             text: TextSpan(
                //               style: TextStyle(
                //                 fontWeight: FontWeight.w600,
                //                 fontSize: 16,
                //                 color: ColorResource.darkText,
                //               ),
                //               children: [
                //                 TextSpan(text: "Upcoming Appointments "),
                //                 WidgetSpan(
                //                   child: Container(
                //                     padding: EdgeInsets.symmetric(
                //                       horizontal: 7,
                //                       vertical: 2,
                //                     ),
                //                     decoration: BoxDecoration(
                //                       color: ColorResource.primaryBlue,
                //                       borderRadius: BorderRadius.circular(12),
                //                     ),
                //                     child: Text(
                //                       "3",
                //                       style: TextStyle(
                //                         color: Colors.white,
                //                         fontWeight: FontWeight.bold,
                //                         fontSize: 12
                //                       ),
                //                     ),
                //                   ),
                //                 ),
                //               ],
                //             ),
                //           ),
                //           GestureDetector(
                //             child: Text(
                //               "See All",
                //               style: TextStyle(
                //                 color: ColorResource.primaryBlue,
                //                 fontWeight: FontWeight.w600,
                //                 fontSize: 12
                //               ),
                //             ),
                //             onTap: () {
                //               navSlideFromRight(context,AppointmentScreen());
                //             },
                //           ),
                //         ],
                //       ),
                // const SizedBox(height: 15),

                /// DOCTOR APPOINTMENT CARD
                Consumer<AppointmentViewModel>(
                  builder: (context, appointmentVm, child) {
                    if (appointmentVm.isLoadingUpcoming || appointmentVm.upcomingAppointments.isEmpty) {
                      return const SizedBox();
                    }
                    final latestAppt = appointmentVm.upcomingAppointments.first;
                    return _appointmentCard(context, latestAppt);
                  },
                ),

                const SizedBox(height: 20),
                //to megha ne jo image hai waisa banai thi and sir ne bole ki shi nhi funcanality same rahega ui acche se banao ok to dono mohtrma ne mil kar e banaya hai




                /// BOOK + HEALTH RECORD
                Row(
                  children: [

                    Expanded(
                      child: _squareButton(
                        h: 35,
                      w: 35,
                      title:   "Book\nAppointment",
                        // Icons.calendar_month,
                  icon:       "assets/icons/hospital_13298007.png",
                    onTap:         () {
                          navSlideFromRight(
                              context,
                              const BookingTypeScreen(isBack: true));
                        },
                      ),
                    ),

                    const SizedBox(width: 14),

                    Expanded(
                      child: _squareButton(
                        h: 35,
                        w: 35,
                      title:   "My Health\n& Records",
                     icon:    "assets/icons/health-check.png",
                        // Icons.file_copy,
                    onTap:        () {
                          navSlideFromRight(
                              context,
                              const MyHealthAndRecords());
                        },
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                /// EMERGENCY BUTTON
                GestureDetector(
                  onTap: () {
                    navFade(context, const EmergencyServicesScreen());
                  },
                  child: Container(
                    height: 55,
                    decoration: BoxDecoration(
                      color: Color(0xffc73736),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child:  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset("assets/icons/emergencyIcons.png",height: 35,),
                        //
                        // Icon(Icons.phone_in_talk, color: Colors.white),

                        SizedBox(width: 10),

                        Text(
                          "Emergency Services 24/7",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 15),

                /// ROUND CATEGORIES
                const CircularButtonRow(),

                const SizedBox(height: 15),

                Consumer<AftercareViewModel>(
                  builder: (context, aftercareVm, child) {
                    final pendingMedicines = aftercareVm.medicines.where((m) => m.isTaken != true).toList();
                    if (pendingMedicines.isEmpty) return const SizedBox.shrink();

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4.0),
                          child: CustomText(
                            text: 'Daily Dose Reminder',
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        SizedBox(
                          height: 120,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: pendingMedicines.length,
                            itemBuilder: (context, index) {
                              final med = pendingMedicines[index];
                              return Container(
                                width: 280,
                                margin: const EdgeInsets.only(right: 15),
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: ColorResource.white,
                                  border: Border.all(color: Colors.blue.shade100),
                                  borderRadius: BorderRadius.circular(16),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.blue.withOpacity(0.05),
                                      blurRadius: 10,
                                      offset: const Offset(0, 5),
                                    )
                                  ]
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        color: ColorResource.primaryBlue.withOpacity(0.1),
                                        shape: BoxShape.circle,
                                      ),
                                      child: const Icon(Icons.medication, color: ColorResource.primaryBlue),
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          CustomText(text: med.medicineName ?? "Medicine", fontSize: 14, fontWeight: FontWeight.bold),
                                          CustomText(text: "${med.dosage ?? '1'} • ${med.timing ?? ''}", fontSize: 12, color: Colors.grey),
                                        ],
                                      ),
                                    ),
                                    ElevatedButton(
                                      onPressed: () {
                                        aftercareVm.toggleMedicineStatus(med.id!, true);
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: ColorResource.primaryBlue,
                                        minimumSize: const Size(60, 30),
                                        padding: const EdgeInsets.symmetric(horizontal: 10),
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))
                                      ),
                                      child: const Text('Take', style: TextStyle(color: Colors.white, fontSize: 12)),
                                    )
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

                const SizedBox(height: 20),

                CarouselSlider(
                  items: banners.map((imagePath) {

                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 1),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.asset(
                          imagePath,
                          fit: BoxFit.cover,
                          width: double.infinity,
                        ),
                      ),
                    );

                  }).toList(),

                  options: CarouselOptions(
                    height: 140,
                    autoPlay: true,
                    enlargeCenterPage: true,
                    viewportFraction: 1,
                    onPageChanged: (index, reason) {
                      setState(() {
                        currentIndex = index;
                      });
                    },
                  ),
                ),
                const SizedBox(height: 10),

                /// INDICATOR
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: banners.asMap().entries.map((entry) {

                    return Container(
                      width: currentIndex == entry.key ? 18 : 8,
                      height: 8,
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      decoration: BoxDecoration(
                        color: currentIndex == entry.key
                            ? ColorResource.primaryBlue
                            : Colors.grey,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    );

                  }).toList(),
                ),
                const SizedBox(height: 10),

                CommonHealthIssueWidget(
                  issues: homeData?.data?.symptoms?.map((symptom) {
                    return {
                      "iconPath": "${symptom.image}",
                      "label": symptom.name ?? "Unknown",
                      "symptomsId": symptom.sId ?? '',
                    };
                  }).toList() ??
                      [],
                ),

                const SizedBox(height: 100),
              ],
            ),
          );
        },
      ),
    );
  }

  /// SPECIALIST CARD
  Widget _specialistCard(String title, IconData icon, bool selected) {

    return Container(
      width: 120,
      margin: const EdgeInsets.only(right: 14),
      decoration: BoxDecoration(
        color: selected
            ? ColorResource.primaryBlue.withOpacity(.1)
            : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: selected
              ? ColorResource.primaryBlue
              : Colors.grey.shade200,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
          )
        ],
      ),

      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          Icon(icon,
              size: 35,
              color: ColorResource.primaryBlue),

          const SizedBox(height: 8),

          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
          )
        ],
      ),
    );
  }

  /// APPOINTMENT CARD
  Widget _appointmentCard(BuildContext context, dynamic appt) {
    String docName = appt.vendor?.name ?? "Doctor";
    String docImage = appt.vendor?.profileImage ?? "https://images.unsplash.com/photo-1607746882042-944635dfe10e";
    String catName = appt.category?.name ?? "Specialist";
    String dateStr = appt.appointmentDate ?? "";
    String timeStr = appt.timeSlot ?? "";
    
    // Quick parse for better display if you have a date helper, or just show raw date
    if (dateStr.length > 10) dateStr = dateStr.substring(0, 10);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xff082855),
            Color(0xff2c6cc9),
          ],
        ),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 26,
                backgroundImage: NetworkImage(docImage.isNotEmpty ? docImage : "https://images.unsplash.com/photo-1607746882042-944635dfe10e"),
                backgroundColor: Colors.grey.shade300,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      docName,
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      catName,
                      style: TextStyle(color: Colors.white70),
                    ),
                  ],
                ),
              ),
              InkWell(
                  onTap: () async {
                    final appointmentId = appt.sId ?? '';
                    int? _remoteUid;
                    final uid = 1234; // could be any unique int per user
                    final response = await http.get(Uri.parse(
                      '${AppUrl.videoCall}/$appointmentId/$uid'
                    ));

                    if (response.statusCode == 200) {
                      final json = jsonDecode(response.body);
                      final token = json['data']['token'] ?? '';
                      final channel = json['data']['channelName'] ?? appointmentId;
                      if (token.isEmpty) {
                        HelperMethods.showFloatingToast(
                          context,
                          message: "Unable to join. Token not generated. Try again later.",
                        );
                        return;
                      }

                      navSlideFromRight(
                        context,
                        AgoraVideoCallScreen(
                          channelName: channel,
                          token: token,
                          uid: uid,
                          appointmentId: appointmentId,
                        ),
                      );
                    } else if (response.statusCode == 400) {
                      HelperMethods.showFloatingToast(context, message: "Call has already ended.");
                    } else {
                      HelperMethods.showFloatingToast(context, message: 'Failed to join call');
                    }
                  },
                borderRadius: BorderRadius.circular(40),
                child: Container(
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white24,
                  ),
                  padding: const EdgeInsets.all(8),
                  child: const Icon(Icons.videocam_rounded, color: Colors.white),
                ),
              )
            ],
          ),
          const SizedBox(height: 15),
          Row(
            children: [
              _timeChip(dateStr, Icons.calendar_today),
              const SizedBox(width: 10),
              _timeChip(timeStr, Icons.access_time),
            ],
          )
        ],
      ),
    );
  }

  Widget _timeChip(String text, IconData icon) {

    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white24,
          borderRadius: BorderRadius.circular(10),
        ),

        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Icon(icon, color: Colors.white, size: 18),

            const SizedBox(width: 5),

            Text(text,
                style: const TextStyle(
                    color: Colors.white)),
          ],
        ),
      ),
    );
  }

  /// SQUARE BUTTON
  Widget _squareButton({required String title,
    required  double h,
    required  double w,
    required String icon,
    required VoidCallback onTap,}
      ) {

    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 95,
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(16),
        ),

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(icon,height: h,width: w,),

            // Icon(icon,
            //     size: 32,
            //     color: ColorResource.primaryBlue),

            const SizedBox(height: 6),

            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  fontWeight: FontWeight.w500,color: Colors.black,fontSize: 13),
            )
          ],
        ),
      ),
    );
  }

}