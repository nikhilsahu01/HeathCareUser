import 'package:flutter/material.dart';
import 'package:health_care/core/utils/custom_widgets/custom_appBar.dart';
import 'package:health_care/core/utils/custom_widgets/custom_app_button.dart';
import 'package:health_care/core/utils/navigation_helper.dart';
import 'package:health_care/core/utils/theams/color_resource.dart';
import 'package:health_care/screens/emergency_services/model/add_address_manually_model.dart';
import 'package:health_care/screens/emergency_services/ui/select_location.dart';

import '../ambulance_services/view/emegency_form.dart';
import '../accident_trauma/emegency_form_toroma.dart';

class LocationPermissionScreen extends StatefulWidget {
  final bool trauma;
  const LocationPermissionScreen({super.key,required this.trauma});

  @override
  State<LocationPermissionScreen> createState() => _LocationPermissionScreenState();
}

class _LocationPermissionScreenState extends State<LocationPermissionScreen> {



  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        height: height,
        width: width,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/locationPermissionBgImage.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: height),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SafeArea(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () {
                          navPop(context: context);
                        },
                        child: Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            color: ColorResource.primaryBlue,
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: const Center(
                            child: Icon(Icons.arrow_back, size: 20, color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: height * 0.6),
                Text('Your Location is needed',
                  style: TextStyle(fontSize: width*0.06,overflow: TextOverflow.ellipsis,fontWeight: FontWeight.bold,color: ColorResource.gradientDarkBlue,
                ),
                ),
                SizedBox(height: height * 0.02),
                CustomAppButton(label: 'Get Current Location', onPressed: (){
                  if(widget.trauma){
                    navSlideFromRight(context, const EmergencyFormScreenTrauma(addressType:'Others' ,));
                  } else {
                    navSlideFromRight(context, const EmergencyFormScreen());//todo
                  }
                }),
                SizedBox(height: height * 0.02),
                CustomAppButton(label: 'Fill Location Manually',onPressed: (){
                  // if(widget.trauma){
                    navSlideFromRight(context, SelectLocationTypeScreen(trauma: widget.trauma,) );
                  // }
                },color: ColorResource.lightBlue,textColor: ColorResource.gradientDarkBlue,),
              ],
            ),
          ),
        ),
      ),
    );
  }
}