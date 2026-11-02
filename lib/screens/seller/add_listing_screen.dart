import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:trash2treasure/screens/seller/preview_listing_screen.dart';
import 'package:trash2treasure/widgets/button.dart';

import 'package:trash2treasure/widgets/reusable_dropdown.dart';
import 'package:trash2treasure/widgets/reusable_text_field.dart';
import 'package:trash2treasure/widgets/reusable_image_picker.dart';

class AddListingScreen extends StatefulWidget {
  const AddListingScreen({super.key});

  @override
  State<AddListingScreen> createState() => _AddListingScreen();
}

class _AddListingScreen extends State<AddListingScreen> {
  String selectedMaterial = 'Fabric Scraps';
  String selectedUnit = 'kg';
  String selectedLocation = 'Islamabad';
  String selectedAvailability = 'Available';

  XFile? productImage;

  final TextEditingController priceController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  @override
  void dispose() {
    priceController.dispose();
    quantityController.dispose();
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Add New Material',
          style: TextStyle(
            color: Color(0xFF1B3A2D),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ReusableTextField(
                  label: 'Material Title',
                  hintText: 'e.g. Plastic Water Bottles',
                  controller: titleController,
                ),

                const SizedBox(height: 18),

                ReusableImagePicker(
                  onImageSelected: (image) {
                    setState(() {
                      productImage = image;
                    });
                  },
                ),

                const SizedBox(height: 18),

                ReusableTextField(
                  label: 'Material Description',
                  controller: descriptionController,
                  hintText: 'Describe your product...',
                  maxLines: 4,
                ),

                const SizedBox(height: 18),

                ReusableDropdown(
                  label: 'Material',

                  items: [
                    'Fabric Scraps',
                    'Plastic Waste',
                    'Paper Waste',
                    'Metal Scraps',
                  ],

                  selectedValue: selectedMaterial,

                  onChanged: (value) {
                    if (value != null) {
                      setState(() {
                        selectedMaterial = value;
                      });
                    }
                  },
                ),

                const SizedBox(height: 18),

                ReusableTextField(
                  label: 'Price',
                  hintText: '0.00',
                  controller: priceController,
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  prefixText: 'Rs. ',
                ),

                const SizedBox(height: 18),

                Row(
                  children: [
                    Expanded(
                      child: ReusableTextField(
                        label: 'Quantity',
                        hintText: 'e.g. 2',
                        controller: quantityController,
                        keyboardType: const TextInputType.numberWithOptions(
                          decimal: true,
                        ),
                      ),
                    ),

                    const SizedBox(width: 12),

                    Expanded(
                      child: ReusableDropdown(
                        label: 'Unit',
                        items: const ['kg', 'Pieces'],
                        selectedValue: selectedUnit,
                        onChanged: (value) {
                          if (value != null) {
                            setState(() {
                              selectedUnit = value;
                            });
                          }
                        },
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 18),

                ReusableDropdown(
                  label: 'Pickup Location',
                  items: const [
                    'Karachi',
                    'Lahore',
                    'Islamabad',
                    'Rawalpindi',
                    'Faisalabad',
                    'Multan',
                    'Peshawar',
                    'Quetta',
                    'Gujranwala',
                    'Sialkot',
                    'Sargodha',
                    'Bahawalpur',
                    'Sukkur',
                    'Larkana',
                    'Hyderabad',
                    'Abbottabad',
                    'Mardan',
                    'Swat',
                    'Mingora',
                    'Dera Ghazi Khan',
                    'Rahim Yar Khan',
                    'Sheikhupura',
                    'Jhelum',
                    'Gujrat',
                    'Kasur',
                    'Okara',
                    'Sahiwal',
                    'Wah Cantt',
                    'Taxila',
                    'Attock',
                    'Muzaffarabad',
                    'Mirpur',
                    'Gilgit',
                    'Skardu',
                    'Gwadar',
                    'Turbat',
                    'Chaman',
                    'Kohat',
                    'Bannu',
                    'Dera Ismail Khan',
                    'Nawabshah',
                    'Khairpur',
                  ],
                  selectedValue: selectedLocation,
                  onChanged: (value) {
                    if (value != null) {
                      setState(() {
                        selectedLocation = value;
                      });
                    }
                  },
                ),

                const SizedBox(height: 18),

                ReusableDropdown(
                  label: selectedAvailability,
                  items: ['Available', 'Not Available'],
                  selectedValue: selectedAvailability,
                  onChanged: (value) {
                    setState(() {
                      selectedAvailability = value!;
                    });
                  },
                ),

                const SizedBox(height: 18),

                Button(
                  buttonText: 'Next',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PreviewListingScreen(
                          productImage: productImage,
                          title: titleController.text,
                          description: descriptionController.text,
                          material: selectedMaterial,
                          price: priceController.text,
                          quantity: quantityController.text,
                          unit: selectedUnit,
                          location: selectedLocation,
                          availability: selectedAvailability,
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
