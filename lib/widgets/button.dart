import 'package:flutter/material.dart';

import 'package:trash2treasure/core/app_colors.dart';

class Button extends StatelessWidget {
  final String buttonText;
  final Color buttonColor;
  final Color buttonTextColor;
  final double fontSize;

  final IconData? icon;
  final VoidCallback? onPressed;

  const Button({
    super.key,
    required this.buttonText,
    this.buttonColor = AppColors.textColor,
    this.buttonTextColor = Colors.white,
    this.icon,
    this.fontSize = 14,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: buttonColor, // use your green
        ),
        icon: icon != null ? Icon(icon, color: buttonTextColor) : null,
        label: Text(
          buttonText,
          style: TextStyle(fontSize: fontSize, color: buttonTextColor),
        ),
      ),
    );
  }
}
