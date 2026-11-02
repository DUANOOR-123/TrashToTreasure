import 'package:flutter/material.dart';

import 'package:trash2treasure/core/app_colors.dart';
import 'package:trash2treasure/data/seller_data.dart';
import 'package:trash2treasure/screens/seller/edit_listing_screen.dart';

/// Screen 25: "Manage Listing (Options)".
/// A bottom sheet with Edit / Mark as Sold / Delete for one listing.
/// My Listings redraws by itself because it listens to [SellerStore].
void showManageListingSheet(BuildContext context, Map<String, dynamic> item) {
  final int id = item['id'] as int;
  final bool isSold = item['status'] == 'Sold';

  showModalBottomSheet<void>(
    context: context,
    backgroundColor: AppColors.bg,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (sheetContext) {
      return SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 20, 16, 12),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                item['title'] as String,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                  color: AppColors.textColor,
                ),
              ),
              const SizedBox(height: 8),
              ListTile(
                leading: const Icon(
                  Icons.edit_outlined,
                  color: AppColors.textColor,
                ),
                title: const Text('Edit Listing'),
                onTap: () {
                  Navigator.pop(sheetContext);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => EditListingScreen(listing: item),
                    ),
                  );
                },
              ),
              if (!isSold)
                ListTile(
                  leading: const Icon(
                    Icons.check_circle_outline,
                    color: AppColors.textColor,
                  ),
                  title: const Text('Mark as Sold'),
                  onTap: () {
                    Navigator.pop(sheetContext);
                    SellerStore.setStatus(id, 'Sold');
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Marked as sold')),
                    );
                  },
                ),
              ListTile(
                leading: const Icon(
                  Icons.delete_outline,
                  color: Color(0xFFD32F2F),
                ),
                title: const Text(
                  'Delete Listing',
                  style: TextStyle(color: Color(0xFFD32F2F)),
                ),
                onTap: () {
                  Navigator.pop(sheetContext);
                  _confirmDelete(context, id);
                },
              ),
            ],
          ),
        ),
      );
    },
  );
}

void _confirmDelete(BuildContext context, int id) {
  showDialog<void>(
    context: context,
    builder: (dialogContext) {
      return AlertDialog(
        backgroundColor: AppColors.bg,
        title: const Text(
          'Delete listing?',
          style: TextStyle(
            color: AppColors.textColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: const Text('This cannot be undone.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text(
              'Cancel',
              style: TextStyle(color: AppColors.textColor),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(dialogContext);
              SellerStore.remove(id);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Listing deleted')),
              );
            },
            child: const Text(
              'Delete',
              style: TextStyle(color: Color(0xFFD32F2F)),
            ),
          ),
        ],
      );
    },
  );
}
