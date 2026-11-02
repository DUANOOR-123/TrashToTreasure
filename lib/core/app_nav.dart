import 'package:flutter/material.dart';

import 'package:trash2treasure/core/app_colors.dart';
import 'package:trash2treasure/core/app_session.dart';
import 'package:trash2treasure/screens/auth/login_screen.dart';
import 'package:trash2treasure/screens/auth/welcome_screen.dart';
import 'package:trash2treasure/screens/buyer/buyer_shell.dart';

/// Small helpers that move the user between the big parts of the app.
class AppNav {
  AppNav._();

  /// Opens the main app (bottom bar) and removes every earlier screen,
  /// so Back does not return to Login / Onboarding.
  static void goHome(BuildContext context) {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => const BuyerShell()),
      (route) => false,
    );
  }

  /// Back to the Welcome screen with a clean history.
  static void logout(BuildContext context) {
    AppSession.reset();
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => const WelcomeScreen()),
      (route) => false,
    );
  }

  /// Guests can only browse. Call this before an action that needs an
  /// account (chat, request pickup, sell...). Returns true when the
  /// action may continue; for a guest it shows a "Log in" dialog and
  /// returns false.
  static bool requireLogin(BuildContext context, {String action = 'do this'}) {
    if (!AppSession.isGuest) return true;

    showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          backgroundColor: AppColors.bg,
          title: const Text(
            'Log in required',
            style: TextStyle(
              color: AppColors.textColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text(
            'Please log in or create an account to $action.',
            style: const TextStyle(color: AppColors.textColor),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text(
                'Not now',
                style: TextStyle(color: AppColors.textColor),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.textColor,
                foregroundColor: Colors.white,
              ),
              onPressed: () {
                Navigator.pop(dialogContext);
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (_) => const LoginScreen()),
                  (route) => false,
                );
              },
              child: const Text('Log in'),
            ),
          ],
        );
      },
    );
    return false;
  }
}
