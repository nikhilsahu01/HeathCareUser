import 'package:flutter/material.dart';
import 'package:health_care/core/utils/custom_widgets/custom_app_button.dart';
import 'package:health_care/core/utils/custom_widgets/custom_image_view.dart';
import '../../../../core/utils/custom_widgets/custom_appBar.dart';
import '../../../../core/utils/theams/color_resource.dart';
import '../widgets/custom_fileUpload_dialogue.dart';

class HealthRecordsListScreen extends StatelessWidget {
  const HealthRecordsListScreen({super.key});



  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: ColorResource.white,
      appBar: CustomAppBar(title: 'Health Record'),
      body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: screenHeight * 0.15,),
              CustomImageView(imagePath: 'assets/images/healthRecBg.png'),
              SizedBox(height: screenHeight * 0.1,),
              CustomAppButton(label: '+Add Healthcare', onPressed: (){
                showDialog(
                  context: context,
                  builder: (_) => CustomFileUpload(
                    message: "Choose File(PDF/ Image/Scan)",
                    onPressed: () {
                      print('hello');
                    },
                  ),
                );
              })
            ],
          )
      ),
    );
  }
}