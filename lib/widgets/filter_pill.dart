import 'package:flutter/material.dart';

import 'package:trash2treasure/core/app_colors.dart';

/// A small rounded button used for filters (Nearby, Price, Free only...).
/// Highlighted when selected, plain when not.
class FilterPill extends StatelessWidget {
  final String label; // text inside the pill
  final bool isSelected; // true = highlighted look
  final bool showArrow; // true = small dropdown arrow after the text
  final VoidCallback? onTap; // runs when tapped

  const FilterPill({
    super.key,
    required this.label,
    this.isSelected = false,
    this.showArrow = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          // selected = her darker light-green, not selected = card color
          color: isSelected ? AppColors.selected : AppColors.backgroundColor,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AppColors.borderColor),
        ),
        // Row with min size so the pill only takes the space it needs
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                color: AppColors.textColor,
              ),
            ),
            if (showArrow) ...[
              const SizedBox(width: 2),
              const Icon(
                Icons.arrow_drop_down,
                size: 18,
                color: AppColors.iconColor,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
