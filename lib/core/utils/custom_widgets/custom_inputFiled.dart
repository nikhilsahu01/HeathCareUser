import 'package:flutter/material.dart';

import '../theams/color_resource.dart';

class CustomAddressInputField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final EdgeInsetsGeometry padding;

  const CustomAddressInputField({
    Key? key,
    required this.controller,
    this.hintText = "Enter",
    this.padding = const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: padding,
      decoration: BoxDecoration(
        color: const Color(0xFFF2F7FF),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.05),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.location_on_outlined, color: ColorResource.primaryBlue),
          const SizedBox(width: 12),
          Expanded(
            child: TextField(
              controller: controller,
              maxLines: 3,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: ColorResource.darkText,
              ),
              decoration: InputDecoration(
                hintText: hintText,
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
/// registration screen



class CustomTextField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final bool isReadOnly;
  final Function()? onTap;
  final bool isDropdown;
  final List<String>? dropdownItems;
  final int? maxLines;
  final Widget? suffixIcon;

  const CustomTextField({
    Key? key,
    required this.label,
    required this.controller,
    this.validator,
    this.isReadOnly = false,
    this.onTap,
    this.isDropdown = false,
    this.dropdownItems,
    this.maxLines,
    this.suffixIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(color: Colors.black)),
        const SizedBox(height: 5),
        isDropdown
            ? DropdownButtonFormField<String>(
          dropdownColor:  ColorResource.white,
          value: controller.text.isNotEmpty ? controller.text : null,
          items: dropdownItems?.map((String item) {
            return DropdownMenuItem<String>(
              value: item,
              child: Text(item),
            );
          }).toList(),
          onChanged: (value) {
            controller.text = value ?? '';
          },
          decoration: _inputDecoration(),
          validator: validator,
        )
            : TextFormField(
          controller: controller,
          readOnly: isReadOnly,
          onTap: onTap,
          maxLines: maxLines,
          decoration: _inputDecoration().copyWith(
            suffixIcon: suffixIcon,
          ),
          validator: validator,
        ),
      ],
    );
  }

  InputDecoration _inputDecoration() {
    return InputDecoration(
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.grey),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: ColorResource.primaryBlue),
      ),
    );
  }
}