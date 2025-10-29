import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:health_care/core/utils/custom_widgets/custom_image_view.dart';
import 'package:health_care/core/utils/theams/color_resource.dart';
import 'package:health_care/screens/profile/profile_edit_screen/view/personal_screen/personal_details.dart';
import 'package:provider/provider.dart';
import '../../../../core/api_service/app_url.dart';
import '../../../../core/utils/custom_widgets/custom_appBar.dart';
import '../profile_view_model/profile_view_model.dart';
import 'medical_details/medical_details.dart';


class EditProfile extends StatefulWidget {
  final bool isBack;

  const EditProfile({super.key, this.isBack = true});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  bool isPersonalSelected = true;
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
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: CustomAppBar(title: 'Profile', isBack: widget.isBack),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: width * 0.05),
          child: Column(
            children: [
              Consumer<ProfileViewModel>(
                builder: (context, profileViewModel, child) {
                  return Column(
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
                    ],
                  );
                },
              ),
             const SizedBox(height:20),
              Container(
                height: 45,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: const Color(0xffE5F0FF),
                ),
                child: Row(
                  children: [
                    _buildToggleButton(
                      width: width / 2,
                      text: 'Personal Details',
                      selected: isPersonalSelected,
                      onTap: () => setState(() => isPersonalSelected = true),
                    ),
                    _buildToggleButton(
                      width: width / 2,
                      text: 'Medical Details',
                      selected: !isPersonalSelected,
                      onTap: () => setState(() => isPersonalSelected = false),
                    ),
                  ],
                ),
              ),
              SizedBox(height: height * 0.03),
              // Section Content
              isPersonalSelected
                  ? const PersonalDetailsScreen()
                  : const MedicalDetails(),

              SizedBox(height: height * 0.02),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildToggleButton({
    required double width,
    required String text,
    required bool selected,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: double.infinity,
          decoration: BoxDecoration(
            color: selected ? ColorResource.primaryBlue:  ColorResource.lightBlue,
            borderRadius: BorderRadius.circular(50),
          ),
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: selected ? Colors.white : const Color(0xff696E6A),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

