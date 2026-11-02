import 'package:flutter/material.dart';
import 'package:trash2treasure/core/app_colors.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      appBar: AppBar(
        backgroundColor: AppColors.bg,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Reset Password", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 6),
            const Text("Enter your email or phone number to receive a reset link.",
                style: TextStyle(color: Colors.grey, fontSize: 12)),
            const SizedBox(height: 24),

            TextField(
              decoration: InputDecoration(
                hintText: "Email or Phone Number",
                hintStyle: TextStyle(fontSize: 12),
                contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
              ),
            ),
            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              height: 45,
              child: ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Reset link sent!")),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF2E7D32),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                ),
                child: const Text("Send Link", style: TextStyle(color: Colors.white)),
              ),
            ),
            const SizedBox(height: 16),

            Center(
              child: TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Back to Login", style: TextStyle(fontSize: 12, color: Color(0xFF2E7D32))),
              ),
            ),
          ],
        ),
      ),
    );
  }
}