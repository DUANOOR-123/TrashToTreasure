import 'package:flutter/material.dart';

import 'package:trash2treasure/core/app_colors.dart';

/// One search result row: [photo]  Title
///                                 Rs. 200 · 1.1 km
class SearchResultTile extends StatelessWidget {
  final String image; // asset path e.g. 'assets/images/waste.png'
  final String title;
  final int price; // 0 means free
  final double distance; // in km
  final VoidCallback? onTap;

  const SearchResultTile({
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
                height: 60,
                width: 60,
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
                  const SizedBox(height: 4),
                  Text(
                    // price 0 shows "Free", otherwise "Rs. 200"
                    '${price == 0 ? 'Free' : 'Rs. $price'} · $distance km',
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
