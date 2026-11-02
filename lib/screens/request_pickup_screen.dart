import 'package:flutter/material.dart';

import 'order_status_screen.dart';
import '../core/app_colors.dart';
import '../data/buyer_data.dart';
import '../widgets/button.dart';

/// Screen 17: Request Pickup.
/// The buyer enters a quantity, picks a time, adds an optional message,
/// sees the total price, and sends the request.
/// StatefulWidget because the total changes while the buyer types.
///
/// CHANGED: it receives the Listing being requested, shows it at the top,
/// uses its price for the total, and saves the new request so it appears
/// in My Requests and on the Home card.
class RequestPickupScreen extends StatefulWidget {
  final Listing? listing; // the material being requested

  const RequestPickupScreen({super.key, this.listing});

  @override
  State<RequestPickupScreen> createState() => _RequestPickupScreenState();
}

class _RequestPickupScreenState extends State<RequestPickupScreen> {
  // Controllers read what the user typed in each box
  final TextEditingController _quantityController = TextEditingController(
    text: '2',
  );
  final TextEditingController _messageController = TextEditingController();

  // Choices shown in the "Preferred Time" dropdown
  final List<String> _timeSlots = [
    'Today, 4–6 PM',
    'Today, 6–8 PM',
    'Tomorrow, 10 AM–12 PM',
    'Tomorrow, 4–6 PM',
  ];

  // The currently selected time (starts with the first choice)
  String _selectedTime = 'Today, 4–6 PM';

  // The material (first one if none was given)
  Listing get _item => widget.listing ?? kListings.first;

  // Calculated value: quantity x price per kg.
  // If the box is empty or has invalid text, the total is 0.
  int get _total {
    final qty = double.tryParse(_quantityController.text) ?? 0;
    return (qty * _item.price).round();
  }

  // Called when "Send Request" is pressed
  void _sendRequest() {
    final qty = double.tryParse(_quantityController.text) ?? 0;

    // Validation: quantity must be more than 0
    if (qty <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a valid quantity')),
      );
      return; // stop here, don't send
    }

    // Save the request (it now shows in My Requests), then open Order
    // Status (Screen 18). pushReplacement swaps this screen, so Back
    // doesn't return to the form.
    // Later: send the request to the backend before opening it.
    final request = BuyerRequest(
      listing: _item,
      quantity: qty,
      time: _selectedTime,
      status: 'Pending',
    );
    RequestStore.add(request);

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) =>
            OrderStatusScreen(request: request, justSent: true),
      ),
    );
  }

  // Free the controllers' memory when the screen closes
  @override
  void dispose() {
    _quantityController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      appBar: AppBar(
        backgroundColor: AppColors.bg,
        title: const Text(
          'Request Pickup',
          style: TextStyle(
            color: AppColors.textColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      // Scroll view so the keyboard never causes an overflow error
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ---- The material being requested ----
              _buildItemCard(),
              const SizedBox(height: 18),

              // ---- Quantity ----
              _label('Quantity'),
              TextField(
                controller: _quantityController,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                // Redraw on every typed digit so the total updates live
                onChanged: (_) => setState(() {}),
                decoration: _decoration(hint: '0', suffix: 'kg'),
              ),
              const SizedBox(height: 18),

              // ---- Preferred time (dropdown) ----
              _label('Preferred Time'),
              _buildTimeDropdown(),
              const SizedBox(height: 18),

              // ---- Message (optional) ----
              _label('Message (Optional)'),
              TextField(
                controller: _messageController,
                maxLines: 4,
                decoration: _decoration(
                  hint: "I'm interested in this material. Is pickup available?",
                ),
              ),
              const SizedBox(height: 18),

              // ---- Total ----
              Text(
                _item.price == 0 ? 'Total: Free' : 'Total: Rs. $_total',
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textColor,
                ),
              ),
              const SizedBox(height: 16),

              // ---- Send button (her reusable Button) ----
              Button(buttonText: 'Send Request', onPressed: _sendRequest),
            ],
          ),
        ),
      ),
    );
  }

  // Small card with the photo, name and price of the material
  Widget _buildItemCard() {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColors.backgroundColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.borderColor),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(
              _item.image,
              height: 52,
              width: 52,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _item.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textColor,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  '${_item.price == 0 ? 'Free' : 'Rs. ${_item.price} / kg'} · ${_item.sellerName}',
                  style: const TextStyle(
                    fontSize: 11,
                    color: AppColors.textColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Small heading above each field
  Widget _label(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w600,
          color: AppColors.textColor,
        ),
      ),
    );
  }

  // One shared style for all the input boxes, so they match each other
  InputDecoration _decoration({required String hint, String? suffix}) {
    return InputDecoration(
      hintText: hint,
      hintStyle: TextStyle(
        fontSize: 13,
        color: AppColors.textColor.withValues(alpha: 0.5),
      ),
      suffixText: suffix, // e.g. "kg" shown inside the box on the right
      filled: true,
      fillColor: AppColors.backgroundColor,
      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.borderColor),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.textColor),
      ),
    );
  }

  // Dropdown styled to look like the text boxes
  Widget _buildTimeDropdown() {
    return InputDecorator(
      decoration: _decoration(hint: ''),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: _selectedTime,
          isExpanded: true, // fill the box width
          isDense: true,
          icon: const Icon(
            Icons.keyboard_arrow_down,
            color: AppColors.iconColor,
          ),
          style: const TextStyle(fontSize: 14, color: AppColors.textColor),
          // One menu entry for each time slot
          items: _timeSlots
              .map((slot) => DropdownMenuItem(value: slot, child: Text(slot)))
              .toList(),
          // When a choice is picked, save it and redraw
          onChanged: (value) {
            if (value != null) setState(() => _selectedTime = value);
          },
        ),
      ),
    );
  }
}
