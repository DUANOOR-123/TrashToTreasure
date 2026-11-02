import 'package:flutter/material.dart';

import 'package:trash2treasure/core/app_colors.dart';
import 'package:trash2treasure/data/buyer_data.dart';
import 'package:trash2treasure/data/shared_data.dart';
import 'package:trash2treasure/screens/buyer/listing_details_screen.dart';
import 'package:trash2treasure/widgets/search_result_tile.dart';

/// Screen 36: Saved Items.
/// Shows the materials the user bookmarked on Listing Details.
class SavedItemsScreen extends StatelessWidget {
  const SavedItemsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Saved Items',
          style: TextStyle(
            color: AppColors.textColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(
        child: ValueListenableBuilder<Set<int>>(
          valueListenable: SavedStore.ids,
          builder: (context, ids, _) {
            final saved = kListings.where((l) => ids.contains(l.id)).toList();

            if (saved.isEmpty) {
              return const Center(
                child: Padding(
                  padding: EdgeInsets.all(24),
                  child: Text(
                    'No saved items yet.\nTap the bookmark on a material to save it.',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: AppColors.textColor),
                  ),
                ),
              );
            }

            return ListView.builder(
              padding: const EdgeInsets.all(15),
              itemCount: saved.length,
              itemBuilder: (context, index) {
                final item = saved[index];
                return SearchResultTile(
                  image: item.image,
                  title: item.title,
                  price: item.price,
                  distance: item.distanceKm,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ListingDetailsScreen(listing: item),
                      ),
                    );
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}
