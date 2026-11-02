import 'package:flutter/material.dart';

class VerificationStatusScreen extends StatelessWidget {
  const VerificationStatusScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
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
                      "Verification Status",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Colors.black),
                    ),
                  ],
                ),
                const SizedBox(height: 18),

                // Center content - exact like your image
                Center(
                  child: Column(
                    children: [
                      // Hourglass icon - like screenshot
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          color: const Color(0xFFFEF9E7),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(Icons.hourglass_bottom_rounded, color: Color(0xFF1F7A3A), size: 36),
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        "Your ID has been submitted\nand is under review.",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 12, color: Color(0xFF5A5A5A), height: 1.4, fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(height: 10),
                      // Pending badge
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFEF3C7),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Text(
                          "Pending",
                          style: TextStyle(fontSize: 11, color: Color(0xFF92400E), fontWeight: FontWeight.w600),
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        "We'll notify you once it's verified.",
                        style: TextStyle(fontSize: 11, color: Color(0xFF8A8A8A)),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                // Back to Home - same style as Enter Manually
                SizedBox(
                  width: double.infinity,
                  height: 46,
                  child: OutlinedButton(
                    onPressed: () {
                      // TODO: go to home screen - replace with your HomeScreen
                      Navigator.popUntil(context, (route) => route.isFirst);
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