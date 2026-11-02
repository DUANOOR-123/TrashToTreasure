import 'package:flutter/material.dart';
import 'package:trash2treasure/core/app_colors.dart';
import 'package:trash2treasure/core/app_nav.dart';
import 'package:trash2treasure/screens/auth/submit_id_screen.dart';

class VerificationResultScreen extends StatelessWidget {
  const VerificationResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      body: SafeArea(
        child: Center(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 24),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 10, offset: const Offset(0, 4))
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header - same style
                Row(
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const Icon(Icons.arrow_back, size: 20, color: Colors.black87),
                    ),
                    const SizedBox(width: 12),
                    const Text(
                      "Identity Verification",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Colors.black),
                    ),
                  ],
                ),
                const SizedBox(height: 22),

                // Center content - exact like your image
                Center(
                  child: Column(
                    children: [
                      // Red X Icon
                      Container(
                        width: 56,
                        height: 56,
                        decoration: const BoxDecoration(
                          color: Color(0xFFD32F2F),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.close, color: Colors.white, size: 32),
                      ),
                      const SizedBox(height: 14),
                      const Text(
                        "Your ID was not accepted.",
                        style: TextStyle(fontSize: 13, color: Color(0xFFD32F2F), fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        "Reason: Blurry photo.\nPlease upload a clear photo.",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 11.5, color: Color(0xFF6B7280), height: 1.4, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 22),

                // Try Again Button - Green
                SizedBox(
                  width: double.infinity,
                  height: 46,
                  child: ElevatedButton(
                    onPressed: () {
                      // Go back to Submit ID to upload a clearer photo
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (_) => const SubmitIdScreen()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF1F7A3A),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                      elevation: 0,
                    ),
                    child: const Text("Try Again", style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w600)),
                  ),
                ),
                const SizedBox(height: 10),

                // Back to Home Button - White
                SizedBox(
                  width: double.infinity,
                  height: 46,
                  child: OutlinedButton(
                    onPressed: () {
                      AppNav.goHome(context);
                    },
                    style: OutlinedButton.styleFrom(
                      backgroundColor: Colors.white,
                      side: const BorderSide(color: Color(0xFFEAEAEA)),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                    ),
                    child: const Text("Back to Home", style: TextStyle(color: Color(0xFF5A5A5A), fontSize: 13, fontWeight: FontWeight.w600)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}