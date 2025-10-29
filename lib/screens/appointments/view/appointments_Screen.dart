import 'package:flutter/material.dart';
import 'package:health_care/core/utils/custom_widgets/custom_appBar.dart';
import 'package:health_care/core/utils/theams/color_resource.dart';
import 'package:health_care/screens/appointments/viewModel/appointments_viewModel.dart';
import 'package:health_care/screens/appointments/widgets/upcoming_Appointments_Card.dart';
import 'package:provider/provider.dart';
import '../../../core/utils/custom_widgets/custom_refresh.dart';
import '../../../core/utils/custom_widgets/custom_threeDots_indecator.dart';
import '../widgets/cancelled_appointments_card.dart';
import '../widgets/completed_appointments_card.dart';

class AppointmentScreen extends StatefulWidget {
  final bool? isBack;

  const AppointmentScreen({super.key, this.isBack});

  @override
  State<AppointmentScreen> createState() =>
      _AppointmentScreenState();
}

class _AppointmentScreenState extends State<AppointmentScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;


  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);

    // Delay execution until after build completes
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final viewModel = Provider.of<AppointmentViewModel>(context, listen: false);
      viewModel.fetchUpcomingAppointments();   // For Upcoming Tab
      viewModel.fetchCompletedAppointments();  // For Completed Tab
      viewModel.fetchCancelledAppointments();  // For Cancelled Tab
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorResource.white,
      appBar: CustomAppBar(title: 'Appointments', isBack: widget.isBack ?? true),
      body: Consumer<AppointmentViewModel>(
        builder: (context, viewModel, _) {
          return SafeArea(
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        spreadRadius: 1,
                        blurRadius: 3,
                        offset: const Offset(0, 1),
                      ),
                    ],
                  ),
                  child: TabBar(
                    controller: _tabController,
                    indicator: BoxDecoration(
                      color: ColorResource.primaryBlue,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: ColorResource.primaryBlue.withOpacity(0.2),
                          spreadRadius: 1,
                          blurRadius: 4,
                          offset: const Offset(0, 1),
                        ),
                      ],
                    ),
                    labelColor: Colors.white,
                    indicatorColor: Colors.transparent,
                    dividerColor: Colors.transparent,
                    unselectedLabelColor: Colors.grey.shade600,
                    labelStyle: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                    unselectedLabelStyle: const TextStyle(
                      fontWeight: FontWeight.w500,
                    ),
                    tabs: const [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        child: Tab(text: 'Upcoming'),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        child: Tab(text: 'Completed'),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        child: Tab(text: 'Cancelled'),
                      ),
                    ],
                    splashBorderRadius: BorderRadius.circular(8),
                    overlayColor: MaterialStateProperty.resolveWith<Color?>(
                          (states) => states.contains(MaterialState.pressed)
                          ? ColorResource.primaryBlue.withOpacity(0.1)
                          : null,
                    ),
                  ),
                ),
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      /// --- UPCOMING TAB ---
                      viewModel.isLoadingUpcoming
                          ? const Center(child: ThreeDotsLoader())
                          : viewModel.upcomingAppointments.isEmpty
                          ? const Center(
                        child: Text(
                          "No upcoming appointments found.",
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                      )
                          : NotificationListener<ScrollNotification>(
                        onNotification: (notification) {
                          if (notification is ScrollEndNotification &&
                              notification.metrics.pixels == notification.metrics.maxScrollExtent) {
                            viewModel.loadMoreUpcomingAppointments();
                          }
                          return false;
                        },
                        child: CustomRefreshIndicator(
                          onRefresh: ()async{
                                await viewModel.fetchUpcomingAppointments();
                          },
                          child: ListView.builder(
                            padding: const EdgeInsets.all(16),
                            itemCount: viewModel.upcomingAppointments.length +
                                (viewModel.isLoadingMoreUpcoming ? 1 : 0),
                            itemBuilder: (context, index) {
                              if (index == viewModel.upcomingAppointments.length) {
                                return const Center(child: ThreeDotsLoader());
                              }
                              final appointment = viewModel.upcomingAppointments[index];
                              return UpcomingAppointmentsCard(model: appointment);
                            },
                          ),
                        ),
                      ),

                      /// --- COMPLETED TAB ---
                      viewModel.isLoadingCompleted
                          ? const Center(child: ThreeDotsLoader())
                          : viewModel.completedAppointments.isEmpty
                          ? const Center(
                        child: Text(
                          "No completed appointments found.",
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                      )
                          : NotificationListener<ScrollNotification>(
                        onNotification: (notification) {
                          if (notification is ScrollEndNotification &&
                              notification.metrics.pixels == notification.metrics.maxScrollExtent) {
                            viewModel.loadMoreCompletedAppointments();
                          }
                          return false;
                        },
                        child: CustomRefreshIndicator(
                          onRefresh: () async {
                            await viewModel.fetchCompletedAppointments();
                          },
                          child: ListView.builder(
                            padding: const EdgeInsets.all(16),
                            itemCount: viewModel.completedAppointments.length +
                                (viewModel.isLoadingMoreCompleted ? 1 : 0),
                            itemBuilder: (context, index) {
                              if (index == viewModel.completedAppointments.length) {
                                return const Center(child: ThreeDotsLoader());
                              }
                              final appointment = viewModel.completedAppointments[index];
                              return CompletedAppointmentCard(model: appointment);
                            },
                          ),
                        ),
                      ),

                      /// --- CANCELLED TAB ---
                      viewModel.isLoadingCancelled
                          ? const Center(child: ThreeDotsLoader())
                          : viewModel.cancelledAppointments.isEmpty
                          ? const Center(
                        child: Text(
                          "No cancelled appointments found.",
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                      )
                          : NotificationListener<ScrollNotification>(
                        onNotification: (notification) {
                          if (notification is ScrollEndNotification &&
                              notification.metrics.pixels == notification.metrics.maxScrollExtent) {
                            viewModel.loadMoreCancelledAppointments();
                          }
                          return false;
                        },
                        child: CustomRefreshIndicator(
                          onRefresh: () async {
                            await viewModel.fetchCancelledAppointments();
                          },
                          child: ListView.builder(
                            padding: const EdgeInsets.all(16),
                            itemCount: viewModel.cancelledAppointments.length +
                                (viewModel.isLoadingMoreCancelled ? 1 : 0),
                            itemBuilder: (context, index) {
                              if (index == viewModel.cancelledAppointments.length) {
                                return const Center(child: ThreeDotsLoader());
                              }
                              final appointment = viewModel.cancelledAppointments[index];
                              return CancelledAppointmentsCard(model: appointment);
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}



