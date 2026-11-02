import 'package:flutter/material.dart';
import 'forgot_password_screen.dart';
import 'signup_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40),
              const Text("Welcome Back", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
              const Text("Login to your account", style: TextStyle(color: Colors.grey, fontSize: 12)),
              const SizedBox(height: 24),
              TextField(decoration: InputDecoration(hintText: "Email or Phone Number", hintStyle: TextStyle(fontSize: 12), contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 10), border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)))),
              const SizedBox(height: 12),
              TextField(obscureText: true, decoration: InputDecoration(hintText: "Password", hintStyle: TextStyle(fontSize: 12), contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 10), border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)))),
              const SizedBox(height: 8),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) => const ForgotPasswordScreen()));
                  },
                  child: const Text("Forgot Password?", style: TextStyle(fontSize: 11, color: Colors.black)),
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(width: double.infinity, height: 45, child: ElevatedButton(onPressed: () {}, style: ElevatedButton.styleFrom(backgroundColor: Color(0xFF2E7D32), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25))), child: const Text("Login", style: TextStyle(color: Colors.white)))),
              const SizedBox(height: 12),
              SizedBox(width: double.infinity, height: 45, child: OutlinedButton(onPressed: () {}, style: OutlinedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25))), child: const Text("Continue with Google", style: TextStyle(color: Colors.black, fontSize: 12)))),
              const SizedBox(height: 16),
              Center(
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) => const SignupScreen()));
                  },
                  child: const Text("Don't have an account? Sign Up", style: TextStyle(fontSize: 11)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}