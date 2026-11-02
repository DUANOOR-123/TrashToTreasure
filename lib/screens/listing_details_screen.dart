import 'package:flutter/material.dart';

import './contact_seller_screen.dart';
import './request_pickup_screen.dart';
import '../core/app_colors.dart';
import '../data/buyer_data.dart';
import '../widgets/button.dart';

/// Screen 15: Listing Details.
/// Shows one material in full: photo, title, price, distance,
/// description, location, seller info and the action buttons.
///
/// CHANGED:
///  - it now receives ONE Listing object (instead of 9 separate values)
///  - the bottom bar has the main action "Request Pickup" plus two small
///    buttons: Chat and Call (before, there was no way to request from here)
///
/// `const ListingDetailsScreen()` still works alone (shows the first item).
class ListingDetailsScreen extends StatelessWidget {
  final Listing? listing;

  const ListingDetailsScreen({super.key, this.listing});

  @override
  Widget build(BuildContext context) {
    final item = listing ?? kListings.first;
    final category = categoryByName(item.category);

    return Scaffold(
      backgroundColor: AppColors.bg,
      appBar: AppBar(
        backgroundColor: AppColors.bg,
        title: const Text(
          'Listing Details',
          style: TextStyle(
            color: AppColors.textColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: SafeArea(
        child: Column(
          children: [
            // ---- Scrollable content (everything except the buttons) ----
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Big photo with rounded corners
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.asset(
                        item.image,
                        height: 220,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(height: 14),

                    // Category tag
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 3,
                      ),
                      decoration: BoxDecoration(
                        color: category.color.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(category.icon, size: 14, color: category.color),
                          const SizedBox(width: 4),
                          Text(
                            item.category,
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: category.color,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),

                    // Title
                    Text(
                      item.title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textColor,
                      ),
                    ),
                    const SizedBox(height: 6),

                    // Price + distance on one line
                    Row(
                      children: [
                        Text(
                          item.price == 0 ? 'Free' : 'Rs. ${item.price} / kg',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: AppColors.textColor,
                          ),
                        ),
                        const SizedBox(width: 10),
                        const Icon(
                          Icons.location_on_outlined,
                          size: 16,
                          color: AppColors.iconColor,
                        ),
                        const SizedBox(width: 2),
                        Text(
                          item.distanceLabel,
                          style: const TextStyle(
                            fontSize: 12,
                            color: AppColors.textColor,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),

                    // Description
                    Text(
                      item.description,
                      style: const TextStyle(
                        fontSize: 13,
                        color: AppColors.textColor,
                      ),
                    ),
                    const SizedBox(height: 6),

                    // Location line: bold label + value
                    Text.rich(
                      TextSpan(
                        style: const TextStyle(
                          fontSize: 13,
                          color: AppColors.textColor,
                        ),
                        children: [
                          const TextSpan(
                            text: 'Location: ',
                            style: TextStyle(fontWeight: FontWeight.w700),
                          ),
                          TextSpan(text: item.location),
                        ],
                      ),
                    ),
                    const SizedBox(height: 18),

                    // Seller card
                    _buildSellerCard(item),
                  ],
                ),
              ),
            ),

            // ---- Fixed buttons at the bottom ----
            _buildBottomButtons(context, item),
          ],
        ),
      ),
    );
  }

  // Card with the seller's picture, name and rating
  Widget _buildSellerCard(Listing item) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.backgroundColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.borderColor),
      ),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 24,
            backgroundImage: AssetImage('assets/images/profile.png'),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                item.sellerName,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textColor,
                ),
              ),
              const SizedBox(height: 2),
              Row(
                children: [
                  const Icon(Icons.star, size: 14, color: Colors.amber),
                  const SizedBox(width: 3),
                  Text(
                    '${item.rating} (${item.reviews} reviews)',
                    style: const TextStyle(
                      fontSize: 11,
                      color: AppColors.textColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  // [Chat] [Call] [ Request Pickup ]
  Widget _buildBottomButtons(BuildContext context, Listing item) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 10, 16, 14),
      decoration: const BoxDecoration(
        color: AppColors.backgroundColor,
        border: Border(top: BorderSide(color: AppColors.borderColor)),
      ),
      child: Row(
        children: [
          // Chat button (square, outlined) -> Contact Seller (Screen 16)
          _squareButton(
            icon: Icons.chat_bubble_outline,
            tooltip: 'Chat with seller',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ContactSellerScreen(listing: item),
                ),
              );
            },
          ),
          const SizedBox(width: 10),

          // Phone button
          _squareButton(
            icon: Icons.call_outlined,
            tooltip: 'Call seller',
            // Later: start a phone call
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Calling will be added later')),
              );
            },
          ),
          const SizedBox(width: 10),

          // Main action: Request Pickup (Screen 17).
          // Expanded: it takes all the width that is left.
          Expanded(
            child: Button(
              buttonText: 'Request Pickup',
              icon: Icons.local_shipping_outlined,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RequestPickupScreen(listing: item),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // Small square button with an outline (used for Chat and Call)
  Widget _squareButton({
    required IconData icon,
    required String tooltip,
    required VoidCallback onPressed,
  }) {
    return Container(
      height: 44,
      width: 44,
      decoration: BoxDecoration(
        color: AppColors.backgroundColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.textColor),
      ),
      child: IconButton(
        tooltip: tooltip,
        icon: Icon(icon, color: AppColors.textColor),
        onPressed: onPressed,
      ),
    );
  }
}
