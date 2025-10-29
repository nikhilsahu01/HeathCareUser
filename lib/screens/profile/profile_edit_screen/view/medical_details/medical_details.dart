import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:health_care/core/utils/custom_widgets/custom_app_button.dart';

class MedicalDetails extends StatefulWidget {
  const MedicalDetails({super.key});

  @override
  State<MedicalDetails> createState() => _MedicalDetailsState();
}

class _MedicalDetailsState extends State<MedicalDetails> {
  String? selectedAllergies;
  String? selectedCurrentMedications;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 50,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(6),
            boxShadow: [
              BoxShadow(
                color: Color(0x26000000),
                blurRadius: 2,
                offset: Offset(0, 2),
                spreadRadius: 0,
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 25, right: 10),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                isExpanded: true,
                hint: Text(
                  "Allergies",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500,color: Color(0xff696E6A)),
                ),
                value: selectedAllergies,
                items: ["Male", "Female", "Other"].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500,color: Color(0xff696E6A)),
                    ),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    selectedAllergies = newValue!;
                  });
                },
              ),
            ),
          ),
        ),
        SizedBox(height: 8,),
        Container(
          height: 50,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(6),
            boxShadow: [
              BoxShadow(
                color: Color(0x26000000),
                blurRadius: 2,
                offset: Offset(0, 2),
                spreadRadius: 0,
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 25, right: 10),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                isExpanded: true,
                hint: Text(
                  "Current Medications",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500,color: Color(0xff696E6A)),
                ),
                value: selectedCurrentMedications,
                items: ["Male", "Female", "Other"].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500,color: Color(0xff696E6A)),
                    ),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    selectedCurrentMedications = newValue!;
                  });
                },
              ),
            ),
          ),
        ),
        SizedBox(height: 8,),
        Container(
          height: 50,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(6),
            boxShadow: [
              BoxShadow(
                color: Color(0x26000000),
                blurRadius: 2,
                offset: Offset(0, 2),
                spreadRadius: 0,
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 10,),
            child: TextField(
              textAlignVertical: TextAlignVertical.center,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  hintText: "Past Medications",
                  hintStyle: TextStyle(color: Color(0xff696E6A))
              ),
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500,color: Color(0xff696E6A)),
            ),
          ),
        ),
        SizedBox(height: 8,),
        Container(
          height: 50,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(6),
            boxShadow: [
              BoxShadow(
                color: Color(0x26000000),
                blurRadius: 2,
                offset: Offset(0, 2),
                spreadRadius: 0,
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 10, ),
            child: TextField(
              textAlignVertical: TextAlignVertical.center,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  hintText: "Chronic Diseases",
                  hintStyle: TextStyle(color: Color(0xff696E6A))
              ),
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500,color: Color(0xff696E6A)),
            ),
          ),
        ),
        SizedBox(height: 8,),
        Container(
          height: 50,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(6),
            boxShadow: [
              BoxShadow(
                color: Color(0x26000000),
                blurRadius: 2,
                offset: Offset(0, 2),
                spreadRadius: 0,
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 10),
            child: TextField(
              textAlignVertical: TextAlignVertical.center,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  hintText: "Injuries",
                  hintStyle: TextStyle(color: Color(0xff696E6A))
              ),
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500,color: Color(0xff696E6A)),
            ),
          ),
        ),
        SizedBox(height: 8,),
        Container(
          height: 50,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(6),
            boxShadow: [
              BoxShadow(
                color: Color(0x26000000),
                blurRadius: 2,
                offset: Offset(0, 2),
                spreadRadius: 0,
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 10),
            child: TextField(
              textAlignVertical: TextAlignVertical.center,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  hintText: "Surgeries",
                  hintStyle: TextStyle(color: Color(0xff696E6A))
              ),
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500,color: Color(0xff696E6A)),
            ),
          ),
        ),
        SizedBox(height: 20,),
        CustomAppButton(label: 'Save',onPressed: () {  },),
      ],
    );
  }
}
