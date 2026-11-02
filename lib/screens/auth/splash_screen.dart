import 'dart:async';
import 'package:flutter/material.dart';
import 'package:trash2treasure/core/app_colors.dart';
import 'package:trash2treasure/screens/auth/welcome_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Auto navigate to Welcome after 2 seconds
    Timer(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const WelcomeScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      body: Stack(
        children: [
          // LEFT LEAVES - BIGGER
          Positioned(
            bottom: -10,
            left: -10,
            child: Image.asset(
              'assets/images/leaves_left-removebg-preview.png',
              width: 260,
              fit: BoxFit.contain,
            ),
          ),
          // RIGHT LEAVES - BIGGER
          Positioned(
            bottom: -10,
            right: -10,
            child: Image.asset(
              'assets/images/leaves_right-removebg-preview.png',
              width: 170,
              fit: BoxFit.contain,
            ),
          ),
          // CENTER - CODED LOGO
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 110,
                  height: 110,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: const Color(0xFF0F5C35),
                      width: 2.5,
                    ),
                  ),
                  child: const Icon(
                    Icons.recycling,
                    size: 60,
                    color: Color(0xFF0F5C35),
                  ),
                ),
                const SizedBox(height: 24),
                const Text(
                  'Trash 2 Treasure',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF0F5C35),
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  'Reduce Waste\nReuse\nRebuild',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xFF7A9B8A),
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}