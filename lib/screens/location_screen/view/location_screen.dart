import 'package:flutter/material.dart';
import 'package:health_care/core/utils/custom_widgets/custom_appBar.dart';
import 'package:health_care/core/utils/custom_widgets/custom_app_button.dart';
import 'package:health_care/core/utils/custom_widgets/custom_threeDots_indecator.dart';
import 'package:health_care/core/utils/navigation_helper.dart';
import 'package:health_care/core/utils/theams/color_resource.dart';
import 'package:provider/provider.dart';

import '../address_model.dart';
import '../address_provider.dart';


class LocationScreen extends StatefulWidget {
  const LocationScreen({super.key});

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  final _formKey = GlobalKey<FormState>();

  bool showForm = false;
  bool isSubmitting = false;
  int? editingIndex;
  String addressType = "Home";

  // Controllers
  final floorController = TextEditingController();
  final address1Controller = TextEditingController();
  final landmarkController = TextEditingController();
  final receiverNameController = TextEditingController();
  final receiverNumberController = TextEditingController();
  final cityController = TextEditingController();
  final stateController = TextEditingController();
  final countryController = TextEditingController();
  final pincodeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<AddressViewModel>(context, listen: false).fetchAddresses();
    });
  }

  void openForm({HomeAddressData? data, int? index}) {
    setState(() {
      showForm = true;
      editingIndex = index;
    });

    if (data != null) {
      addressType = data.addressType ?? "Home";
      floorController.text = data.floor ?? '';
      address1Controller.text = data.addressLine1 ?? '';
      landmarkController.text = data.landmark ?? '';
      cityController.text = data.city ?? '';
      stateController.text = data.state ?? '';
      countryController.text = data.country ?? '';
      pincodeController.text = data.pincode ?? '';
      receiverNameController.text = "na";
      receiverNumberController.text = data.mobileNumber ?? '';
    } else {
      clearForm();
    }
  }

  void clearForm() {
    addressType = "Home";
    floorController.clear();
    address1Controller.clear();
    landmarkController.clear();
    cityController.clear();
    stateController.clear();
    countryController.clear();
    pincodeController.clear();
    receiverNameController.clear();
    receiverNumberController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AddressViewModel>(
      builder: (context, provider, child) {
        return Scaffold(
          backgroundColor: ColorResource.white,
          appBar: const CustomAppBar(title: 'My Address'),
          body: provider.isLoading
              ? const Center(child: ThreeDotsLoader())
              : SingleChildScrollView(
            padding: const EdgeInsets.only(left:16,right: 16,bottom: 16),
            child: Column(
              children: [
                if (provider.addresses.isEmpty && !showForm)
                  Column(
                    children: [
                      const Icon(Icons.location_off,
                          size: 60, color: Colors.grey),
                      const SizedBox(height: 12),
                      const Text("No address added yet",
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 16)),
                      const SizedBox(height: 20),
                      CustomAppButton(
                        label: "Add Address",
                        onPressed: () => openForm(),
                      )
                    ],
                  ),
                if (provider.addresses.isNotEmpty && !showForm)
                  Column(
                    children: provider.addresses
                        .asMap()
                        .entries
                        .map((entry) =>
                        _buildAddressCard(entry.value, entry.key))
                        .toList(),
                  ),
                if (showForm) _buildAddressForm(provider),
                const SizedBox(height: 20),
                if (provider.addresses.isNotEmpty)
                  GestureDetector(
                    onTap: () {
                      if (showForm) {
                        clearForm();
                        setState(() => showForm = false);
                      } else {
                        openForm();
                      }
                    },
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        showForm ? "Cancel" : "+ Add New Address",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: ColorResource.primaryBlue,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildAddressCard(HomeAddressData address, int index) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: ColorResource.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: address.isDefault == true
              ? ColorResource.primaryBlue
              : Colors.grey.shade300,
          width: 2,
        ),
        boxShadow: const [
          BoxShadow(
              color: Colors.black12, blurRadius: 6, spreadRadius: 1, offset: Offset(0, 2))
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(address.addressType ?? 'Home',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: ColorResource.primaryBlue)),
                const SizedBox(height: 4),
                Text("${address.addressLine1 ?? ''}, ${address.landmark ?? ''}"),
                Text(
                    "${address.city ?? ''}, ${address.state ?? ''}, ${address.country ?? ''} - ${address.pincode ?? ''}"),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.edit, color: Colors.blue),
            onPressed: () => openForm(data: address, index: index),
          ),
          // IconButton(
          //   icon: const Icon(Icons.delete, color: Colors.red),
          //   onPressed: () async {
          //     final confirm = await showDialog<bool>(
          //       context: context,
          //       builder: (_) => AlertDialog(
          //         backgroundColor: ColorResource.white,
          //         title: const Text("Delete Address"),
          //         content:
          //         const Text("Are you sure you want to delete this address?"),
          //         actions: [
          //           TextButton(
          //               onPressed: () => Navigator.pop(context, false),
          //               child: const Text("Cancel")),
          //           TextButton(
          //               onPressed: () => Navigator.pop(context, true),
          //               child: const Text("Delete")),
          //         ],
          //       ),
          //     );
          //     if (confirm == true) {
          //       await Provider.of<AddressViewModel>(context, listen: false)
          //           .deleteAddress(address.sId ?? '');
          //       // navPop(context: context);
          //     }
          //   },
          // ),
        ],
      ),
    );
  }

  Widget _buildAddressForm(AddressViewModel provider) {
    return Card(
      color:ColorResource.white,
      elevation: 3,
      margin: const EdgeInsets.only(top: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Wrap(
                spacing: 10,
                children: ['Home', 'Work', 'Others']
                    .map(
                      (type) => ChoiceChip(
                    showCheckmark: false,
                    label: Text(
                      type,
                      style: TextStyle(
                        color: addressType == type ? ColorResource.white : Colors.black,
                      ),
                    ),
                    selected: addressType == type,
                    selectedColor: ColorResource.primaryBlue,
                    onSelected: (_) => setState(() => addressType = type),
                  ),
                )
                    .toList(),
              ),
              const SizedBox(height: 12),
              _buildTextField(cityController, "City *"),
              _buildTextField(stateController, "State *"),
              _buildTextField(countryController, "Country *"),
              _buildTextField(pincodeController, "Pincode *"),
              _buildTextField(floorController, "Floor *"),
              _buildTextField(address1Controller,
                  "House/Flat Number & Building Name *"),
              _buildTextField(landmarkController, "Landmark *"),
              // _buildTextField(receiverNameController, "Receiver Name"),
              _buildTextField(receiverNumberController, "Receiver Number",
                  maxLength: 10, keyboardType: TextInputType.phone),
              const SizedBox(height: 16),
              CustomAppButton(
                label: editingIndex != null ? "Update Address" : "Save Address",
                onPressed: isSubmitting
                    ? () {}
                    : () async {
                  if (_formKey.currentState!.validate()) {
                    setState(() => isSubmitting = true);
                    bool success = false;

                    if (editingIndex != null) {
                      success = await provider.updateAddress(
                        context: context,
                        id: provider.addresses[editingIndex!].sId ?? '',
                        floor: floorController.text,
                        mobileNumber: receiverNumberController.text,
                        addressLine1: address1Controller.text,
                        addressLine2: "",
                        landmark: landmarkController.text,
                        city: cityController.text,
                        state: stateController.text,
                        country: countryController.text,
                        pincode: pincodeController.text,
                        addressType: addressType,
                        isDefault: true,
                      );
                    } else {
                      success = await provider.addAddress(
                        context: context,
                        floor: floorController.text,
                        mobileNumber: receiverNumberController.text,
                        addressLine1: address1Controller.text,
                        addressLine2: "",
                        landmark: landmarkController.text,
                        city: cityController.text,
                        state: stateController.text,
                        country: countryController.text,
                        pincode: pincodeController.text,
                        addressType: addressType,
                        isDefault: true,
                      );
                    }

                    if (success) {
                      clearForm();
                      setState(() {
                        showForm = false;
                        editingIndex = null;
                      });
                    }
                    setState(() => isSubmitting = false);
                  }
                },
                child: isSubmitting
                    ? const ThreeDotsLoader(color: ColorResource.white)
                    : null,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label,
      {int? maxLength, TextInputType keyboardType = TextInputType.text}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextFormField(
        controller: controller,
        maxLength: maxLength,
        keyboardType: keyboardType,
        validator: (val) =>
        val == null || val.isEmpty ? "Required field" : null,
        decoration: InputDecoration(
          counterText: '',
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
    );
  }
}
