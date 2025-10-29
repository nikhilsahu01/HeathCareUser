import 'package:flutter/material.dart';
import 'package:health_care/core/utils/custom_widgets/custom_app_button.dart';
import 'package:health_care/core/utils/navigation_helper.dart';
import 'package:health_care/core/utils/theams/color_resource.dart';
import 'package:provider/provider.dart';
import '../../../core/utils/custom_widgets/custom_appBar.dart';
import '../../../core/utils/helper_functions/helpers_methods.dart';
import 'emegency_form_toroma.dart';
import 'accident_provider/add_address_troma.dart';

class TraumaAddNewAddressScreen extends StatefulWidget {
  final bool? isHome;

  const TraumaAddNewAddressScreen({super.key, this.isHome,});

  @override
  State<TraumaAddNewAddressScreen> createState() => _TraumaAddNewAddressScreenState();
}

class _TraumaAddNewAddressScreenState extends State<TraumaAddNewAddressScreen> {
  String addressType = "Home";

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: ColorResource.white,
      appBar: CustomAppBar(title: 'Enter Address'),
      body: Consumer<TromaAddAddressManuallyProvider>(
        builder: (context, pro, child) {
          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: width * 0.05),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  margin: const EdgeInsets.only(top: 20),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Save address as',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children:
                        ['Home', 'Work', 'Others'].map((type) {
                          final isSelected = addressType == type;
                          return Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: ChoiceChip(
                              showCheckmark: false,
                              backgroundColor: ColorResource.white,
                              label: Text(type),
                              selected: isSelected,
                              onSelected: (_) {
                                setState(() => addressType = type);
                                pro.addressController.text = type;
                              },
                              selectedColor: ColorResource.primaryBlue,
                              labelStyle: TextStyle(
                                color:
                                isSelected
                                    ? ColorResource.white
                                    : ColorResource.darkText,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 20),
                      _buildTextField(pro.floorController, 'Floor *'),
                      _buildTextField(
                        pro.houseController,
                        'House/Flat Number & Building Name*',
                      ),
                      _buildTextField(pro.landmarkController, 'Landmark*'),
                      _buildTextField(
                        pro.receiverNameController,
                        'Receiver Name',

                      ),
                      _buildTextField(
                          pro.receiverNumberController,
                          'Receiver Number',
                          keyboardType: TextInputType.number,
                          maxLength: 10
                      ),
                    ],
                  ),
                ),
                SizedBox(height: height * 0.1),
                CustomAppButton(
                  label: 'Next',
                  onPressed: () {
                    if (pro.error == null) {
                      if (pro.floorController.text.trim().isEmpty ||
                          pro.houseController.text.trim().isEmpty ||
                          pro.landmarkController.text.trim().isEmpty) {
                        HelperMethods.showCustomSnackbar(
                          context,
                          message: "Please fill all mandatory fields",
                        );
                        return;
                      }

                      navSlideFromRight(
                        context,
                        EmergencyFormScreenTrauma(addressType: addressType),
                      );
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

  Widget _buildTextField(
      TextEditingController controller,
      String hint, {
        int? maxLength,
        TextInputType keyboardType = TextInputType.text,
      }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: TextFormField(
        controller: controller,
        maxLength: maxLength,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          counterText: '', // hides length counter if you don't want it
          labelText: hint,
          hintText: hint,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
    );
  }
}
