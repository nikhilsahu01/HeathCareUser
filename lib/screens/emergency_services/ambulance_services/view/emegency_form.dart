import 'package:flutter/material.dart';
import 'package:health_care/core/utils/custom_widgets/custom_app_button.dart';
import 'package:health_care/core/utils/theams/color_resource.dart';
import 'package:health_care/screens/emergency_services/widgets/confirmation_booking_dialog.dart';
import 'package:provider/provider.dart';
import '../../../../core/utils/custom_widgets/custom_appBar.dart';
import '../../../../core/utils/global_variables.dart';
import '../../../../core/utils/helper_functions/helpers_methods.dart';
import '../ambulance_provider/add_address_manually_provider.dart';


// class EmergencyFormScreen extends StatefulWidget {
//
//
//   const EmergencyFormScreen({super.key,
//   });
//
//   @override
//   State<EmergencyFormScreen> createState() => _EmergencyFormScreenState();
// }
//
// class _EmergencyFormScreenState extends State<EmergencyFormScreen> {
//   final hours = List.generate(12, (i) => (i + 1).toString().padLeft(2, '0'));
//   final minutes = ['00', '15', '30', '45'];
//
//   @override
//   Widget build(BuildContext context) {
//     final width = MediaQuery.of(context).size.width;
//
//     return Scaffold(
//       backgroundColor: ColorResource.white,
//       appBar: CustomAppBar(title: 'Emergency Form'),
//       body: Consumer<AddAddressManuallyProvider>(
//         builder: (context, pro, child) {
//           return Padding(
//             padding: EdgeInsets.symmetric(horizontal: width * 0.05),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 _buildTextField(pro.patientNameController, 'Enter Patient’s Name*'),
//                 _buildTextField(pro.pickupController, 'Pickup Location*'),
//                 _buildTextField(pro.dropController, 'Drop Location*'),
//                 _buildDateField(pro.dateController, 'Date'),
//                 if(bookingFor == 'bookingForLater')...[
//                   const SizedBox(height: 20),
//                   const Text('Set time', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
//                   const SizedBox(height: 10),
//                   Row(
//                     children: [
//                       _buildTimeDropdown(hours, pro.selectedHour, (val) {
//                         if (val != null) setState(() => pro.selectedHour = val);
//                       }),
//                       const Text(" : "),
//                       _buildTimeDropdown(minutes, pro.selectedMinute, (val) {
//                         if (val != null) setState(() => pro.selectedMinute = val);
//                       }),
//                       const SizedBox(width: 10),
//                       _buildTimeDropdown(['AM', 'PM'], pro.selectedPeriod, (val) {
//                         if (val != null) setState(() => pro.selectedPeriod = val);
//                       }),
//                     ],
//                   ),
//                 ],
//                 const Spacer(),
//                 CustomAppButton(
//                   label: pro.isLoading ? 'Submitting...' : 'Submit',
//                   onPressed: pro.isLoading ?(){} :() async {
//                     if (pro.error == null) {
//                       if (
//                       // pro.floorController.text.trim().isEmpty ||
//                       //     pro.houseController.text.trim().isEmpty ||
//                           pro.pickupController.text.trim().isEmpty ||
//                           pro.patientNameController.text.trim().isEmpty ||
//                           pro.dropController.text.trim().isEmpty
//                       // ||
//                           // pro.landmarkController.text.trim().isEmpty
//                       )
//                       {
//                         HelperMethods.showCustomSnackbar(
//                           context,
//                           message: "Please fill all mandatory fields",
//                         );
//                         return;
//                       }
//                       showDialog(
//                         context: context,
//                         builder: (_) => BookingConfirmationDialogue(
//                           message: "An Ambulance will be booked right away. Are you Sure?",
//                           onPressed: () async {
//                             await pro.getCurrentLocation();
//                             await pro.addNewAddress(context: context);
//                             // navPushRemove(context: context, page: BottomNavController());
//                           },
//                         ),
//                       );
//                     } else {
//                       ScaffoldMessenger.of(context).showSnackBar(
//                         SnackBar(content: Text("Error: ${pro.error}")),
//                       );
//                     }
//                   },
//                 ),
//                 const SizedBox(height: 20),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
//
//   Widget _buildTextField(TextEditingController controller, String hint) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8.0),
//       child: TextField(
//         controller: controller,
//         decoration: InputDecoration(
//           hintText: hint,
//           border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
//         ),
//       ),
//     );
//   }
//   _buildDateField(TextEditingController controller, String label) {
//     return GestureDetector(
//       onTap: () async {
//         FocusScope.of(context).requestFocus(FocusNode()); // Hide keyboard
//         DateTime? pickedDate = await showDatePicker(
//           context: context,
//           initialDate: DateTime.now(),
//           firstDate: DateTime(2000),
//           lastDate: DateTime(2100),
//         );
//         if (pickedDate != null) {
//           String formattedDate =
//               "${pickedDate.year}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.day.toString().padLeft(2, '0')}";
//           controller.text = formattedDate;
//         }
//       },
//       child: AbsorbPointer(child: _buildTextField(controller, label)),
//     );
//   }
//   Widget _buildTimeDropdown(List<String> items, String value, ValueChanged<String?> onChanged) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 12),
//       margin: const EdgeInsets.only(right: 10),
//       decoration: BoxDecoration(
//         color: const Color(0xfff0eeee),
//         borderRadius: BorderRadius.circular(8),
//       ),
//       child: DropdownButton<String>(
//         value: value,
//         underline: const SizedBox(),
//         items: items.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
//         onChanged: onChanged,
//       ),
//     );
//   }
// }
class EmergencyFormScreen extends StatefulWidget {
  const EmergencyFormScreen({super.key});

