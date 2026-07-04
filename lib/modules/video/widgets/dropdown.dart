import 'package:flutter/material.dart';
import 'package:graduation_progect/core/theme/app_colors.dart';
import 'package:graduation_progect/modules/video/models/Data.dart';

import '../models/AvailableLanguages.dart';

class CustomDropdown extends StatelessWidget {
  final String hint;
  final String? value;
  final List<String>? items;
  final Function(String?) onChanged;


  const CustomDropdown({
    required this.hint,
     this.items,
    required this.onChanged,
    this.value,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      isExpanded: true,
      decoration: InputDecoration(
        border: InputBorder.none,
        enabledBorder: InputBorder.none,
        focusedBorder: InputBorder.none,
        hintStyle: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Colors.black),
        filled: true,
         fillColor: Colors.transparent,
         hoverColor: Colors.red,

        hintText: hint,
        // labelText: hint,
        // border: OutlineInputBorder(
        //
        //   borderRadius: BorderRadius.circular(25),
        //   borderSide: BorderSide(color: Colors.yellow)
        // ),
      ),
      value: value,
      items: items?.map((item) {
        return DropdownMenuItem<String>(
          value: item,
          child: Text(item!),
        );
      }).toList(),
      onChanged: onChanged,
    );
  }
}









