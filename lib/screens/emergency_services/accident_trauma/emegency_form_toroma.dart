import 'package:flutter/material.dart';
import 'package:health_care/core/utils/custom_widgets/custom_app_button.dart';
import 'package:health_care/core/utils/theams/color_resource.dart';
import 'package:health_care/screens/emergency_services/widgets/confirmation_booking_dialog.dart';
import 'package:provider/provider.dart';
import '../../../core/utils/custom_widgets/custom_appBar.dart';
import '../../../core/utils/helper_functions/helpers_methods.dart';
import 'accident_provider/add_address_troma.dart';


class EmergencyFormScreenTrauma extends StatefulWidget {
  final String addressType;


  const EmergencyFormScreenTrauma({super.key,required this.addressType});

  @override
  State<EmergencyFormScreenTrauma> createState() => _EmergencyFormScreenTraumaState();
}

class _EmergencyFormScreenTraumaState extends State<EmergencyFormScreenTrauma> {

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: ColorResource.white,
      appBar: CustomAppBar(title: 'Emergency Form'),
      body: Consumer<TromaAddAddressManuallyProvider>(
        builder: (context, pro, child) {
          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: width * 0.05),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildTextField(pro.patientNameController, 'Enter Patient’s Name'),
                _buildTextField(pro.patientAge, 'Patient Age'),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: DropdownButtonFormField<String>(
                    dropdownColor: ColorResource.white,
                    value: pro.gender.isEmpty ? null : pro.gender,
                    decoration: InputDecoration(
                      labelText: "Select Gender",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                    ),
                    items: ["Male", "Female", "Other"].map((type) {
                      return DropdownMenuItem(
                        value: type,
                        child: Text(type, style: const TextStyle(fontSize: 14)),
                      );
                    }).toList(),
                    onChanged: (value) {
                      if (value != null) {
                        pro.setGenderFor(value);
                      }
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: DropdownButtonFormField<String>(
                    dropdownColor: ColorResource.white,
                    value: pro.conscious ? "Yes" : "No",
                    decoration: InputDecoration(
                      labelText: "Is the patient conscious?",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                    ),
                    items: ["Yes", "No"].map((type) {
                      return DropdownMenuItem(
                        value: type,
                        child: Text(type, style: const TextStyle(fontSize: 14)),
                      );
                    }).toList(),
                    onChanged: (value) {
                      if (value != null) {
                        pro.setConsciousType(value);
                      }
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: DropdownButtonFormField<String>(
                    dropdownColor: ColorResource.white,
                    value: pro.breathing ? "Yes" : "No",
                    decoration: InputDecoration(
                      labelText: "Is the patient breathing?",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                    ),
                    items: ["Yes", "No"].map((type) {
                      return DropdownMenuItem(
                        value: type,
                        child: Text(type, style: const TextStyle(fontSize: 14)),
                      );
                    }).toList(),
                    onChanged: (value) {
                      if (value != null) {
                        pro.setBreathingType(value);
                      }
                    },
                  ),
                ),
                SizedBox(height: 40,),
                CustomAppButton(
                  label: pro.isLoading ? 'Submitting...' : 'Submit',
                  onPressed: pro.isLoading ? (){} :

                      () async {
                    if (pro.error == null) {
                      if (pro.patientNameController.text.trim().isEmpty) {
                        HelperMethods.showCustomSnackbar(context, message: "Please enter patient's name");
                        return;
                      }

                      if (pro.patientAge.text.trim().isEmpty) {
                        HelperMethods.showCustomSnackbar(context, message: "Please enter patient's age");
                        return;
                      }
                      showDialog(
                        context: context,
                        builder: (_) => BookingConfirmationDialogue(
                          message: "An Ambulance will be booked right away. Are you Sure?",
                          onPressed: () async {
                            await pro.getCurrentLocation();
                            await pro.createAccidentalTraumaBooking(
                              context: context,
                              addressType: widget.addressType,
                            );
                          },

                        ),
                      );
                    } else {
                      HelperMethods.showCustomSnackbar(context, message: "Error: ${pro.error}");
                    }
                  },
                ),
                const SizedBox(height: 20),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String hint) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: hint,
          hintText: hint,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
    );
  }
}
