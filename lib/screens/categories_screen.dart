import 'package:flutter/material.dart';

import './search_filters_screen.dart';
import '../core/app_colors.dart';
import '../data/buyer_data.dart';
import '../widgets/category_tile.dart';

/// Screen 12: Categories / Browse.
/// Opened from "See all" on the Home screen.
/// Shows an "All" chip and one row for each material category.
///
/// CHANGED: the list now comes from kCategories (same names as the Home
/// chips), each row shows how many materials it has, and tapping a row
/// opens the results of THAT category only (it used to open everything).
class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  // How many materials are in a category (counts the shared dummy list)
  int _count(String category) =>
      kListings.where((l) => l.category == category).length;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,

      // Top bar with the title. Flutter adds the back arrow automatically
      // because this screen is opened with Navigator.push.
      appBar: AppBar(
        backgroundColor: AppColors.bg,
        title: const Text(
          'Categories',
          style: TextStyle(
            color: AppColors.textColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      // SafeArea keeps content away from the phone's edges
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ---- "All" chip: opens every material ----
              _buildAllChip(context),
              const SizedBox(height: 16),

              // ---- List of categories ----
              Expanded(
                child: ListView.builder(
                  itemCount: kCategories.length,
                  itemBuilder: (context, index) {
                    final cat = kCategories[index];
                    return CategoryTile(
                      title: cat.name,
                      subtitle: '${cat.subtitle} · ${_count(cat.name)} items',
                      icon: cat.icon,
                      color: cat.color,
                      // Open results of this category only (Screen 13)
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                SearchFiltersScreen(initialCategory: cat.name),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // The small rounded "All" chip at the top (now tappable)
  Widget _buildAllChip(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const SearchFiltersScreen()),
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 6),
        decoration: BoxDecoration(
          color: AppColors.selected, // her "selected" light green
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          'All (${kListings.length})',
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: AppColors.textColor,
          ),
        ),
      ),
    );
  }
}
