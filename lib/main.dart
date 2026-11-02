import 'package:flutter/material.dart';

import 'package:trash2treasure/core/app_theme.dart';
import 'package:trash2treasure/dev/screen_menu.dart';
import 'package:trash2treasure/screens/auth/splash_screen.dart';

/// Developer switch: true = start on a list of every screen (to open one
/// by itself). Keep it false for the real app flow.
const bool kShowScreenMenu = false;

void main() {
  runApp(const MyApp());
}

/// App flow (start here to understand the whole app):
///
///   Splash -> Welcome -> Sign Up -> Choose Role -> Location -> Submit ID
///          |                                                      |
///          +-> Login -----------------------------+               |
///          +-> Continue as Guest (browse only) ---+---------------+
///                                                 v
///                         BuyerShell (Home | Map | + | Messages | Profile)
///                           "+"  -> Seller Home (sellers)
///                                -> "Enable Selling" sheet (buyers)
///
///   Admin Portal: long-press the title on the Welcome screen.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Trash 2 Treasure',
      theme: AppTheme.light,
      home: kShowScreenMenu ? const ScreenMenu() : const SplashScreen(),
    );
  }
}
