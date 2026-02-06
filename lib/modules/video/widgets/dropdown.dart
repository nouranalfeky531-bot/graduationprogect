import 'package:flutter/material.dart';
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
      decoration: InputDecoration(
        hintText: hint,
        // labelText: hint,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
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









