import 'package:flutter/material.dart';

import 'package:trash2treasure/core/app_colors.dart';

class MenuCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback? onTap;
  final Color iconColor;
  final Color textColor;
  final Color backgroundColor;
  final Color borderColor;

  const MenuCard({
    super.key,
    required this.icon,
    required this.label,
    this.onTap,
    this.iconColor = AppColors.textColor,
    this.textColor = AppColors.textColor,
    this.backgroundColor = AppColors.backgroundColor,
    this.borderColor = AppColors.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: borderColor, width: 1),
        ),

        child: ListTile(
          leading: Icon(icon, color: iconColor),
          title: Text(label, style: TextStyle(color: textColor)),
          trailing: Icon(Icons.chevron_right),
        ),
      ),
    );
  }
}
