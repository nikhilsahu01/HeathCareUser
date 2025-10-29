import 'package:flutter/material.dart';
import 'package:health_care/core/utils/custom_widgets/custom_image_view.dart';
import 'package:health_care/core/utils/navigation_helper.dart';
import 'package:health_care/screens/emergency_services/ui/emergency_services.dart';

import '../../core/utils/theams/color_resource.dart';
import '../booking/ui/booking_type.dart';
import '../home/view/bottom_controller.dart';
import 'my_health_record/view/my_health_records_screen.dart';

class ServicesScreen extends StatelessWidget {
  final bool? isSkip;

  const ServicesScreen({
    Key? key,
    this.isSkip,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const SizedBox(height: 30),
              if (isSkip ?? true)
                TextButton(
                  onPressed: () {
                    navFade(context, BottomNavController());
                  },
                  style: TextButton.styleFrom(
                    side: const BorderSide(color: ColorResource.primaryBlue),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: const Text(
                    "Skip",
                    style: TextStyle(color: ColorResource.primaryBlue),
                  ),
                ),
              const SizedBox(height: 20),
              Expanded(
                child: ListView(
                  children: [
                    _serviceButton(
                      context,
                      color: const Color(0xFFC82833),
                      label: "Emergency &\nImmediate Help",
                      imagePath: 'assets/images/emergencyIcon.png',
                      onTap: () {
                        navSlideFromRight(context, const EmergencyServicesScreen());
                      },
                    ),
                    _serviceButton(
                      context,
                      color: const Color(0xFF0189BB),
                      label: "Get Medical Help",
                      imagePath: 'assets/images/medicalHelpIcon.png',
                      onTap: () {
                        navSlideFromRight( context,BookingTypeScreen(isBack: true,));
                      },
                    ),
                    _serviceButton(
                      context,
                      color: const Color(0xFFABC760),
                      label: "My Health & Record",
                      imagePath: 'assets/images/myHealthIcon.png',
                      onTap: () {
                        navSlideFromRight(context,const MyHealthAndRecords());
                      },
                    ),
                    _serviceButton(
                      context,
                      color: const Color(0xFF001B4A),
                      label: "Home",
                      imagePath: 'assets/images/homeIcon.png',
                      onTap: () {
                        navFade(context, const BottomNavController());
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _serviceButton(
      BuildContext context, {
        required Color color,
        required String label,
        required String imagePath,
        required VoidCallback onTap,
      }) {
    final width = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        height: 65,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(40),
        ),
        child: Row(
          children: [
            CustomImageView(
              imagePath: imagePath,
              height: 30,
              width: 30,
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Text(
                label,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const CircleAvatar(
              backgroundColor: Colors.white,
              radius: 18,
              child: Icon(Icons.arrow_forward, color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}
