import 'package:flutter/material.dart';
import 'package:health_care/core/utils/helper_functions/helpers_methods.dart';
import '../../../core/api_service/app_url.dart';
import '../../../core/utils/custom_widgets/custom_image_view.dart';
import '../../../core/utils/navigation_helper.dart';
import '../../../core/utils/theams/color_resource.dart';

import '../model/appointments_model.dart';
import '../view/appointment_details_screens/complete_appointment_details_screen.dart';


class CompletedAppointmentCard extends StatelessWidget {
  final AppointmentsList model;

  const CompletedAppointmentCard({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    final doctorName = model.vendor?.name ?? 'Unknown Doctor';
    final imageUrl = model.vendor?.profileImage ?? 'na';
    final specialization = model.category?.name ?? 'Unknown Specialization';
    final time = model.timeSlot ?? 'N/A';

    return GestureDetector(
      onTap: () {
        navSlideFromRight(
          context,
          CompletedAppointmentsDetailsScreen(appointmentId: model.sId??''),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
          color: ColorResource.white,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: ColorResource.primaryBlue, width: 1),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Doctor Info Row
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 28,
                  backgroundColor: Colors.transparent,
                  child: CustomImageView(
                    imagePath: '${AppUrl.baseUrl}/$imageUrl',
                    height: 56,
                    width: 56,
                    fit: BoxFit.cover,
                    placeHolder: 'assets/images/imageNotFound.png',
                  ),
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      doctorName,
                      style: const TextStyle(
                        color: ColorResource.darkText,
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      specialization,
                      style: const TextStyle(
                        color: ColorResource.darkText,
                        fontWeight: FontWeight.w400,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                const Text(
                  "Completed",
                  style: TextStyle(
                    color: ColorResource.green,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            ),
            const SizedBox(height: 14),

            /// Date + Time Row
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    decoration: const BoxDecoration(
                      color: ColorResource.gradientLightBlue,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(6),
                        bottomLeft: Radius.circular(6),
                      ),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      HelperMethods.formatAppointmentDate(model.appointmentDate ?? 'N/A'),
                      style: const TextStyle(
                        color: Color(0xff1C1C1C),
                        fontWeight: FontWeight.w500,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ),
                Container(
                  width: 1,
                  height: 40,
                  color: Colors.white.withOpacity(0.5),
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    decoration: const BoxDecoration(
                      color: ColorResource.gradientLightBlue,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(6),
                        bottomRight: Radius.circular(6),
                      ),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      time,
                      style: const TextStyle(
                        color: Color(0xff1C1C1C),
                        fontWeight: FontWeight.w500,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
