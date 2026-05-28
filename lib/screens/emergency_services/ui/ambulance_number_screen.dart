import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/utils/theams/color_resource.dart';

class AmbulanceNumberScreen extends StatefulWidget {
  const AmbulanceNumberScreen({super.key});

  @override
  State<AmbulanceNumberScreen> createState() => _AmbulanceNumberScreenState();
}

class _AmbulanceNumberScreenState extends State<AmbulanceNumberScreen> {
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
        
        

        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(14.0),
            child: Column(
              children: [
                SizedBox(height: height * 0.6),
                Text('Ambulance Number',
                  style: TextStyle(fontSize: width*0.06,overflow: TextOverflow.ellipsis,fontWeight: FontWeight.bold,color: ColorResource.gradientDarkBlue,
                  ),
                ),

                SizedBox(height: height * 0.04),

                GestureDetector(
                  onTap: () async {
                    final Uri phoneUri = Uri(
                      scheme: 'tel',
                      path: '108',
                    );

                    if (await canLaunchUrl(phoneUri)) {
                    await launchUrl(phoneUri);
                    }
                  },
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                      vertical: 16,
                      horizontal: 20,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                        color: Colors.red.shade200,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 8,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.call),
                        SizedBox(width: width * 0.02,),
                        Text(
                          " 108",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
