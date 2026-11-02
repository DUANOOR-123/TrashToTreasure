import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:trash2treasure/core/app_colors.dart';

class ReusableImagePicker extends StatefulWidget {
  final ValueChanged<XFile?>? onImageSelected;

  const ReusableImagePicker({super.key, this.onImageSelected});

  @override
  State<ReusableImagePicker> createState() => _ReusableImagePickerState();
}

class _ReusableImagePickerState extends State<ReusableImagePicker> {
  final ImagePicker picker = ImagePicker();

  XFile? selectedImage;

  // Pick image from camera or gallery
  Future<void> pickImage(ImageSource source) async {
    final XFile? image = await picker.pickImage(source: source);

    if (image != null) {
      setState(() {
        selectedImage = image;
      });

      // Send selected image to parent screen
      widget.onImageSelected?.call(image);
    }
  }

  // Show camera and gallery options
  void showImageSourceDialog() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Choose from Gallery'),
                onTap: () {
                  Navigator.pop(context);
                  pickImage(ImageSource.gallery);
                },
              ),

              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text('Take a Photo'),
                onTap: () {
                  Navigator.pop(context);
                  pickImage(ImageSource.camera);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: showImageSourceDialog,
      child: Container(
        height: 180,
        width: double.infinity,
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.borderColor),
          borderRadius: BorderRadius.circular(10),
        ),
        child: selectedImage == null
            ? const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.add_a_photo_outlined,
                    size: 35,
                    color: AppColors.textColor,
                  ),
                  SizedBox(height: 8),
                  Text('Upload Product Image'),
                  SizedBox(height: 4),
                  Text(
                    'Choose from gallery or take a photo',
                    style: TextStyle(fontSize: 12),
                  ),
                ],
              )
            : ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.file(
                  File(selectedImage!.path),
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
      ),
    );
  }
}
