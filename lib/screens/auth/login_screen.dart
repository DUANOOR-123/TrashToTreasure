import 'package:flutter/material.dart';
import 'package:trash2treasure/core/app_colors.dart';
import 'package:trash2treasure/core/app_session.dart';
import 'package:trash2treasure/core/app_nav.dart';
import 'package:trash2treasure/screens/auth/forgot_password_screen.dart';
import 'package:trash2treasure/screens/auth/signup_screen.dart';
import 'package:trash2treasure/services/api_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _contactController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _contactController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    if (_isLoading) return;

    final contact = _contactController.text.trim();
    final password = _passwordController.text;

    if (contact.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter email and password")),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      final response = await ApiService.login(
        contact: contact,
        password: password,
      );

      final token = response["token"];
      if (token is! String || token.isEmpty) {
        throw Exception("Login response did not contain a token");
      }

      final user = response["user"] as Map<String, dynamic>;

      if (!mounted) return;

      // Save session info (same as signup does)
      AppSession.authToken = token;
      AppSession.userName = user["full_name"] ?? AppSession.userName;
      AppSession.role =
          AppSession.roleFromString((user["role"] ?? "both").toString());
      AppSession.signIn();

      AppNav.goHome(context);
    } catch (error) {
      if (!mounted) return;

      final message = error.toString().replaceFirst("Exception: ", "");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message)),
      );
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 40),
                const Text("Welcome Back",
                    style:
                        TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                const Text("Login to your account",
                    style: TextStyle(color: Colors.grey, fontSize: 12)),
                const SizedBox(height: 24),
                TextField(
                  controller: _contactController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    hintText: "Email or Phone Number",
                    hintStyle: const TextStyle(fontSize: 12),
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 10),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8)),
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: "Password",
                    hintStyle: const TextStyle(fontSize: 12),
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 10),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8)),
                  ),
                ),
                const SizedBox(height: 8),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const ForgotPasswordScreen()));
                    },
                    child: const Text("Forgot Password?",
                        style: TextStyle(fontSize: 11, color: Colors.black)),
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  height: 45,
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _login,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF2E7D32),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25)),
                    ),
                    child: _isLoading
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                                strokeWidth: 2, color: Colors.white),
                          )
                        : const Text("Login",
                            style: TextStyle(color: Colors.white)),
                  ),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  height: 45,
                  child: OutlinedButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text("Google sign-in coming soon")),
                      );
                    },
                    style: OutlinedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25)),
                    ),
                    child: const Text("Continue with Google",
                        style: TextStyle(color: Colors.black, fontSize: 12)),
                  ),
                ),
                const SizedBox(height: 16),
                Center(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const SignupScreen()));
                    },
                    child: const Text("Don't have an account? Sign Up",
                        style: TextStyle(fontSize: 11)),
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
