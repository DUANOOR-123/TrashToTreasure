import 'package:flutter/material.dart';
import 'package:trash2treasure/data/seller_data.dart';
import 'package:trash2treasure/screens/seller/my_listings_screen.dart';
import 'package:image_picker/image_picker.dart';

import 'package:trash2treasure/core/app_colors.dart';
import 'package:trash2treasure/widgets/button.dart';

import 'dart:io';

class PreviewListingScreen extends StatelessWidget {
  // Product information
  final String title;
  final String description;
  final String material;

  // Price and quantity
  final String price;
  final String quantity;
  final String unit;

  // Other details
  final String location;
  final String availability;

  // Product image
  final XFile? productImage;

  const PreviewListingScreen({
    super.key,
    required this.title,
    required this.description,
    required this.material,
    required this.price,
    required this.quantity,
    required this.unit,
    required this.location,
    required this.availability,
    this.productImage,
  });

  // Saves the listing (Publish = Active, Draft = Draft), closes the
  // Preview and Add Listing screens and opens My Listings (Screen 23).
  void _save(BuildContext context, String status) {
    final messenger = ScaffoldMessenger.of(context);

    if (title.trim().isEmpty) {
      messenger.showSnackBar(
        const SnackBar(content: Text('Please add a title first')),
      );
      return;
    }

    final navigator = Navigator.of(context);
    final priceText = price.trim();
    final priceValue =
        int.tryParse(priceText) ?? (double.tryParse(priceText)?.round() ?? 0);

    SellerStore.add(
      title: title.trim(),
      price: priceValue,
      weight: '$quantity $unit'.trim(),
      status: status,
    );

    var closed = 0;
    navigator.popUntil((route) => closed++ >= 2);
    navigator.push(
      MaterialPageRoute(builder: (_) => const MyListingsScreen()),
    );
    messenger.showSnackBar(
      SnackBar(
        content: Text(
          status == 'Draft' ? 'Saved as draft' : 'Listing published',
        ),
      ),
    );
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
          'Preview Listing',
          style: TextStyle(
            color: Color(0xFF1B3A2D),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Product Image
              if (productImage != null)
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.file(
                    File(productImage!.path),
                    width: double.infinity,
                    height: 180,
                    fit: BoxFit.cover,
                  ),
                ),

              const SizedBox(height: 16),

              Text(
                title,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1B3A2D),
                ),
              ),

              const SizedBox(height: 10),

              Row(
                children: [
                  Text(
                    'Rs. $price',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1B3A2D),
                    ),
                  ),

                  const SizedBox(width: 12),

                  Text(
                    '$quantity $unit',
                    style: const TextStyle(fontSize: 15, color: Colors.grey),
                  ),
                ],
              ),

              const SizedBox(height: 18),

              Text(
                material,
                style: const TextStyle(
                  fontSize: 15,
                  color: Color(0xFF1B3A2D),
                  fontWeight: FontWeight.w600,
                ),
              ),

              const SizedBox(height: 18),

              // Description Heading
              const Text(
                'Description',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1B3A2D),
                ),
              ),

              const SizedBox(height: 6),

              // Description
              Text(
                description,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.black87,
                  height: 1.5,
                ),
              ),

              const SizedBox(height: 18),

              // Pickup Location
              Row(
                children: [
                  const Icon(
                    Icons.location_on_outlined,
                    color: Color(0xFF1B3A2D),
                  ),
                  const SizedBox(width: 8),
                  Text(location),
                ],
              ),

              const SizedBox(height: 12),

              // Availability
              Row(
                children: [
                  const Icon(
                    Icons.inventory_2_outlined,
                    color: Color(0xFF1B3A2D),
                  ),
                  const SizedBox(width: 8),
                  Text(availability),
                ],
              ),

              const SizedBox(height: 24),

              Row(
                children: [
                  Expanded(
                    child: Button(
                      buttonText: 'Publish',
                      buttonColor: AppColors.textColor,
                      buttonTextColor: Colors.white,
                      icon: Icons.publish,
                      onPressed: () => _save(context, 'Active'),
                    ),
                  ),

                  const SizedBox(width: 12),

                  Expanded(
                    child: Button(
                      buttonText: 'Draft',
                      buttonColor: const Color(0xFFD9EBE1),
                      buttonTextColor: AppColors.textColor,
                      icon: Icons.save_outlined,
                      onPressed: () => _save(context, 'Draft'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
