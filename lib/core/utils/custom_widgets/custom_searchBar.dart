import 'package:flutter/material.dart';

import '../theams/color_resource.dart';

class CustomSearchBar extends StatelessWidget {
  final String hintText;
  final Icon? prefixIcon;
  final TextEditingController? controller;
  final Function(String)? onChanged;

  const CustomSearchBar({
    Key? key,
    required this.hintText,
    this.prefixIcon,
    this.controller,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ColorResource.lightBlue,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        decoration: InputDecoration(
          fillColor: ColorResource.lightBlue,
          prefixIcon: prefixIcon ?? Icon(Icons.search, color: Colors.grey.shade500),
          hintText: hintText,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
        ),
      ),
    );
  }
}