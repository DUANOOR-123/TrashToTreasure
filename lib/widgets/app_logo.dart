import 'package:flutter/material.dart';
import 'package:trash2treasure/core/app_colors.dart';

class AppLogo extends StatelessWidget {
  final double size;
  const AppLogo({super.key, this.size = 80});
  @override
  Widget build(BuildContext context) {
    return Icon(Icons.recycling, size: size, color: AppColors.textColor);
    // Later you can replace with Image.asset('assets/logo.png')
  }
}