import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

import 'package:trash2treasure/core/app_colors.dart';
import 'package:trash2treasure/core/app_nav.dart';
import 'package:trash2treasure/core/app_session.dart';
import 'package:trash2treasure/services/api_service.dart';

import 'package:trash2treasure/screens/auth/verification_status_screen.dart';

class SubmitIdScreen extends StatefulWidget {
  const SubmitIdScreen({super.key});
  @override
  State<SubmitIdScreen> createState() => _SubmitIdScreenState();
}

class _SubmitIdScreenState extends State<SubmitIdScreen> {
  final ImagePicker _picker = ImagePicker();

  XFile? _frontImage;
  XFile? _backImage;
  XFile? _selfieImage;

  Future<void> _pickImage({
    required ImageSource source,
    required String imageType,
  }) async {
    final XFile? pickedImage = await _picker.pickImage(
      source: source,
      imageQuality: 80,
    );

    if (pickedImage == null) return;

    setState(() {
      if (imageType == "front") {
        _frontImage = pickedImage;
      } else if (imageType == "back") {
        _backImage = pickedImage;
      } else if (imageType == "selfie") {
        _selfieImage = pickedImage;
      }
    });
  }

  void _showImageSourceOptions(String imageType) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text("Take a Photo"),
                onTap: () {
                  Navigator.pop(context);
                  _pickImage(
                    source: ImageSource.camera,
                    imageType: imageType,
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text("Choose from Gallery"),
                onTap: () {
                  Navigator.pop(context);
                  _pickImage(
                    source: ImageSource.gallery,
                    imageType: imageType,
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _submitVerification() async {
    // Step 1: Check whether all three images are selected
    if (_frontImage == null || _backImage == null || _selfieImage == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please upload all three images."),
        ),
      );
      return;
    }

    // Step 2: Get the logged-in user's token
    final token = AppSession.authToken;

    if (token == null || token.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please sign in again."),
        ),
      );
      return;
    }

    // Step 3: Upload images to the backend
    try {
      final response = await ApiService.submitVerification(
        frontImagePath: _frontImage!.path,
        backImagePath: _backImage!.path,
        selfieImagePath: _selfieImage!.path,
        token: token,
      );

      // Step 4: Check whether the screen is still active
      if (!mounted) return;

      // Step 5: Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            response["message"] ?? "Verification submitted successfully.",
          ),
        ),
      );

      // Step 6: Navigate only after successful upload
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => const VerificationStatusScreen(),
        ),
      );
    } catch (error) {
      // Step 7: Handle upload errors
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(error.toString()),
        ),
      );
    }
  }

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
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
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
                    onPressed: _submitVerification,
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
                      // Skip: verify later, go straight to the app
                      AppNav.goHome(context);
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
    XFile? selectedImage;

    if (label.toLowerCase() == "front") {
      selectedImage = _frontImage;
    } else if (label.toLowerCase() == "back") {
      selectedImage = _backImage;
    } else if (label.toLowerCase() == "selfie") {
      selectedImage = _selfieImage;
    }
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            _showImageSourceOptions(label.toLowerCase());
          },
          child: Container(
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
            child: selectedImage != null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.file(
                      File(selectedImage.path),
                      width: 72,
                      height: 72,
                      fit: BoxFit.cover,
                    ),
                  )
                : Icon(
                    isPerson ? Icons.person_outline : Icons.camera_alt_outlined,
                    color: const Color(0xFF1F7A3A),
                    size: 28,
                  ),
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
