import 'package:flutter/material.dart';
import 'package:health_care/screens/booking/ui/specialisations_screen.dart';
import 'package:health_care/screens/booking/ui/symptoms_list_screen.dart';

import '../../../core/utils/custom_widgets/custom_appBar.dart';
import '../../../core/utils/custom_widgets/custom_image_view.dart';
import '../../../core/utils/global_variables.dart';
import '../../../core/utils/navigation_helper.dart';
import '../../../core/utils/theams/color_resource.dart';
import 'consultant_List_screen.dart';

class BookingTypeScreen extends StatelessWidget {
  final bool isBack;
  final bool? byPassSymptomsAndCategoryScreen;
  final bool? byPassSymptomsScreen;

  const BookingTypeScreen({
    Key? key,
    this.byPassSymptomsAndCategoryScreen,
    this.byPassSymptomsScreen,
    required this.isBack,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: ColorResource.white,
      appBar: CustomAppBar(title: 'Book Appointment', isBack: isBack),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05, vertical: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomImageView(
              imagePath: 'assets/images/inClinickButton.png',
              height: screenHeight * 0.3,
              width: screenWidth * 0.9,
              fit: BoxFit.contain,
              radius: BorderRadius.circular(12),
              onTap: () {
                globalTabType = "inClinic";
                if(byPassSymptomsAndCategoryScreen == true){
                  navSlideFromRight(context, ConsultantListScreen());
                }else if(byPassSymptomsScreen==true){
                  navSlideFromRight(context, SpecialisationsScreen(selectedCategoryIds: globalSymptomId));
                }else{
                  navSlideFromRight(context, SymptomsListScreen());
                }
              },
            ),
            const SizedBox(height: 25),
            CustomImageView(
              imagePath: 'assets/images/videAppointmentButton.png',
              height: screenHeight * 0.3,
              width: screenWidth * 0.9,
              fit: BoxFit.contain,
              radius: BorderRadius.circular(12),
              onTap: () {
                globalTabType = "videoAppointment";
                if(byPassSymptomsAndCategoryScreen == true){
                  navSlideFromRight( context,ConsultantListScreen());
                }else if(byPassSymptomsScreen==true){
                  navSlideFromRight(context, SpecialisationsScreen(selectedCategoryIds: globalSymptomId));
                }else{
                  navSlideFromRight( context,SymptomsListScreen());
                }
              },
            ),
            const SizedBox(height: 25),
          ],
        ),
      ),
    );
  }
}