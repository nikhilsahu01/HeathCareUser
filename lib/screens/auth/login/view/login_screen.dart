import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:health_care/core/utils/helper_functions/helpers_methods.dart';
import 'package:health_care/core/utils/navigation_helper.dart';
import 'package:intl_phone_field/phone_number.dart';
import '../../../../core/utils/custom_widgets/custom_app_button.dart';
import '../../../../core/utils/custom_widgets/custom_image_view.dart';
import '../../../../core/utils/custom_widgets/custom_threeDots_indecator.dart';
import '../../../../core/utils/custom_widgets/valdationFunctions.dart';
import '../../../../core/utils/global_variables.dart';
import '../../../../core/utils/theams/color_resource.dart';
import '../../otp/view/otp_screen.dart';
import '../repo/login_repository.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

import 'package:flutter/services.dart';
import '../../../../screens/profile/view/ui/cms_screen.dart';

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
  int maxLength = 10;


  String? validatePhoneNumber(PhoneNumber? value) {

    if (value == null || value.number.isEmpty) {
      return 'Mobile number is required';
    }

    final number = value.number;
    final country = value.countryISOCode;

    /// 🌍 GLOBAL BASIC RANGE
    if (number.length < 6 || number.length > 15) {
      return 'Invalid mobile number';
    }

    onCountryChanged: (country) {

      switch(country.code) {

        case 'IN':
          maxLength = 10;
          break;

        case 'US':
          maxLength = 10;
          break;

        case 'AE':
          maxLength = 9;
          break;

        case 'GB':
          maxLength = 11;
          break;

        default:
          maxLength = 15;
      }

      setState(() {});
    };

    switch (country) {

    /// 🇮🇳 INDIA
      case 'IN':

        if (!RegExp(r'^[6-9]\d{9}$').hasMatch(number)) {
          return 'Enter valid Indian mobile number';
        }

        break;

    /// 🇺🇸 USA
      case 'US':

        if (number.length != 10) {
          return 'US number must be 10 digits';
        }

        break;

    /// 🇦🇪 UAE
      case 'AE':

        if (!RegExp(r'^5\d{8}$').hasMatch(number)) {
          return 'Enter valid UAE mobile number';
        }

        break;

    /// 🇬🇧 UK
      case 'GB':

        if (number.length < 10 || number.length > 11) {
          return 'Enter valid UK number';
        }

        break;

      default:

      /// 🌍 FINAL LIB VALIDATION
      /// 🌍 FINAL LIB VALIDATION
    }
    if (!value.isValidNumber()) {
      return 'Enter valid mobile number';
    }

    return null;
  }


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

                          child: IntlPhoneField(

                            initialCountryCode: 'IN',

                            showCountryFlag: false,

                            disableLengthCheck: true,

                            dropdownIcon: const Icon(
                              Icons.arrow_drop_down,
                              color: Colors.white,
                            ),

                            style: const TextStyle(
                              color: Colors.white,
                            ),

                            dropdownTextStyle: const TextStyle(
                              color: Colors.white,
                            ),

                            cursorColor: Colors.white,

                            keyboardType: TextInputType.phone,

                            autovalidateMode: AutovalidateMode.onUserInteraction,

                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              LengthLimitingTextInputFormatter(maxLength),
                            ],

                            decoration: const InputDecoration(
                              fillColor: Colors.transparent,
                              hintText: 'Enter Your Mobile Number',
                              hintStyle: TextStyle(color: Colors.white),
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 12,
                              ),
                              counterText: '',
                            ),

                            validator: validatePhoneNumber,

                            onChanged: (phone) {

                              /// +919876543210
                              fullPhoneNumber = phone.completeNumber;

                              /// 9876543210
                              phoneNumber = phone.number;

                              /// +91
                              countryCode = phone.countryCode;

                              print("Full: $fullPhoneNumber");
                              print("Number: $phoneNumber");
                              print("Code: $countryCode");
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
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const CmsScreen(type: "terms"),
                                    ),
                                  );
                                },
                                child: RichText(
                                  text: const TextSpan(
                                    text: "I agree to the ",
                                    style: TextStyle(color: ColorResource.white, fontSize: 14),
                                    children: [
                                      TextSpan(
                                        text: "Terms and Conditions",
                                        style: TextStyle(
                                          color: ColorResource.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 13,
                                          decoration: TextDecoration.underline,
                                          decorationColor: ColorResource.white,
                                        ),
                                      ),
                                    ],
                                  ),
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
