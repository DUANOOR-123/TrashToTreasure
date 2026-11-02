import 'package:flutter/material.dart';
import 'package:trash2treasure/core/app_colors.dart';
import 'package:trash2treasure/core/app_session.dart';
import 'package:trash2treasure/core/app_nav.dart';
import 'package:trash2treasure/screens/admin/admin_login_screen.dart';
import 'package:trash2treasure/screens/auth/signup_screen.dart';
import 'package:trash2treasure/screens/auth/login_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              const Text("Welcome to", style: TextStyle(fontSize: 16, color: Colors.grey)),
              const SizedBox(height: 4),
              GestureDetector(
                // Hidden door to the Admin Portal: long-press the title
                onLongPress: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => const AdminLoginScreen()));
                },
                child: const Text("Trash 2 Treasure", style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) => const SignupScreen()));
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: Color(0xFF2E7D32), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25))),
                  child: const Text("Get Started", style: TextStyle(color: Colors.white)),
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) => const LoginScreen()));
                  },
                  style: OutlinedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25))),
                  child: const Text("Login", style: TextStyle(color: Colors.black)),
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: OutlinedButton(
                  onPressed: () {
                    // Guest: browse only (no posting, requesting or chatting)
                    AppSession.startGuest();
                    AppNav.goHome(context);
                  },
                  style: OutlinedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25))),
                  child: const Text("Continue as Guest", style: TextStyle(color: Colors.black)),
                ),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}