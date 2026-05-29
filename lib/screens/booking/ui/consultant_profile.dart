import 'package:flutter/material.dart';
import 'package:health_care/core/utils/custom_widgets/custom_appBar.dart';
import 'package:health_care/core/utils/custom_widgets/custom_app_button.dart';
import 'package:health_care/core/utils/custom_widgets/custom_image_view.dart';
import 'package:health_care/core/utils/custom_widgets/custom_threeDots_indecator.dart';
import 'package:health_care/core/utils/global_variables.dart';
import 'package:provider/provider.dart';

import '../../../core/api_service/app_url.dart';
import '../../../core/utils/custom_widgets/custom_text.dart';
import '../../../core/utils/navigation_helper.dart';
import '../../../core/utils/theams/color_resource.dart';
import '../view_model/consultant_details_viewModel.dart';
import 'book_appointment.dart';





class ConsultantDetailsScreen extends StatefulWidget {
  final String consultantId;
  const ConsultantDetailsScreen({super.key, required this.consultantId});

  @override
  State<ConsultantDetailsScreen> createState() => _ConsultantDetailsScreenState();
}

class _ConsultantDetailsScreenState extends State<ConsultantDetailsScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<ConsultantViewModel>(context, listen: false)
          .fetchConsultantDetails(widget.consultantId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: ColorResource.white,
      appBar: const CustomAppBar(title: 'Consultant Details'),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: CustomAppButton(
          label: 'Book Appointment',
          onPressed: () {
            navSlideFromRight(
             context,
           BookAppointment(consultantId: widget.consultantId),
            );
          },
        ),
      ),
      body: Consumer<ConsultantViewModel>(
        builder: (context, provider, _) {
          final consultant = provider.consultant;

          if (provider.isLoading) {
            return const Center(child: ThreeDotsLoader());
          }
          if (consultant == null) {
            return Center(
              child: CustomText(
                text: "Failed to load consultant details.\nPlease try again later.",
                fontSize: 16,
                color: Colors.redAccent,
                textAlign: TextAlign.center,
              ),
            );
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                /// Consultant Image
                Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: CustomImageView(
                      imagePath: '${AppUrl.baseUrl}/${consultant.profileImage ?? ""}',
                      width: size.width * 0.4,
                      height: size.width * 0.4,
                      fit: BoxFit.cover,
                      placeHolder: "assets/images/doctor_placeholder.png",
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                /// Name
                CustomText(
                  text: consultant.name ?? "Not available",
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 8),

                /// Department
                CustomText(
                  text: (consultant.department?.join(', ') ?? ''),
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Colors.grey,
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 20),

                _infoRow('Experience', '${consultant.yearOfExp ?? '0'} Years'),
                _infoRow('Consultation Fee',
                    '₹${consultant.inClinicFee ?? consultant.videoConsultFee ?? "0"}'),
                _infoRow('Qualification', consultant.qualification ?? 'N/A'),
                _infoRow('Category', consultant.category ?? 'N/A'),
                _infoRow('Gender', consultant.gender ?? 'N/A'),

                const Divider(height: 32),

                const Align(
                  alignment: Alignment.centerLeft,
                  child: CustomText(
                    text: 'Contact Info',
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                _infoRow('Mobile', consultant.mobile ?? 'N/A'),
                _infoRow('Address', consultant.address ?? 'N/A'),
                _infoRow('District', consultant.district ?? 'N/A'),
                _infoRow('State', consultant.state ?? 'N/A'),
                _infoRow('Pincode', consultant.pincode ?? 'N/A'),

                const Divider(height: 32),

                const Align(
                  alignment: Alignment.centerLeft,
                  child: CustomText(
                    text: 'About',//
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                CustomText(
                  text:
                  // consultant.review?.trim().isNotEmpty == true
                  //     ? consultant.review!
                  //     :
                  "No description available.",
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Colors.black87,
                  textAlign: TextAlign.justify,
                ),

                const SizedBox(height: 100),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _infoRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            text: '$title: ',
            fontSize: 15,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
          Expanded(
            child: CustomText(
              text: value,
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: Colors.black54,
            ),
          ),
        ],
      ),
    );
  }
}
