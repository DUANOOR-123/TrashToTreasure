import 'package:flutter/material.dart';
import 'choose_role_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});
  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool agree = false;

  Widget _field(String h, {bool isPass = false}) {
    return TextField(
      obscureText: isPass,
      decoration: InputDecoration(
        hintText: h,
        hintStyle: const TextStyle(fontSize: 12),
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Create Account", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const Text("Join the Trash 2 Treasure community", style: TextStyle(color: Colors.grey, fontSize: 12)),
            const SizedBox(height: 20),
            _field("Full Name"),
            const SizedBox(height: 12),
            _field("Email or Phone Number"),
            const SizedBox(height: 12),
            _field("Password", isPass: true),
            const SizedBox(height: 10),
            Row(
              children: [
                Checkbox(
                  value: agree,
                  activeColor: Colors.green,
                  onChanged: (v) => setState(() => agree = v!),
                  visualDensity: VisualDensity.compact,
                ),
                const Text("I agree to Terms & Conditions", style: TextStyle(fontSize: 12)),
              ],
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              height: 45,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => const ChooseRoleScreen()));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2E7D32),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                ),
                child: const Text("Sign Up", style: TextStyle(color: Colors.white)),
              ),
            ),
            const SizedBox(height: 10),
            const Center(child: Text("Already have an account? Login", style: TextStyle(fontSize: 11))),
            const SizedBox(height: 5),
            const Center(child: Text("Check your email to verify your account", style: TextStyle(fontSize: 10, color: Colors.grey))),
          ],
        ),
      ),
    );
  }
}