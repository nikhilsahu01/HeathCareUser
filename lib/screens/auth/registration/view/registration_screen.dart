import 'package:flutter/material.dart';
import 'package:health_care/core/utils/custom_widgets/custom_image_view.dart';
import 'package:health_care/core/utils/helper_functions/helpers_methods.dart';
import 'package:health_care/core/utils/navigation_helper.dart';
import 'package:intl/intl.dart';
import 'package:health_care/core/utils/custom_widgets/custom_app_button.dart';
import 'package:health_care/core/utils/theams/color_resource.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:health_care/core/utils/theams/color_resource.dart';
import 'package:health_care/core/utils/custom_widgets/custom_app_button.dart';
import 'package:provider/provider.dart';

import '../../../../core/utils/custom_widgets/custom_inputFiled.dart';
import '../../../../core/utils/helper_functions/validation_hepler.dart';
import '../../../home/view/bottom_controller.dart';
import '../../../services/services_screen.dart';

// class RegistrationScreen extends StatefulWidget {
//   const RegistrationScreen({super.key});
//
//   @override
//   State<RegistrationScreen> createState() => _RegistrationScreenState();
// }
//
// class _RegistrationScreenState extends State<RegistrationScreen> {
//   final _formKey = GlobalKey<FormState>();
//
//   final TextEditingController nameController = TextEditingController();
//   final TextEditingController mobileController = TextEditingController();
//   final TextEditingController dobController = TextEditingController();
//   final TextEditingController genderController = TextEditingController();
//   final TextEditingController addressController = TextEditingController();
//
//   final FocusNode dobFocusNode = FocusNode();
//
//   @override
//   void dispose() {
//     nameController.dispose();
//     mobileController.dispose();
//     dobController.dispose();
//     genderController.dispose();
//     addressController.dispose();
//     dobFocusNode.dispose();
//     super.dispose();
//   }
//
//   Future<void> _selectDate() async {
//     final pickedDate = await showDatePicker(
//       context: context,
//       initialDate: DateTime(1990),
//       firstDate: DateTime(1900),
//       lastDate: DateTime.now(),
//     );
//     if (pickedDate != null) {
//       dobController.text = DateFormat('dd/MM/yyyy').format(pickedDate);
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: ColorResource.white,
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             children: [
//               const SizedBox(height: 40),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 // crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   const Text(
//                     'Registration',
//                     style: TextStyle(
//                       color: Colors.black,
//                       fontSize: 24,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ],
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.end,
//                 children: [
//                   TextButton(
//                     onPressed: () {
//                       navSlideFromTop(context,const ServicesScreen());
//                     },
//                     style: TextButton.styleFrom(
//                       side: const BorderSide(color: ColorResource.primaryBlue),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(20),
//                       ),
//                     ),
//                     child: const Text(
//                       "Skip",
//                       style: TextStyle(color: ColorResource.primaryBlue),
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 20),
//               TextFormField(
//                 controller: nameController,
//                 decoration: _inputDecoration('Name'),
//                 validator: validateName,
//               ),
//               const SizedBox(height: 15),
//               TextFormField(
//                 controller: mobileController,
//                 keyboardType: TextInputType.phone,
//                 maxLength: 10,
//                 decoration: _inputDecoration('Mobile Number').copyWith(counterText: ''),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) return 'Phone number is required';
//                   if (!regMobile.hasMatch(value)) return 'Enter a valid mobile number';
//                   return null;
//                 },
//               ),
//               const SizedBox(height: 15),
//               TextFormField(
//                 controller: dobController,
//                 readOnly: true,
//                 focusNode: dobFocusNode,
//                 decoration: _inputDecoration('Date of birth'),
//                 onTap: _selectDate,
//                 validator: justForEmpty,
//               ),
//               const SizedBox(height: 15),
//
//               // Gender
//               TextFormField(
//                 controller: genderController,
//                 decoration: _inputDecoration('Gender'),
//                 validator: justForEmpty,
//               ),
//               const SizedBox(height: 15),
//
//               // Address
//               TextFormField(
//                 controller: addressController,
//                 maxLines: 2,
//                 decoration: _inputDecoration('Address'),
//                 validator: justForEmpty
//               ),
//               const SizedBox(height: 30),
//
//               // Register Button
//               CustomAppButton(
//                 label: 'Register',
//                 onPressed: () {
//                   if (_formKey.currentState?.validate() == true) {
//                     // TODO: Prepare API payload
//                     print('Submitting registration...');
//                     print('Name: ${nameController.text}');
//                     print('Mobile: ${mobileController.text}');
//                     print('DOB: ${dobController.text}');
//                     print('Gender: ${genderController.text}');
//                     print('Address: ${addressController.text}');
//                     navSlideFromTop(context,const ServicesScreen());
//                   }
//                 },
//                 color: ColorResource.primaryBlue,
//                 textColor: Colors.white,
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   InputDecoration _inputDecoration(String hint) {
//     return InputDecoration(
//       hintText: hint,
//       filled: true,
//       fillColor: Colors.white,
//       contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
//       border: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(12),
//         borderSide: const BorderSide(color: Colors.grey),
//       ),
//       focusedBorder: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(12),
//         borderSide: const BorderSide(color: ColorResource.primaryBlue),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../viewModel/register_view_model.dart';
import '../../../../screens/profile/view/ui/cms_screen.dart';

class RegistrationScreen extends StatefulWidget {
  final String mobileNumber;
  const RegistrationScreen({super.key, required this.mobileNumber});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  final TextEditingController genderController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  final FocusNode dobFocusNode = FocusNode();
  bool _isTermsAccepted = false;

  @override
  void initState() {
    super.initState();
    // Pre-fill mobile number from widget
    mobileController.text = widget.mobileNumber;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<RegistrationViewModel>(context, listen: false).welcome();
    });
  }

  @override
  void dispose() {
    nameController.dispose();
    mobileController.dispose();
    dobController.dispose();
    genderController.dispose();
    addressController.dispose();
    dobFocusNode.dispose();
    super.dispose();
  }

  Future<void> _selectDate() async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime(1990),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (pickedDate != null) {
      dobController.text = DateFormat('dd/MM/yyyy').format(pickedDate);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<RegistrationViewModel>(
      builder: (context, provider, child) {
        return Scaffold(
          backgroundColor: ColorResource.white,
          body: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const SizedBox(height: 40),
                  const Text(
                    'Registration',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {
                          navSlideFromTop(context, const ServicesScreen());
                        },
                        style: TextButton.styleFrom(
                          side: const BorderSide(color: ColorResource.primaryBlue),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: const Text(
                          "Skip",
                          style: TextStyle(color: ColorResource.primaryBlue),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),

                  /// Name
                  CustomTextField(
                    label: 'Name',
                    controller: nameController,
                    validator: validateName,
                  ),
                  const SizedBox(height: 15),

                  /// Mobile Number (read-only)
                  CustomTextField(
                    label: 'Mobile Number',
                    controller: mobileController,
                    isReadOnly: true,
                  ),
                  const SizedBox(height: 15),

                  /// DOB
                  CustomTextField(
                    label: 'Date of Birth',
                    controller: dobController,
                    isReadOnly: true,
                    onTap: _selectDate,
                    validator: justForEmpty,
                    suffixIcon: const Icon(Icons.calendar_month),
                  ),
                  const SizedBox(height: 15),

                  /// Gender
                  CustomTextField(
                    label: 'Gender',
                    controller: genderController,
                    isDropdown: true,
                    dropdownItems: const ['Male', 'Female', 'Other'],
                    validator: justForEmpty,
                  ),
                  const SizedBox(height: 15),

                  /// Address
                  CustomTextField(
                    label: 'Address',
                    controller: addressController,
                    maxLines: 2,
                    validator: justForEmpty,
                  ),
                  const SizedBox(height: 20),

                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Checkbox(
                        value: _isTermsAccepted,
                        activeColor: ColorResource.primaryBlue,
                        onChanged: (val) {
                          setState(() {
                            _isTermsAccepted = val ?? false;
                          });
                        },
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
                              style: TextStyle(color: Colors.black, fontSize: 13),
                              children: [
                                TextSpan(
                                  text: "Terms & Conditions",
                                  style: TextStyle(
                                    color: ColorResource.primaryBlue,
                                    fontWeight: FontWeight.bold,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  provider.isLoading
                      ? const CircularProgressIndicator(color: ColorResource.primaryBlue)
                      : CustomAppButton(
                    label: 'Register',
                    onPressed: () async {
                      if (_formKey.currentState?.validate() == true) {
                        if (!_isTermsAccepted) {
                          HelperMethods.showCustomSnackbar(context, message: 'Please accept Terms & Conditions', backgroundColor: ColorResource.red);
                          return;
                        }
                        final success = await provider.addAddress(
                          context: context,
                          name: nameController.text,
                          mobileNo: mobileController.text,
                          dob: dobController.text,
                          gender: genderController.text,
                          address: addressController.text,
                        );

                        if (success) {
                          HelperMethods.showCustomSnackbar(context, message: 'Registration Successful!',backgroundColor: ColorResource.green);
                          navSlideFromTop(context, const ServicesScreen());
                        } else {
                          HelperMethods.showCustomSnackbar(context, message: 'Something went wrong',backgroundColor: ColorResource.red);
                        }
                      }
                    },
                    color: ColorResource.primaryBlue,
                    textColor: Colors.white,
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
