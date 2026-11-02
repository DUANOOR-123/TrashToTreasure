import 'package:flutter/material.dart';

import 'package:trash2treasure/core/app_colors.dart';

class ReusableTextField extends StatelessWidget {
  final String label;
  final String hintText;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final String? prefixText;
  final int maxLines;

  const ReusableTextField({
    super.key,
    required this.label,
    required this.hintText,
    required this.controller,
    this.keyboardType = TextInputType.text,
    this.prefixText,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,

      decoration: InputDecoration(
        labelText: label,
        hintText: hintText,
        prefixText: prefixText,

        labelStyle: const TextStyle(color: AppColors.textColor),

        floatingLabelStyle: const TextStyle(color: AppColors.textColor),

        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),

        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: AppColors.selected),
        ),

        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: AppColors.borderColor,
            width: 1.5,
          ),
        ),
      ),
    );
  }
}
