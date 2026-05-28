import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:health_care/core/api_service/app_url.dart';
import 'package:health_care/core/utils/custom_widgets/custom_appBar.dart';
import 'package:health_care/core/utils/custom_widgets/custom_image_view.dart';
import 'package:health_care/core/utils/theams/color_resource.dart';
import 'package:health_care/screens/help_Center/ui/help_center.dart';
import 'package:health_care/screens/profile/view/ui/cms_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/utils/navigation_helper.dart';
import '../../after_care/view/after_care_screen.dart';
import '../../ambulance/ui/ambulanceScreen.dart';
import '../../ambulance/ui/bookingSummaryScreen.dart';
import '../../rating/ui/rating_screen.dart';
import '../../services/my_health_record/view/my_health_records_screen.dart';
import '../../setting/ui/setting_screen.dart';
import '../../splash/splash_screen.dart';
import '../profile_edit_screen/profile_view_model/profile_view_model.dart';
import '../profile_edit_screen/view/edit_profile.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  @override
  void initState() {
    super.initState();
    // Fetch profile data once when entering this screen
    Future.microtask(() {
      Provider.of<ProfileViewModel>(context, listen: false).fetchProfile();
    });
  }
  @override
  Widget build(BuildContext context) {

    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: ColorResource.white,
      appBar: CustomAppBar(title: 'Profile', isProfile: true, isBack: false),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 14,vertical: 14),
              child: Column(
                children: [
                  Consumer<ProfileViewModel>(
                    builder: (context, profileViewModel, child) {
                      return Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 16,
                          horizontal: 12,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(color: Colors.black12, blurRadius: 5),
                          ],
                        ),
                        child: Column(
                          children: [
                            ClipOval(
                              child: CustomImageView(
                                imagePath:
                                '${AppUrl.baseUrl}/${profileViewModel.profileUser?.user?.profileImage ?? ''}',
                                height: 80,
                                width: 80,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              profileViewModel.profileUser?.user?.name ??
                                  'N/A',
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              profileViewModel.profileUser?.user?.mobileNo ??
                                  'N/A',
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.black54,
                              ),
                            ),
                            const Divider(height: 30),
                            Row(
                              children: [
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      navSlideFromTop(
                                        context,
                                        const MyHealthAndRecords(),
                                      );
                                    },
                                    child: _featureCard(
                                      title: 'Healthcare\nPlan',
                                      icon:
                                          'assets/images/healthCarePlan.png',
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      navSlideFromTop(
                                        context,
                                        const AfterCareScreen(),
                                      );
                                    },
                                    child: _featureCard(
                                      title: 'Aftercare\nServices',
                                      icon: 'assets/images/aftercare.png',
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 12),
                  _menuButton('My Profile', () {
                    navSlideFromRight(context, EditProfile());
                  }),
                  _menuButton('Ambulance', () {
                    navSlideFromRight(context, NearbyAmbulanceScreen());
                  }),   _menuButton('Booking Summary', () {
                    navSlideFromRight(context, BookingSummaryScreen());
                  }),
                  _menuButton('Help Center', () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => HelpCenter(),));
                  }),
                  _menuButton('Settings', () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => SettingScreen(),));
                  }),
                  _menuButton('Rating', () {
                     Navigator.push(context, MaterialPageRoute(builder: (context) => ReviewScreen(),));
                  }),
                  _menuButton(
                    'About Us',
                        () {

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => CmsScreen(
                            type: "about",
                          ),
                        ),
                      );

                    },
                  ),

                  _menuButton(
                    'Privacy & Policy',
                        () {

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => CmsScreen(
                            type: "privacy",
                          ),
                        ),
                      );

                    },
                  ),

                  _menuButton(
                    'Terms & Conditions',
                        () {

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => CmsScreen(
                            type: "terms",
                          ),
                        ),
                      );

                    },
                  ),

                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: CustomImageView(
                          imagePath: 'assets/images/logOutButton.png',
                          onTap: () async {
                            SharedPreferences prefs =
                                await SharedPreferences.getInstance();
                            await prefs.clear();
                            navPushRemove(
                              context: context,
                              page: const SplashScreen(),
                            );
                          },
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: CustomImageView(
                          imagePath: 'assets/images/deleteAccount.png',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 200),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _menuButton(String title, VoidCallback? onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        height: 55,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [BoxShadow(color: Color(0x22000000), blurRadius: 4)],
        ),
        child: Row(
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            const Spacer(),
            const Icon(Icons.arrow_forward_ios_rounded, size: 18),
          ],
        ),
      ),
    );
  }

  Widget _featureCard({required String title, required String icon}) {
    return Container(
      height: 66,
      decoration: BoxDecoration(
        color: ColorResource.primaryBlue,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 4)],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: [
            CustomImageView(imagePath: icon, height: 36, width: 36),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
                maxLines: 2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
