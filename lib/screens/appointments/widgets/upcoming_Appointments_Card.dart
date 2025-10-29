import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:health_care/core/utils/custom_widgets/custom_image_view.dart';
import 'package:provider/provider.dart';
import '../../../core/api_service/app_url.dart';
import '../../../core/coreServices/socket_service/join_call_provider.dart';
import '../../../core/utils/custom_widgets/customRemind_switch.dart';
import '../../../core/utils/helper_functions/helpers_methods.dart';
import '../../../core/utils/navigation_helper.dart';
import '../../../core/utils/theams/color_resource.dart';
import '../../VideoCall/agoraVideoCall.dart';
import '../model/appointments_model.dart';
import '../view/appointment_details_screens/upcoming_appointment_details_screen.dart';
import '../viewModel/appointments_viewModel.dart';
import 'package:http/http.dart' as http;

class UpcomingAppointmentsCard extends StatefulWidget {
  final AppointmentsList model;

  const UpcomingAppointmentsCard({super.key, required this.model});

  @override
  State<UpcomingAppointmentsCard> createState() => _UpcomingAppointmentsCardState();
}

class _UpcomingAppointmentsCardState extends State<UpcomingAppointmentsCard> {
  @override
  Widget build(BuildContext context) {
    final vendorName = widget.model.vendor?.name ?? 'Unknown Doctor';
    final specialization = widget.model.category?.name ?? 'Unknown Specialization';
    final imageUrl = widget.model.vendor?.profileImage?? '';
    final canJoin = context.watch<JoinCallNotifier>().canJoin(widget.model.sId ?? '');
    print(canJoin);
    print(widget.model.sId);
    print('canJoin debug');
    return GestureDetector(
      onTap: () {
        navSlideFromRight( context, UpcomingAndCancelledAppointmentDetailsScreen(appointmentId: widget.model.sId??'',));
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 18),
        decoration: BoxDecoration(
          color: ColorResource.primaryBlue,
          borderRadius: BorderRadius.circular(6),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        padding: const EdgeInsets.all(14),
        child: Stack(
          children: [
            // if (widget.model.appointmentDate == HelperMethods.getCurrentDateInUtcIsoFormat() &&
            //     HelperMethods.isCurrentTimeWithinTimeSlot(widget.model.timeSlot))// this button wll be show when join
            if (canJoin)
              Positioned(
              top: 0,
              right: 0,
              child: InkWell(
                  onTap: () async {
                    final appointmentId = widget.model.sId ?? '';
                    final uid = 1234; // could be any unique int per user
                    final response = await http.get(Uri.parse(
                      // 'http://192.168.1.4:5002/api/join-call/$appointmentId/$uid'
                      '${AppUrl.videoCall}/$appointmentId/$uid'
                    ));
                    print('${AppUrl.videoCall}/$appointmentId/$uid');
                    print(response.statusCode);
                    print(response.body);

                    if (response.statusCode == 200) {
                      final json = jsonDecode(response.body);
                      final token = json['data']['token'] ?? '';
                      print(token);
                      final channel = json['data']['channelName'] ?? appointmentId;
                      print(channel);
                      if (token.isEmpty) {
                        HelperMethods.showFloatingToast(
                          context,
                          message: "Unable to join. Token not generated. Try again later.",
                        );
                        return;
                      }

                      // navSlideFromRight(
                      //   context,
                      //   AgoraVideoCallScreen(
                      //     channelName: channel,
                      //     token: token,
                      //     uid: uid,
                      //     appointmentId: appointmentId,
                      //   ),
                      // );
                    } else if (response.statusCode == 400) {
                      HelperMethods.showFloatingToast(context, message: "Call has already ended.");
                    } else {
                      HelperMethods.showFloatingToast(context, message: 'Failed to join call');
                    }
                  },
                borderRadius: BorderRadius.circular(40),
                child: Container(
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                  padding: const EdgeInsets.all(8),
                  child: const Icon(Icons.videocam_rounded,
                      color: ColorResource.darkText, size: 24),
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Remind me switch (Placeholder - implement with ViewModel if needed)
                if(widget.model.reminder?.isNotEmpty??false)...[
                  Align(
                    alignment: Alignment.topRight,
                    child: CustomRemindMeSwitch(
                      value: widget.model.isReminder == '0' ? false : true,
                      onChanged: (val) {
                        final viewModel = Provider.of<AppointmentViewModel>(context, listen: false);
                        viewModel.updateReminder(id: widget.model.sId ?? '').then((success) {
                          if (!mounted) return;
                          if (success) {
                            HelperMethods.showFloatingToast(context, message: 'Reminder setting updated', color: ColorResource.green);
                          } else {
                            HelperMethods.showFloatingToast(context, message: 'Failed to update Reminder setting!');
                          }
                        });
                      },
                    ),
                  ),

                ],
                const SizedBox(height: 6),

                /// Doctor Info Row
                Row(
                  children: [
                    CircleAvatar(
                      radius: 28,
                      backgroundColor: Colors.transparent,
                      child: CustomImageView(
                        imagePath: '${AppUrl.baseUrl}/$imageUrl',
                        height: 56,
                        width: 56,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            vendorName,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              specialization,
                              style: const TextStyle(
                                color: ColorResource.darkText,
                                fontWeight: FontWeight.w500,
                                fontSize: 10,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 14),

                /// Date + Time Row
                Container(
                  width: double.infinity,
                  child: Row(
                    children: [
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
                              topLeft: Radius.circular(6),
                              bottomLeft: Radius.circular(6),
                            ),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            HelperMethods.formatAppointmentDate(widget.model.appointmentDate ?? 'N/A'),
                            // widget.model.appointmentDate??'',
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
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
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
                        decoration: const BoxDecoration(
                          color: ColorResource.gradientLightBlue,
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(6),
                            bottomRight: Radius.circular(6),
                          ),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          widget.model.timeSlot ?? 'N/A',
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ],
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
