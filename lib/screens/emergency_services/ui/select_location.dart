import 'package:flutter/material.dart';
import 'package:health_care/core/utils/custom_widgets/custom_appBar.dart';
import 'package:health_care/core/utils/navigation_helper.dart';
import 'package:health_care/core/utils/theams/color_resource.dart';

import '../ambulance_services/view/add_ambulance_address_manually.dart';
import '../ambulance_services/view/emegency_form.dart';
import '../accident_trauma/add_address_manually_troma.dart';

class SelectLocationTypeScreen extends StatefulWidget {
  // final bool? isHome;
  final bool trauma;

  const SelectLocationTypeScreen({
    super.key,
    required this.trauma,
    // this.isHome,
  });

  @override
  State<SelectLocationTypeScreen> createState() => _SelectLocationTypeScreenState();
}

class _SelectLocationTypeScreenState extends State<SelectLocationTypeScreen> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
     // final fromHome = widget.isHome??false;
    return Scaffold(
      backgroundColor: ColorResource.white,
      appBar: CustomAppBar(title: ''),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: width * 0.05, vertical: height * 0.03),
        child: Column(
          children: [
            _locationOption(
              context,
              icon: Icons.search,
              label: "Search Your Location",
              onTap: () {},
            ),
            // SizedBox(height: height * 0.025),
            // _locationOption(
            //   context,
            //   icon: Icons.my_location_outlined,
            //   label: "Use My Current Location",
            //   onTap: () {
            //     if(!fromHome) {
            //       navSlideFromRight( context, EmergencyFormScreen(addressType: "Home",));
            //     }
            //   },
            // ),
            SizedBox(height: height * 0.025),
            _locationOption(
              context,
              icon: Icons.add,
              label: "Add New Address",
              onTap: () {
            if(widget.trauma){
              navSlideFromRight(context, TraumaAddNewAddressScreen(isHome: true,));
            }else{
              navSlideFromRight(context, AddAmbulanceAddressScreen(isHome: true,));
                  }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _locationOption(BuildContext context, {required IconData icon, required String label, required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 60,
        decoration: BoxDecoration(
          border: Border.all(color: ColorResource.primaryBlue, width: 1.2),
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: [
            Icon(icon, color: ColorResource.primaryBlue),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                label,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
            )
          ],
        ),
      ),
    );
  }
}