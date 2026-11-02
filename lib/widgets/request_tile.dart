import 'package:flutter/material.dart';

import 'package:trash2treasure/core/app_colors.dart';

/// One row in My Requests:
/// [photo]  Title
///          Rs. 200 · 1.1 km
///          [Status badge]
class RequestTile extends StatelessWidget {
  final String image; // asset path e.g. 'assets/images/waste.png'
  final String title;
  final int price;
  final String distance;
  final String status; // 'Pending', 'Confirmed', 'Canceled' or 'Completed'
  final VoidCallback? onTap;

  const RequestTile({
    super.key,
    required this.image,
    required this.title,
    required this.price,
    required this.distance,
    required this.status,
    this.onTap,
  });

  // Picks the badge color from the status text
  Color get _statusColor {
    switch (status) {
      case 'Pending':
        return Colors.orange;
      case 'Canceled':
        return Colors.red;
      default: // Confirmed and Completed
        return Colors.green;
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(10),
        // Same card look as her other tiles
        decoration: BoxDecoration(
          color: AppColors.backgroundColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.borderColor),
        ),
        child: Row(
          children: [
            // Photo with rounded corners
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                image,
                height: 64,
                width: 64,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 12),

            // Expanded: text takes the rest of the row width
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
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
                    '${price == 0 ? 'Free' : 'Rs. $price'} · $distance',
                    style: const TextStyle(
                      fontSize: 11,
                      color: AppColors.textColor,
                    ),
                  ),
                  const SizedBox(height: 6),

                  // Status badge: light tinted background + colored text
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 3,
                    ),
                    decoration: BoxDecoration(
                      color: _statusColor.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      status,
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: _statusColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
