import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:trash2treasure/core/app_colors.dart';

/// ONE theme for the whole app, so every screen gets the same mint
/// background, the same app bar and the same green accent without
/// each screen having to set it again.
class AppTheme {
  AppTheme._();

  static ThemeData get light {
    final scheme = ColorScheme.fromSeed(
      seedColor: AppColors.textColor,
      surface: AppColors.bg,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      scaffoldBackgroundColor: AppColors.bg,
      textTheme: GoogleFonts.nunitoTextTheme(),
      primaryTextTheme: GoogleFonts.nunitoTextTheme(),
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.bg,
        foregroundColor: AppColors.textColor,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
      ),
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: AppColors.bg,
        surfaceTintColor: Colors.transparent,
      ),
    );
  }
}
