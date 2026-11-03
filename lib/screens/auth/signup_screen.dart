import 'package:flutter/material.dart';
import 'package:trash2treasure/core/app_colors.dart';
import 'package:trash2treasure/core/app_session.dart';
import 'package:trash2treasure/screens/auth/login_screen.dart';
import 'package:trash2treasure/screens/auth/choose_role_screen.dart';
import 'package:trash2treasure/services/api_service.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool agree = false;
  bool isLoading = false;

  // Controllers for signup fields
  final TextEditingController fullNameController = TextEditingController();

  final TextEditingController contactController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  // Reusable text field
  Widget _field(
    String h, {
    bool isPass = false,
    required TextEditingController controller,
  }) {
    return TextField(
      controller: controller,
      obscureText: isPass,
      decoration: InputDecoration(
        hintText: h,
        hintStyle: const TextStyle(fontSize: 12),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 10,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }

  // Registration function
  Future<void> _register() async {
    // Check agreement
    if (!agree) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please agree to Terms & Conditions"),
        ),
      );
      return;
    }

    // Get values from text fields
    final fullName = fullNameController.text.trim();
    final contact = contactController.text.trim();
    final password = passwordController.text;

    // Check empty fields
    if (fullName.isEmpty || contact.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please fill all fields"),
        ),
      );
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      // Send registration request to backend
      final response = await ApiService.register(
        fullName: fullName,
        contact: contact,
        password: password,
      );

      // Get token from backend response
      final token = response["token"];

      if (token is! String || token.isEmpty) {
        throw Exception("Registration response did not contain a token");
      }

      if (!mounted) return;

      // Save authentication information
      AppSession.authToken = token;
      AppSession.userName = fullName;
      AppSession.signIn();

      // Move to role selection screen
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => const ChooseRoleScreen(),
        ),
      );
    } catch (error) {
      if (!mounted) return;

      final message = error.toString().replaceFirst(
            "Exception: ",
            "",
          );

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  // Dispose controllers
  @override
  void dispose() {
    fullNameController.dispose();
    contactController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.bg,
        appBar: AppBar(
          backgroundColor: AppColors.bg,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: SafeArea(
            child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Create Account",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Text(
                  "Join the Trash 2 Treasure community",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 20),
                _field(
                  "Full Name",
                  controller: fullNameController,
                ),
                const SizedBox(height: 12),
                _field(
                  "Email or Phone Number",
                  controller: contactController,
                ),
                const SizedBox(height: 12),
                _field(
                  "Password",
                  isPass: true,
                  controller: passwordController,
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Checkbox(
                      value: agree,
                      activeColor: Colors.green,
                      onChanged: (v) {
                        setState(() {
                          agree = v ?? false;
                        });
                      },
                      visualDensity: VisualDensity.compact,
                    ),
                    const Text(
                      "I agree to Terms & Conditions",
                      style: TextStyle(fontSize: 12),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  height: 45,
                  child: ElevatedButton(
                    onPressed: isLoading ? null : _register,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF2E7D32),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    child: isLoading
                        ? const SizedBox(
                            height: 22,
                            width: 22,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2,
                            ),
                          )
                        : const Text(
                            "Sign Up",
                            style: TextStyle(color: Colors.white),
                          ),
                  ),
                ),
                const SizedBox(height: 10),
                Center(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const LoginScreen(),
                        ),
                      );
                    },
                    child: const Text(
                      "Already have an account? Login",
                      style: TextStyle(fontSize: 11),
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                const Center(
                  child: Text(
                    "Check your email to verify your account",
                    style: TextStyle(
                      fontSize: 10,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ],
            ),
          ),
        )));
  }
}
