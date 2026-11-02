import 'package:flutter/material.dart';

import 'package:trash2treasure/core/app_colors.dart';

class ReusableDropdown extends StatelessWidget {
  final String label;
  final List<String> items;
  final String selectedValue;
  final ValueChanged<String?> onChanged;

  const ReusableDropdown({
    super.key,
    required this.label,
    required this.items,
    required this.selectedValue,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      initialValue: selectedValue,

      decoration: InputDecoration(
        labelText: label,

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

      items: items.map((item) {
        return DropdownMenuItem<String>(value: item, child: Text(item));
      }).toList(),

      onChanged: onChanged,
    );
  }
}
