import 'package:flutter/material.dart';

import 'package:trash2treasure/core/app_colors.dart';

/// A card showing one nearby material: photo, title, price and distance.
/// Reusable for Search results, Saved items, etc.
class MaterialCard extends StatelessWidget {
  final String image; // asset path e.g. 'assets/images/waste.png'
  final String title;
  final int price;
  final String distance;
  final VoidCallback? onTap;

  const MaterialCard({
    super.key,
    required this.image,
    required this.title,
    required this.price,
    required this.distance,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        // Same card style as her ListingTile (background + border + radius)
        decoration: BoxDecoration(
          color: AppColors.backgroundColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.borderColor),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ClipRRect rounds only the top corners of the photo
            ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(12),
              ),
              child: Image.asset(
                image,
                height: 90,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textColor,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    // CHANGED: price 0 now shows "Free"
                    '${price == 0 ? 'Free' : 'Rs. $price'} · $distance',
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
      ),
    );
  }
}
