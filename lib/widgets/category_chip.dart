import 'package:flutter/material.dart';

import 'package:trash2treasure/core/app_colors.dart';

/// One round category button (Organic, Fabric, Industrial, Clay-based).
/// Reusable: the Categories screen (Screen 12) can use it too.
class CategoryChip extends StatelessWidget {
  final String label; // text under the circle
  final IconData icon; // icon inside the circle
  final Color color; // icon color; the circle gets a light tint of it
  final VoidCallback? onTap; // what happens when tapped

  const CategoryChip({
    super.key,
    required this.label,
    required this.icon,
    required this.color,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Column(
        children: [
          CircleAvatar(
            radius: 28,
            // withValues(alpha:) makes the color see-through (soft tint)
            backgroundColor: color.withValues(alpha: 0.15),
            child: Icon(icon, color: color, size: 26),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: const TextStyle(fontSize: 12, color: AppColors.textColor),
          ),
        ],
      ),
    );
  }
}
