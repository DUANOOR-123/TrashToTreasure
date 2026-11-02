import 'package:flutter/material.dart';

import 'package:trash2treasure/core/app_colors.dart';

/// One row in the Categories list:
/// [colored icon box]  Title
///                     Subtitle                >
class CategoryTile extends StatelessWidget {
  final String title; // e.g. 'Organic'
  final String subtitle; // e.g. 'Compost, ect, etc'
  final IconData icon; // icon shown in the square on the left
  final Color color; // color of that icon and its tinted background
  final VoidCallback? onTap; // runs when the row is tapped

  const CategoryTile({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // InkWell makes the whole row tappable (with a ripple effect)
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        // Space between this row and the next one
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(10),
        // Same card look as her other tiles (background + border + radius)
        decoration: BoxDecoration(
          color: AppColors.backgroundColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.borderColor),
        ),
        child: Row(
          children: [
            // Rounded square on the left with the category icon
            Container(
              height: 52,
              width: 52,
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.18),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: color, size: 28),
            ),
            const SizedBox(width: 12),

            // Expanded makes the text take all the remaining width
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textColor,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 11,
                      color: AppColors.textColor.withValues(alpha: 0.6),
                    ),
                  ),
                ],
              ),
            ),

            // Small arrow on the right
            const Icon(Icons.chevron_right, color: AppColors.iconColor),
          ],
        ),
      ),
    );
  }
}
