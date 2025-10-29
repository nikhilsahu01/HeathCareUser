import 'package:flutter/material.dart';
import 'package:health_care/core/utils/custom_widgets/custom_app_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../profile_view_model/profile_view_model.dart';



class PersonalDetailsScreen extends StatefulWidget {
  const PersonalDetailsScreen({super.key});

  @override
  State<PersonalDetailsScreen> createState() => _PersonalDetailsScreenState();
}

class _PersonalDetailsScreenState extends State<PersonalDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileViewModel>(
      builder: (context, vm, _) {
        return Column(
          children: [
            _buildTextField(vm.nameController, "Full Name"),
            const SizedBox(height: 8),
            _buildTextField(vm.mobileController, "Mobile No", type: TextInputType.phone),
            const SizedBox(height: 8),
            _buildTextField(vm.emailController, "Email", type: TextInputType.emailAddress),
            const SizedBox(height: 8),

            // Gender Dropdown
            Container(
              height: 50,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(6),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0x26000000),
                    blurRadius: 2,
                    offset: const Offset(0, 2),
                    spreadRadius: 0,
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 25, right: 10),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    isExpanded: true,
                    hint: const Text(
                      "Gender",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Color(0xff696E6A),
                      ),
                    ),
                    value: (vm.gender != null && vm.gender!.isNotEmpty) ? vm.gender : null,
                    items: ["Male", "Female", "Other"].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Color(0xff696E6A),
                          ),
                        ),
                      );
                    }).toList(),
                    onChanged: (newValue) {
                      vm.gender = newValue;
                      vm.notifyListeners();
                    },
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),

            _buildTextField(vm.dobController, "Date of Birth", type: TextInputType.datetime),
            const SizedBox(height: 8),
            _buildTextField(vm.bloodGroupController, "Blood Group"),
            const SizedBox(height: 8),
            _buildTextField(vm.maritalStatusController, "Marital Status"),
            const SizedBox(height: 8),
            _buildTextField(vm.heightController, "Height", type: TextInputType.number),
            const SizedBox(height: 8),
            _buildTextField(vm.weightController, "Weight", type: TextInputType.number),
            // const SizedBox(height: 8),
            // _buildTextField(vm.locationController, "Location"),
            const SizedBox(height: 20),

            vm.isLoading
                ? const CircularProgressIndicator()
                : CustomAppButton(
              label: 'Save',
              onPressed: () async {
                await vm.updateProfile();
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Profile updated successfully")),
                  );
                }
              },
            ),
          ],
        );
      },
    );
  }

  Widget _buildTextField(TextEditingController controller, String hint,
      {TextInputType type = TextInputType.text}) {
    return Container(
      height: 50,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6),
        boxShadow: [
          BoxShadow(
            color: const Color(0x26000000),
            blurRadius: 2,
            offset: const Offset(0, 2),
            spreadRadius: 0,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 10),
        child: TextField(
          controller: controller,
          textAlignVertical: TextAlignVertical.center,
          keyboardType: type,
          decoration: InputDecoration(
            border: InputBorder.none,
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            hintText: hint,
            hintStyle: const TextStyle(color: Color(0xff696E6A)),
          ),
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Color(0xff696E6A),
          ),
        ),
      ),
    );
  }
}
