import 'package:flutter/material.dart';
import 'package:health_care/core/utils/custom_widgets/custom_appBar.dart';
import 'package:health_care/core/utils/custom_widgets/custom_image_view.dart';
import 'package:health_care/core/utils/navigation_helper.dart';
import 'package:health_care/screens/booking/ui/symptoms_list_screen.dart';
import 'package:health_care/screens/emergency_services/ui/ambulance_number_screen.dart';
import 'package:health_care/screens/emergency_services/widgets/confirmation_booking_dialog.dart';
import 'package:health_care/screens/emergency_services/ui/location_permission.dart';

import '../ambulance_services/view/ambulance_services.dart';

class EmergencyServicesScreen extends StatelessWidget {
  const EmergencyServicesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(title: 'Emergency Services'),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Column(
            children: [
              SizedBox(height: height * 0.02),
              Expanded(
                child: ListView(
                  children: [
                    _serviceButton(
                      context,
                      color: const Color(0xFFFFF0CC),
                      label: "Ambulance Services",
                      imagePath: 'assets/icons/ambulanceIcon.png',
                      onTap: () {
                        navSlideFromRight( context, AmbulanceServiceOptionsScreen());
                      },
                    ),
                    _serviceButton(
                      context,
                      color: const Color(0xFFCCEBFF),
                      label: "Emergency Doctor Consultant",
                      imagePath: 'assets/icons/doctorConsultantIcon.png',
                      onTap: () {
                        navSlideFromRight(context, SymptomsListScreen(isEmergency: true,));
                      },
                    ),
                    _serviceButton(
                      context,
                      color: const Color(0xFFFFD6E0),
                      label: "Accident / Trauma Help",
                      imagePath: 'assets/icons/traumaHelpIcon.png',
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (_) => BookingConfirmationDialogue(
                            message: "Is this Accidental Trauma?",
                            onPressed: () {
                               navPushReplace(context: context, page: AmbulanceNumberScreen()

                              // LocationPermissionScreen(
                              //   trauma: true,
                              // )
                              );
                            },
                          ),
                        );
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
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                label,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
            ),
            CustomImageView(
             imagePath:  imagePath,
              width: width * 0.12,
              fit: BoxFit.contain,
            ),
          ],
        ),
      ),
    );
  }
}

