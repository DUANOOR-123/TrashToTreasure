import 'package:flutter/material.dart';

import 'package:trash2treasure/core/app_colors.dart';
import 'package:trash2treasure/data/seller_data.dart';
import 'package:trash2treasure/widgets/button.dart';
import 'package:trash2treasure/widgets/reusable_dropdown.dart';
import 'package:trash2treasure/widgets/reusable_text_field.dart';

/// Screen 28: Edit Listing. Opened from "Manage Listing" (Screen 25).
class EditListingScreen extends StatefulWidget {
  final Map<String, dynamic> listing;

  const EditListingScreen({super.key, required this.listing});

  @override
  State<EditListingScreen> createState() => _EditListingScreenState();
}

class _EditListingScreenState extends State<EditListingScreen> {
  late final TextEditingController _titleController;
  late final TextEditingController _priceController;
  late final TextEditingController _quantityController;
  late String _status;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(
      text: widget.listing['title'] as String,
    );
    _priceController = TextEditingController(
      text: '${widget.listing['price']}',
    );
    _quantityController = TextEditingController(
      text: widget.listing['weight'] as String,
    );
    _status = widget.listing['status'] as String;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _priceController.dispose();
    _quantityController.dispose();
    super.dispose();
  }

  void _save() {
    final title = _titleController.text.trim();
    if (title.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Please add a title')));
      return;
    }

    final priceText = _priceController.text.trim();
    final price =
        int.tryParse(priceText) ?? (double.tryParse(priceText)?.round() ?? 0);

    SellerStore.update(widget.listing['id'] as int, {
      'title': title,
      'price': price,
      'weight': _quantityController.text.trim(),
      'status': _status,
    });

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Changes saved')));
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Edit Listing',
          style: TextStyle(
            color: AppColors.textColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ReusableTextField(
                  label: 'Title',
                  hintText: 'e.g. Plastic Water Bottles',
                  controller: _titleController,
                ),
                const SizedBox(height: 18),
                ReusableTextField(
                  label: 'Price',
                  hintText: '0',
                  controller: _priceController,
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  prefixText: 'Rs. ',
                ),
                const SizedBox(height: 18),
                ReusableTextField(
                  label: 'Quantity',
                  hintText: 'e.g. 2 kg',
                  controller: _quantityController,
                ),
                const SizedBox(height: 18),
                ReusableDropdown(
                  label: 'Status',
                  items: const ['Active', 'Sold', 'Draft'],
                  selectedValue: _status,
                  onChanged: (value) {
                    if (value != null) {
                      setState(() => _status = value);
                    }
                  },
                ),
                const SizedBox(height: 24),
                Button(buttonText: 'Save Changes', onPressed: _save),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
