import 'package:flutter/material.dart';
import 'package:health_care/core/utils/custom_widgets/custom_image_view.dart';
import 'package:health_care/core/utils/navigation_helper.dart';
import 'package:health_care/screens/after_care/view/after_care_screen.dart';

import '../../../../core/utils/custom_widgets/custom_appBar.dart';
import '../../../../core/utils/theams/color_resource.dart';
import 'health_recordsList.dart';

class MyHealthAndRecords extends StatelessWidget {
  const MyHealthAndRecords({super.key});



  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: ColorResource.white,
      appBar: CustomAppBar(title: 'My Health & Record'),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: screenHeight * 0.05,),
              Row(
                children: [
                Expanded(
                  child: CustomImageView(
                    imagePath: 'assets/images/healthCareRecButton.png',
                    onTap: (){
                      navSlideFromRight( context, const HealthRecordsListScreen());
                    },
                  ),
                ),
                SizedBox(width: 14),
                Expanded(
                  child: CustomImageView(
                    imagePath: 'assets/images/afterCareButton.png',
                    onTap: (){
                      navSlideFromRight(context,const AfterCareScreen());
                    },
                  ),



                ),
              ],
            ),
          ],
        ),
      ),
      ),
    );
  }
}