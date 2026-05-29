import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:health_care/screens/all_category_list/viewModel/categories_list_viewModel.dart';
import 'package:health_care/screens/all_health_issues_list/viewmodel/symptoms_list_viewModel.dart';
import 'package:health_care/screens/appointments/viewModel/appointments_details_viewModel.dart';
import 'package:health_care/screens/appointments/viewModel/appointments_viewModel.dart';
import 'package:health_care/screens/appointments/viewModel/reschedule_viewModel.dart';
import 'package:health_care/screens/auth/otp/provider/otpProvider.dart';
import 'package:health_care/screens/auth/registration/viewModel/register_view_model.dart';
import 'package:health_care/screens/booking/view_model/book_appointments_viewModel.dart';
import 'package:health_care/screens/booking/view_model/consultant_details_viewModel.dart';
import 'package:health_care/screens/booking/view_model/consultants_list_viewModel.dart';
import 'package:health_care/screens/booking/view_model/patients_viewmodel.dart';
import 'package:health_care/screens/booking/view_model/specialisation_viewModel.dart';
import 'package:health_care/screens/booking/view_model/symptoms_provider.dart';
import 'package:health_care/screens/home/view_model/home_viewModel.dart';
import 'package:health_care/screens/emergency_services/ambulance_services/ambulance_provider/add_address_manually_provider.dart';
import 'package:health_care/screens/emergency_services/accident_trauma/accident_provider/add_address_troma.dart';
import 'package:health_care/screens/location_screen/address_provider.dart';
import 'package:health_care/screens/notfications/notifications_viewmodel/notifications_provider.dart';
import 'package:health_care/screens/profile/profile_edit_screen/profile_view_model/profile_view_model.dart';
import 'package:health_care/screens/profile/view/viewmodel/cms_viewmodel.dart';
import 'package:health_care/screens/splash/splash_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:health_care/screens/services/my_health_record/viewmodel/health_record_viewmodel.dart';
import 'package:health_care/screens/rating/viewmodel/rating_viewmodel.dart';
import 'package:health_care/screens/help_Center/viewmodel/help_center_viewmodel.dart';
import 'package:health_care/screens/after_care/viewmodel/aftercare_viewmodel.dart';
import 'core/coreServices/fireBase_services.dart';
import 'core/coreServices/socket_service/join_call_provider.dart';
import 'core/coreServices/socket_service/socket_service.dart';
import 'core/utils/theams/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await AwesomeNotifications().initialize(
    null, // icon for notifications (null = default app icon)
    [
      NotificationChannel(
        channelKey: 'basic_channel',
        channelName: 'Basic Notifications',
        channelDescription: 'Notification channel for basic tests',
        defaultColor: const Color(0xFF9D50DD),
        ledColor: Colors.white,
        importance: NotificationImportance.High,
        channelShowBadge: true,
      ),
    ],
    debug: true,
  );
  await FirebaseNotificationService().init();

  final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString('token');
  Future.delayed(Duration.zero, () {
    if (token != null && token.isNotEmpty) {
      final socketService = SocketService();
      socketService.connect(userId: token);
      socketService.listenToCallEvents();
    } else {
      print("⚠️ No token found. Skipping socket connection.");
    }
  });
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => OTPProvider()),
        ChangeNotifierProvider(create: (_) => HomeViewModel()),
        ChangeNotifierProvider(create: (_) => CategoriesListViewmodel()),
        ChangeNotifierProvider(create: (_) => SymptomsViewModel()),
        ChangeNotifierProvider(create: (_) => SpecialisationsViewModel()),
        ChangeNotifierProvider(create: (_) => ConsultantListViewModel()),
        ChangeNotifierProvider(create: (_) => ConsultantViewModel()),
        ChangeNotifierProvider(create: (_) => BookingSlotViewModel()),
        ChangeNotifierProvider(create: (_) => PatientsViewModel()),
        ChangeNotifierProvider(create: (_) => HealthRecordViewModel()),
        ChangeNotifierProvider(create: (_) => RatingReviewViewModel()),
        ChangeNotifierProvider(create: (_) => HelpCenterViewModel()),
        ChangeNotifierProvider(create: (_) => AftercareViewModel()),
        ChangeNotifierProvider(create: (_) => AppointmentDetailsViewModel()),
        ChangeNotifierProvider(create: (_) => NotificationProvider()),
        ChangeNotifierProvider(create: (_) => AppointmentViewModel()),
        ChangeNotifierProvider(create: (_) => RescheduleViewModel()),
        ChangeNotifierProvider(create: (_) => AllHealthIssuesListViewmodel()),
        ChangeNotifierProvider(create: (_) => JoinCallNotifier()),
        ChangeNotifierProvider(create: (_) => AddAddressManuallyProvider()),
        ChangeNotifierProvider(create: (_) => TromaAddAddressManuallyProvider()),
        ChangeNotifierProvider(create: (_) => AddressViewModel()),
        ChangeNotifierProvider(create: (_) => RegistrationViewModel()),
        ChangeNotifierProvider(create: (_) => ProfileViewModel()),
         ChangeNotifierProvider(create: (_) => CmsViewModel()),



      ],
      child: MaterialApp(
        title: 'Olcure User',
        navigatorKey: navigatorKey,
        theme: AppTheme.lightTheme,
        debugShowCheckedModeBanner: false,
        home: const SplashScreen(),
      ),
    );
  }
}

