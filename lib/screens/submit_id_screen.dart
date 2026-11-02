import 'package:flutter/material.dart';

import 'verification_status_screen.dart';

class SubmitIdScreen extends StatefulWidget {
  const SubmitIdScreen({super.key});
  @override
  State<SubmitIdScreen> createState() => _SubmitIdScreenState();
}

class _SubmitIdScreenState extends State<SubmitIdScreen> {
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
                BoxShadow(
                  color: Colors.black..withValues(alpha: 0.5),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Row(
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const Icon(
                        Icons.arrow_back,
                        size: 20,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(width: 12),
                    const Text(
                      "Identity Verification",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                const Text(
                  "Upload your ID card and a selfie\nfor verification.",
                  style: TextStyle(
                    fontSize: 12,
                    color: Color(0xFF8A8A8A),
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 18),

                // 3 Boxes - Front, Back, Selfie
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildUploadBox("Front"),
                    _buildUploadBox("Back"),
                    _buildUploadBox("Selfie", isPerson: true),
                  ],
                ),
                const SizedBox(height: 20),

                // Submit Button - EXACT green like screenshot
                SizedBox(
                  width: double.infinity,
                  height: 46,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const VerificationStatusScreen(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF1F7A3A),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                    ),
                    child: const Text(
                      "Submit",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),

                // Skip for now - EXACT like screenshot
                Center(
                  child: GestureDetector(
                    onTap: () {
                      // Skip
                      Navigator.pop(context);
                    },
                    child: const Text(
                      "Skip for now",
                      style: TextStyle(
                        fontSize: 12,
                        color: Color(0xFF9E9E9E),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildUploadBox(String label, {bool isPerson = false}) {
    return Column(
      children: [
        Container(
          width: 72,
          height: 72,
          decoration: BoxDecoration(
            color: const Color(0xFFF5F5F5),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: const Color(0xFFE0E0E0),
              style: BorderStyle.solid,
              width: 1,
            ),
          ),
          child: Icon(
            isPerson ? Icons.person_outline : Icons.camera_alt_outlined,
            color: const Color(0xFF1F7A3A),
            size: 28,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          label,
          style: const TextStyle(
            fontSize: 11,
            color: Color(0xFF8A8A8A),
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
