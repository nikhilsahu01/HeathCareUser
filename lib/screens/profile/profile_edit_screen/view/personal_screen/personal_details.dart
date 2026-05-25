import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:health_care/core/utils/custom_widgets/custom_app_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../../core/validation/date_input_formate.dart';
import '../../../../../core/validation/validator.dart';
import '../../profile_view_model/profile_view_model.dart';



class PersonalDetailsScreen extends StatefulWidget {
  const PersonalDetailsScreen({super.key});

  @override
  State<PersonalDetailsScreen> createState() => _PersonalDetailsScreenState();
}

class _PersonalDetailsScreenState extends State<PersonalDetailsScreen> {

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileViewModel>(
      builder: (context, vm, _) {
        return  Form(
          key: _formKey,

          child: Column(
            children: [

              _buildTextField(
                vm.nameController,
                "Full Name",
                validator: Validators.name,
              ),

              const SizedBox(height: 8),

              _buildTextField(
                vm.mobileController,
                "0000000000",
                type: TextInputType.phone,
                validator: Validators.phone,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(10),
                ],
              ),


              const SizedBox(height: 8),

              _buildTextField(
                vm.emailController,
                "nikhil123@gmail.com",
                type: TextInputType.emailAddress,
                validator: Validators.email,
              ),

              const SizedBox(height: 8),

              /// GENDER
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
                    ),
                  ],
                ),

                child: Padding(
                  padding: const EdgeInsets.only(left: 25, right: 10),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      isExpanded: true,


                      hint: const Text("Gender"),

                      value: (vm.gender != null &&
                          vm.gender!.isNotEmpty)
                          ? vm.gender
                          : null,

                      items: ["Male", "Female", "Other"]
                          .map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
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

              _buildTextField(
                vm.dobController,
                "DD/MM/YYYY",
                type: TextInputType.number,
                validator: Validators.dob,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(8),
                  DateInputFormatter(),

                ],
              ),

              const SizedBox(height: 8),

              _buildTextField(
                vm.bloodGroupController,
                "Blood Group",
                validator: Validators.bloodGroup,
              ),

              const SizedBox(height: 8),




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
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 25, right: 10),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      isExpanded: true,

                      hint: const Text("Marital Status"),

                      value: (vm.status != null &&
                          vm.status!.isNotEmpty)
                          ? vm.status
                          : null,

                      items: ["Single", "Married", "Divorce"]
                          .map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),

                      onChanged: (newValue) {
                        vm.status = newValue;
                        vm.notifyListeners();
                      },
                    ),
                  ),
                ),
              ),




              const SizedBox(height: 8),

              _buildTextField(
                vm.heightController,
                "Height",
                type: TextInputType.number,
                validator: Validators.height,
              ),

              const SizedBox(height: 8),

              _buildTextField(
                  vm.weightController,
                  "Weight",
                  type: TextInputType.number,
                  validator: Validators.weight
              ),

              const SizedBox(height: 20),

              vm.isLoading
                  ? const CircularProgressIndicator()
                  : CustomAppButton(

                label: 'Save',

                onPressed: () async {

                  /// VALIDATE FORM
                  if (_formKey.currentState!.validate()) {

                    await vm.updateProfile();

                    if (context.mounted) {

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            "Profile updated successfully",
                          ),
                        ),
                      );
                    }
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildTextField(
      TextEditingController controller,
      String hint, {
        TextInputType type = TextInputType.text,
        String? Function(String?)? validator,
        List<TextInputFormatter>? inputFormatters,
      }) {
    return Container(
      height: 70,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6),
        boxShadow: [
          BoxShadow(
            color: const Color(0x26000000),
            blurRadius: 2,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 10),
        child: TextFormField(
          inputFormatters: inputFormatters,
          controller: controller,
          keyboardType: type,
          validator: validator,

          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(
              color: Color(0xff696E6A),
            ),
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
