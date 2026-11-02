import 'package:flutter/material.dart';

import 'package:trash2treasure/core/app_colors.dart';

class ReusableRadioTile extends StatelessWidget {
  final String value;
  final String title;
  final bool isSelected;

  final Color unselectedTileColor;
  final Color borderColor;
  final Color selectedTileColor;
  final Color radioColor;

  const ReusableRadioTile({
    super.key,
    required this.value,
    required this.title,
    required this.isSelected,
    this.unselectedTileColor = AppColors.backgroundColor,
    this.borderColor = AppColors.borderColor,
    this.selectedTileColor = AppColors.selected,
    this.radioColor = AppColors.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: isSelected ? selectedTileColor : unselectedTileColor,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: borderColor),
      ),
      child: RadioListTile<String>(
        value: value,
        title: Text(title),
        selected: isSelected,
        controlAffinity: ListTileControlAffinity.leading,

        tileColor: Colors.transparent,
        selectedTileColor: Colors.transparent,

        fillColor: WidgetStateProperty.resolveWith<Color?>((states) {
          if (states.contains(WidgetState.selected)) {
            return radioColor;
          }
          return Colors.grey;
        }),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      ),
    );
  }
}