  @override
  State<EmergencyFormScreen> createState() => _EmergencyFormScreenState();
}

class _EmergencyFormScreenState extends State<EmergencyFormScreen> {
  final hours = List.generate(12, (i) => (i + 1).toString().padLeft(2, '0'));
  final minutes = ['00', '15', '30', '45'];

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: ColorResource.white,
      appBar: CustomAppBar(title: 'Emergency Form'),
      body: Consumer<AddAddressManuallyProvider>(
        builder: (context, pro, child) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: width * 0.05),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildTextField(pro.patientNameController, 'Enter Patient’s Name*'),
                _buildTextField(pro.mobilenumberController, 'Mobile Number*'),
                _buildTextField(pro.pickupController, 'Pickup Location*'),
                _buildTextField(pro.dropController, 'Drop Location*'),
                if (bookingFor == 'bookingForLater') ...[
                  _buildDateField(pro.dateController, 'Date'),
                  const SizedBox(height: 20),
                  const Text('Set time',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      _buildTimeDropdown(hours, pro.selectedHour, (val) {
                        if (val != null) setState(() => pro.selectedHour = val);
                      }),
                      const Text(" : "),
                      _buildTimeDropdown(minutes, pro.selectedMinute, (val) {
                        if (val != null) setState(() => pro.selectedMinute = val);
                      }),
                      const SizedBox(width: 10),
                      _buildTimeDropdown(['AM', 'PM'], pro.selectedPeriod, (val) {
                        if (val != null) setState(() => pro.selectedPeriod = val);
                      }),
                    ],
                  ),
                ],

                const Spacer(),
                CustomAppButton(
                  label: pro.isLoading ? 'Submitting...' : 'Submit',
                  onPressed: pro.isLoading
                      ? () {}
                      : () async {
                    if (pro.error == null) {
                      if (pro.patientNameController.text.trim().isEmpty ||
                          pro.mobilenumberController.text.trim().isEmpty ||
                          pro.pickupController.text.trim().isEmpty ||
                          pro.dropController.text.trim().isEmpty) {
                        HelperMethods.showCustomSnackbar(
                          context,
                          message: "Please fill all mandatory fields",
                        );
                        return;
                      }

                      showDialog(
                        context: context,
                        builder: (_) => BookingConfirmationDialogue(
                          message:
                          "An Ambulance will be booked right away. Are you Sure?",
                          onPressed: () async {
                            await pro.getCurrentLocation();
                            await pro.addNewAddress(context: context);
                          },
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Error: ${pro.error}")),
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

  Widget _buildTextField(TextEditingController controller, String hint) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: hint,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
    );
  }

  Widget _buildDateField(TextEditingController controller, String label) {
    return GestureDetector(
      onTap: () async {
        FocusScope.of(context).unfocus();
        DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: DateTime(2100),
        );
        if (pickedDate != null) {
          controller.text =
          "${pickedDate.year}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.day.toString().padLeft(2, '0')}";
        }
      },
      child: AbsorbPointer(child: _buildTextField(controller, label)),
    );
  }

  Widget _buildTimeDropdown(
      List<String> items, String value, ValueChanged<String?> onChanged) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      margin: const EdgeInsets.only(right: 10),
      decoration: BoxDecoration(
        color: const Color(0xfff0eeee),
        borderRadius: BorderRadius.circular(8),
      ),
      child: DropdownButton<String>(
        value: value,
        underline: const SizedBox(),
        items: items.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
        onChanged: onChanged,
      ),
    );
  }
}
