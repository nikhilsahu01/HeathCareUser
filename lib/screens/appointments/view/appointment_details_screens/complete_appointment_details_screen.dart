import 'package:flutter/material.dart';
import 'package:health_care/core/utils/helper_functions/helpers_methods.dart';
import 'package:provider/provider.dart';

import '../../../../core/api_service/app_url.dart';
import '../../../../core/utils/custom_widgets/custom_appBar.dart';
import '../../../../core/utils/custom_widgets/custom_app_button.dart';
import '../../../../core/utils/custom_widgets/custom_image_view.dart';
import '../../../../core/utils/custom_widgets/custom_threeDots_indecator.dart';
import '../../../../core/utils/navigation_helper.dart';
import '../../../../core/utils/theams/color_resource.dart';
import '../../../after_care/view/after_care_screen.dart';
import '../../../rating_reviews/view/review_submission.dart';
import '../../viewModel/appointments_details_viewModel.dart';
import '../reschedule_bottombar.dart';





class CompletedAppointmentsDetailsScreen extends StatefulWidget {
  final String appointmentId;
  final bool? isCancelledAppointment;

  const CompletedAppointmentsDetailsScreen({
    Key? key,
    required this.appointmentId,
    this.isCancelledAppointment = false,
  }) : super(key: key);

  @override
  State<CompletedAppointmentsDetailsScreen> createState() => _CompletedAppointmentsDetailsScreenState();
}

class _CompletedAppointmentsDetailsScreenState extends State<CompletedAppointmentsDetailsScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<AppointmentDetailsViewModel>(context, listen: false)
          .fetchAppointmentDetails(widget.appointmentId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorResource.white,
      appBar: CustomAppBar(title: "Appointment Details"),
      body: Consumer<AppointmentDetailsViewModel>(
        builder: (context, viewModel, _) {
          if (viewModel.isLoading) {
            return const Center(child: ThreeDotsLoader());
          }

          if (viewModel.errorMessage != null) {
            return Center(child: Text(viewModel.errorMessage!));
          }

          final model = viewModel.appointmentDetails;
          if (model == null) {
            return const Center(child: Text("No data available."));
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Container(
              decoration: BoxDecoration(
                color: ColorResource.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              padding: const EdgeInsets.all(16),
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
                          imagePath: '${AppUrl.baseUrl}/${model.vendor?.profileImage ?? ''}',
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              model.vendor?.name ?? "Doctor Name",
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: ColorResource.darkText,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              model.vendor?.department?.first ?? "Specialization",
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.black54,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text.rich(
                              TextSpan(
                                text: 'Booking ID: ',
                                style: const TextStyle(
                                  fontSize: 13,
                                  color: Colors.black87,
                                ),
                                children: [
                                  TextSpan(
                                    text: "#${model.sId ?? "--"}",
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),
                  const Divider(),

                  /// Details Section
                  _buildDetailRow("Date & Time", "${HelperMethods.formatAppointmentDate(model.appointmentDate ?? '')} | ${model.timeSlot ?? '--'}"),
                  _buildDetailRow("Package", model.category?.name ?? "--"),
                  _buildDetailRow("Booking For", model.patient?.name ?? "--"),
                  const Divider(),
                  _buildDetailRow("Amount", "₹599"), // Replace if you add amount in model

                  const SizedBox(height: 16),

                  /// Buttons Row
                  if (widget.isCancelledAppointment == false) ...[
                    CustomAppButton(
                      label: "Add Review",
                      onPressed: () {
                        navSlideFromRight(context,ReviewSubmissionPage(appointmentId:model.sId??'' ,consultantName: model.vendor?.name ?? '',profileImage: model.vendor?.profileImage??'',));
                      },
                      color: ColorResource.primaryBlue,
                      textColor: Colors.white,
                    ),
                    const SizedBox(height: 12),

                    /// Aftercare Plan Button
                    CustomAppButton(
                      label: "View Aftercare plan",
                      onPressed: () {
                        navSlideFromRight( context, AfterCareScreen());
                      },
                      color: Colors.white,
                      textColor: ColorResource.primaryBlue,
                      borderColor: ColorResource.primaryBlue,
                    ),
                  ] else ...[
                    CustomAppButton(
                      label: "Re-book",
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                          ),
                          builder: (context) => RescheduleBottomSheetScreen(vendorId:model.vendor?.sId ?? "",appointmentId: model.sId??'',isRebook:true,categoryId: model.category?.sId,patentId: model.user?.sId,type: model.type,),
                        );
                      },
                      color: ColorResource.primaryBlue,
                      textColor: Colors.white,
                    ),
                  ],
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildDetailRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
          ),
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.end,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
