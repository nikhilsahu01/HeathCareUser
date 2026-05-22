import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:health_care/core/utils/helper_functions/helpers_methods.dart';
import 'package:health_care/core/utils/navigation_helper.dart';
import '../../../../core/utils/custom_widgets/custom_app_button.dart';
import '../../../../core/utils/custom_widgets/custom_image_view.dart';
import '../../../../core/utils/custom_widgets/custom_threeDots_indecator.dart';
import '../../../../core/utils/global_variables.dart';
import '../../../../core/utils/theams/color_resource.dart';
import '../../otp/view/otp_screen.dart';
import '../repo/login_repository.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

import 'package:flutter/services.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  String fullPhoneNumber = '';
  String? countryCode = '+91';
  String? phoneNumber = '';
  bool isAgreed = false;
  bool isSending = false;
  bool? isNewUser;
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
            image: AssetImage('assets/images/loginBackGround.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: height),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: height * 0.17),
                CustomImageView(
                  imagePath: 'assets/icons/newLogo.png',
                  height: 120,

                  // fit: BoxFit.cover,
                  // height: MediaQuery.of(context).size.height,
                  // width:MediaQuery.of(context).size.width,
                ),
                // CustomImageView(
                //   imagePath: 'assets/images/appLogoUpdated1.png',
                //   height: height * 0.20,
                //   width: width * 0.35,
                //   fit: BoxFit.contain,
                // ),
                SizedBox(height: height * 0.02),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [
                        //
                        ColorResource.gradientLightBlue,
                        ColorResource.primaryBlue,
                        //
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
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Please Enter Your Mobile Number',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: width * 0.045,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 20),

                        // IntlPhoneField integrated here
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: ColorResource.white),
                          ),
                          // child: IntlPhoneField(
                          //   initialCountryCode: 'IN',
                          //   showCountryFlag: false,
                          //   showDropdownIcon: true,
                          //   dropdownIcon: const Icon(Icons.arrow_drop_down, color: ColorResource.white),
                          //   style: const TextStyle(color: ColorResource.white),
                          //   dropdownTextStyle: const TextStyle(color: ColorResource.white),
                          //   cursorColor: ColorResource.white,
                          //   keyboardType: TextInputType.phone,
                          //   disableLengthCheck: false,
                          //   autovalidateMode: AutovalidateMode.onUserInteraction,
                          //   decoration: const InputDecoration(
                          //     hintText: 'Enter Your Mobile Number',
                          //     hintStyle: TextStyle(color: ColorResource.white),
                          //     border: InputBorder.none,
                          //     fillColor: Colors.transparent,
                          //     // borderRadius: BorderRadius.circular(12),
                          //     contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                          //     counterText: '',
                          //   ),
                          //   validator: (value) {
                          //     if (value == null || value.number.isEmpty) {
                          //       return 'Mobile number is required';
                          //     }
                          //
                          //     /// ✅ Built-in validation (BEST)
                          //     if (!value.isValidNumber()) {
                          //       return 'Enter a valid mobile number';
                          //     }
                          //
                          //     /// ✅ Extra safety (optional)
                          //     if (value.countryISOCode == 'IN' && value.number.length != 10) {
                          //       return 'Indian number must be 10 digits';
                          //     }
                          //
                          //     return null;
                          //   },
                          //   onChanged: (phone) {
                          //     fullPhoneNumber = phone.completeNumber;
                          //     phoneNumber = phone.number;
                          //     countryCode = phone.countryCode;
                          //   },
                          // ),
                          child: IntlPhoneField(
                            initialCountryCode: 'IN',
                            showCountryFlag: false,
                            disableLengthCheck: true, // ❗ IMPORTANT (we handle manually)
                            dropdownIcon: const Icon(Icons.arrow_drop_down, color: Colors.white),
                            style: const TextStyle(color: Colors.white),
                            dropdownTextStyle: const TextStyle(color: Colors.white),
                            cursorColor: Colors.white,
                            keyboardType: TextInputType.phone,
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              LengthLimitingTextInputFormatter(10),
                            ],
                              decoration: const InputDecoration(
                                fillColor: Colors.transparent,
                                hintText: 'Enter Your Mobile Number',
                                hintStyle: TextStyle(color: Colors.white),
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                              counterText: '',
                            ),

                            /// ✅ PRO VALIDATION
                            validator: (value) {
                              if (value == null || value.number.isEmpty) {
                                return 'Mobile number is required';
                              }

                              /// ONLY LOCAL NUMBER LENGTH (IMPORTANT)
                              final number = value.number;
                              final country = value.countryISOCode;

                              /// 🌍 Common valid range (E.164 standard)
                              if (number.length < 6 || number.length > 15) {
                                return 'Invalid mobile number';
                              }

                              /// 🇮🇳 India strict rule
                              if (country == 'IN' && number.length != 10) {
                                return 'Indian number must be 10 digits';
                              }

                              /// 🇺🇸 US strict
                              if (country == 'US' && number.length != 10) {
                                return 'US number must be 10 digits';
                              }

                              /// 🇦🇪 UAE
                              if (country == 'AE' && number.length != 9) {
                                return 'UAE number must be 9 digits';
                              }

                              /// ✅ Final check (library validation)
                              if (!value.isValidNumber()) {
                                return 'Enter valid number';
                              }

                              return null;
                            },

                            /// ✅ IMPORTANT (separate values correctly)
                            onChanged: (phone) {
                              fullPhoneNumber = phone.completeNumber; // +91XXXXXXXXXX
                              phoneNumber = phone.number; // 10 digit only
                              countryCode = phone.countryCode; // +91
                            },
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Checkbox(
                              value: isAgreed,
                              onChanged: (value) {
                                setState(() {
                                  isAgreed = value ?? false;
                                });
                              },
                              activeColor: ColorResource.primaryBlue,
                              side: BorderSide(
                                color: ColorResource.white,
                                width: 1.5,
                              ),
                            ),

                            Expanded(
                              child: RichText(
                                text: TextSpan(
                                  children: [
                                    const TextSpan(
                                      text: "I agree to the ",
                                      style: TextStyle(color: ColorResource.white, fontSize: 14),
                                    ),
                                    TextSpan(
                                      text: "Terms and Conditions",
                                      style: const TextStyle(
                                        color: ColorResource.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 13,
                                      ),
                                      recognizer: TapGestureRecognizer()..onTap = () {
                                        // navPush(context: context, action: const CmsPageScreens(
                                        //   screenType: 'termAndConditions',
                                        //   title: 'Terms and Conditions',
                                        // ));
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        CustomAppButton(
                          label: 'Get OTP',
                          onPressed:isSending
                            ? (){}
                              :() async {
                            if (_formKey.currentState?.validate() == true) {
                              setState(() => isSending = true);
                              var payload = {
                                "mobileNo": phoneNumber,   // ONLY number
                                "countryCode": countryCode, // +91
                              };
                              if (fullPhoneNumber.isEmpty) {
                                setState(() => isSending = false);
                                HelperMethods.showCustomSnackbar(context, message: 'Please Enter Your Mobile Number');
                                return;
                              }if (!isAgreed) {
                                setState(() => isSending = false);
                                HelperMethods.showCustomSnackbar(context, message: 'Please agree to the terms and conditions to proceed.');
                                return;
                              }
                              try {
                                var response = await LoginRepository().getOtpApi(payload);
                                print(response);
                                print('dsagsgssss');
                                if (response['success'] == true) {
                                  setState(() {
                                    isNewUser = response['isNewUser'];
                                  });
                                  print("Mapped isNewUser = $isNewUser");
                                  navSlideFromRight(
                                    context,
                                     OtpScreen(mobileNumber: phoneNumber.toString(), isNewUser: isNewUser ?? false,),
                                  );
                                } else {
                                  HelperMethods.showCustomSnackbar(context, message: 'Something went wrong');
                                }
                              } catch (e) {
                                HelperMethods.showCustomSnackbar(context, message: "An error occurred: $e");
                              } finally {
                                setState(() => isSending = false);
                              }
                            }
                          },
                          color: ColorResource.white,
                          textColor: ColorResource.primaryBlue,
                          child: isSending
                              ? const ThreeDotsLoader(color: ColorResource.primaryBlue)
                              : null,
                        ),
                        const SizedBox(height: 10),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
