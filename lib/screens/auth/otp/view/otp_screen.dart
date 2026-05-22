import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:health_care/core/utils/custom_widgets/custom_image_view.dart';
import 'package:health_care/core/utils/custom_widgets/custom_threeDots_indecator.dart';
import 'package:health_care/core/utils/global_variables.dart';
import 'package:health_care/core/utils/helper_functions/helpers_methods.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/coreServices/socket_service/socket_service.dart';
import '../../../../core/utils/custom_widgets/custom_app_button.dart';
import '../../../../core/utils/navigation_helper.dart';
import '../../../../core/utils/theams/color_resource.dart';
import '../../../home/view/bottom_controller.dart';
import '../../registration/view/registration_screen.dart';
import '../model/verify_otp_model.dart';
import '../provider/otpProvider.dart';
import '../repo/verify_otp_repository.dart';

class OtpScreen extends StatefulWidget {
  final String mobileNumber;
  final bool isNewUser;

  const OtpScreen({super.key, required this.mobileNumber,required this.isNewUser});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final _formKey = GlobalKey<FormState>();
  String otp = '';
  bool isVerifying = false;
  String? deviceToken;

  @override
  void initState() {
    super.initState();
    _initFCMToken();
  }

  Future<void> _initFCMToken() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    String? token = await messaging.getToken();
    setState(() {
      deviceToken = token;
    });
    print("FCM Token: $token");
  }
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Consumer<OTPProvider>(
      builder: (context, provider, child) {
        return Scaffold(
          body: Container(
            height: height,
            width: width,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/otpBg.png'),
                fit: BoxFit.cover,
              ),
            ),
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  SizedBox(height: height * 0.17),
                  CustomImageView(
                    imagePath: 'assets/icons/newLogo.png',
                    height: 120,

                    // fit: BoxFit.cover,
                    // height: MediaQuery.of(context).size.height,
                    // width:MediaQuery.of(context).size.width,
                  ),

                  // Logo
                  // CustomImageView(
                  //   imagePath: 'assets/images/appLogoUpdated1.png',
                  //   height: height * 0.20,
                  //   width: width * 0.35,
                  //   fit: BoxFit.contain,
                  // ),
                  SizedBox(height: height * 0.02),

                  /// OTP Card
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [
                          ColorResource.gradientLightBlue,
                          ColorResource.primaryBlue,
                          // ColorResource.gradientLightBlue,
                          // ColorResource.gradientDarkBlue,
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          const Text(
                            'OTP Verification',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'OTP sent to ${widget.mobileNumber}',
                                style: const TextStyle(
                                  color: Colors.white70,
                                  fontSize: 13,
                                ),
                              ),
                              const SizedBox(width: 5),
                              GestureDetector(
                                onTap: () => Navigator.pop(context),
                                child: const Icon(
                                  Icons.edit,
                                  size: 18,
                                  color: Colors.white70,
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 20),

                          /// OTP Input (Pinput)
                          Pinput(
                            length: 4,
                            keyboardType: TextInputType.number,
                            defaultPinTheme: PinTheme(
                              width: 56,
                              height: 56,
                              textStyle: const TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(color: Colors.white),
                                color: Colors.white,
                              ),
                            ),
                            onCompleted: (value) => setState(() => otp = value),
                            onChanged: (value) => setState(() => otp = value),
                          ),

                          const SizedBox(height: 20),
                          CustomAppButton(
                            label: isVerifying
                                ? ''
                                : 'Verify OTP',
                            onPressed:isVerifying
                              ?(){}
                                :() async {
                              if (otp.length != 4) {
                                HelperMethods.showCustomSnackbar(context, message: 'Please enter the 4-digit OTP.');
                                return;
                              }

                              setState(() => isVerifying = true);
                              final deviceId = await HelperMethods.getDeviceId();
                              final verifyOtpRepository = VerifyOtpRepository();
                              final otpData = verifyOtp(
                                mobileNo: widget.mobileNumber,
                                otp: otp,
                                deviceId: deviceId,
                                fcmToken:deviceToken
                              );
                              try {
                                var response = await verifyOtpRepository.verifyOtpApi(otpData.toJson());

                                if (response['success'] == true) {
                                  final socketService = SocketService();
                                  final token = response['token'];
                                  final userId = response['data']['user']['_id'];
                                  SharedPreferences pref = await SharedPreferences.getInstance();
                                  await pref.setString('token', token);
                                  await pref.setString('userId', userId);
                                  socketService.connect(userId: token);
                                  socketService.listenToCallEvents();

                                  if (widget.isNewUser) {
                                  navPushRemove(context: context, page:  RegistrationScreen(mobileNumber: widget.mobileNumber,));
                                  } else {
                                    navPushRemove(context: context, page: const BottomNavController());
                                  }

                                } else {
                                  HelperMethods.showCustomSnackbar(context, message: 'Invalid OTP. Please try again.');
                                }

                              } catch (e) {
                                HelperMethods.showCustomSnackbar(context, message: 'An error occurred. Please try again.');
                              } finally {
                                setState(() => isVerifying = false);
                              }
                            },
                            color: ColorResource.white,
                            textColor: ColorResource.primaryBlue,
                            child: isVerifying
                                ?  const ThreeDotsLoader(color: ColorResource.primaryBlue,)
                                : null,
                          ),

                          const SizedBox(height: 10),

                          // Resend OTP
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                               Text(
                                "Didn't Get OTP? ",
                                style: TextStyle(
                                  color: ColorResource.white,
                                  fontSize: 13,
                                ),
                              ),
                              provider.isResendEnabled
                                  ? GestureDetector(
                                onTap: () => provider.resendOTP(widget.mobileNumber),
                                child: const Text(
                                  "Re-send",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontSize: 13,
                                  ),
                                ),
                              )
                                  : Text(
                                "Re-send in ${provider.timerSeconds}s",
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

