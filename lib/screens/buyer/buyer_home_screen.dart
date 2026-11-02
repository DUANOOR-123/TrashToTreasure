import 'package:flutter/material.dart';
import 'package:trash2treasure/core/app_nav.dart';

import 'package:trash2treasure/core/app_colors.dart';
import 'package:trash2treasure/data/buyer_data.dart';
import 'package:trash2treasure/widgets/category_chip.dart';
import 'package:trash2treasure/widgets/material_card.dart';
import 'package:trash2treasure/screens/buyer/categories_screen.dart';
import 'package:trash2treasure/screens/buyer/listing_details_screen.dart';
import 'package:trash2treasure/screens/buyer/my_requests_screen.dart';
import 'package:trash2treasure/screens/buyer/search_filters_screen.dart';

/// Screen 11: Buyer Home (the first tab of the buyer app).
///
/// CHANGED:
///  - the bottom bar is gone from here (BuyerShell has it once for all tabs)
///  - category chips come from kCategories (Organic, Fabric, Industrial,
///    CDA-based, Local Citizen) and each one opens ONLY its own materials
///  - Nearby Materials shows ALL materials, nearest first
///  - the search bar opens the Search screen with the keyboard ready
///  - a "My Requests" card so the buyer can always find their requests
class BuyerHomeScreen extends StatelessWidget {
  /// Called when the buyer taps "See on map" (BuyerShell switches the tab).
  final VoidCallback? onOpenMap;

  const BuyerHomeScreen({super.key, this.onOpenMap});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      // SafeArea keeps content away from the notch / status bar
      body: SafeArea(
        // Scroll view so small phones can scroll instead of overflowing
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ---- Greeting ----
              const Text(
                'Good morning,',
                style: TextStyle(fontWeight: FontWeight.w400),
              ),
              const Text(
                'Ayesha Khan.',
                style: TextStyle(
                  color: AppColors.textColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 16),

              // ---- Search bar (tap = opens the Search screen) ----
              _buildSearchBar(context),
              const SizedBox(height: 20),

              // ---- Categories ----
              _sectionHeader(
                'Categories',
                actionText: 'See all',
                onAction: () => _open(context, const CategoriesScreen()),
              ),
              const SizedBox(height: 12),
              // Chips scroll sideways if they don't fit
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    for (final cat in kCategories)
                      Padding(
                        padding: const EdgeInsets.only(right: 20),
                        child: CategoryChip(
                          label: cat.name,
                          icon: cat.icon,
                          color: cat.color,
                          // Opens the results of THIS category only
                          onTap: () => _open(
                            context,
                            SearchFiltersScreen(initialCategory: cat.name),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // ---- My Requests card ----
              _buildRequestsCard(context),
              const SizedBox(height: 24),

              // ---- Nearby materials (ALL of them, nearest first) ----
              _sectionHeader(
                'Nearby Materials',
                actionText: 'See on map',
                actionIcon: Icons.map_outlined,
                onAction: onOpenMap,
              ),
              const SizedBox(height: 12),
              _buildMaterialsGrid(context),
            ],
          ),
        ),
      ),
    );
  }

  // Opens a screen on top of the current one
  void _open(BuildContext context, Widget screen) {
    Navigator.push(context, MaterialPageRoute(builder: (_) => screen));
  }

  // Title on the left, a small rounded green button on the right
  Widget _sectionHeader(
    String title, {
    String? actionText,
    IconData? actionIcon,
    VoidCallback? onAction,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: AppColors.textColor,
            fontWeight: FontWeight.w800,
            fontSize: 17,
            letterSpacing: 0.2,
          ),
        ),
        if (actionText != null && onAction != null)
          InkWell(
            onTap: onAction,
            borderRadius: BorderRadius.circular(20),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: AppColors.selected.withValues(alpha: 0.5),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: AppColors.borderColor),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (actionIcon != null) ...[
                    Icon(actionIcon, size: 14, color: AppColors.textColor),
                    const SizedBox(width: 4),
                  ],
                  Text(
                    actionText,
                    style: const TextStyle(
                      color: AppColors.textColor,
                      fontWeight: FontWeight.w700,
                      fontSize: 12,
                    ),
                  ),
                  if (actionIcon == null) ...[
                    const SizedBox(width: 2),
                    const Icon(
                      Icons.arrow_forward_ios,
                      size: 10,
                      color: AppColors.textColor,
                    ),
                  ],
                ],
              ),
            ),
          ),
      ],
    );
  }

  // Looks like a search box, but tapping it opens the Search screen
  // (where typing really filters the list). readOnly = no typing here.
  Widget _buildSearchBar(BuildContext context) {
    return TextField(
      readOnly: true,
      onTap: () => _open(context, const SearchFiltersScreen(autofocus: true)),
      decoration: InputDecoration(
        hintText: 'Search materials...',
        prefixIcon: const Icon(Icons.search, color: AppColors.iconColor),
        filled: true,
        fillColor: AppColors.backgroundColor,
        contentPadding: const EdgeInsets.symmetric(vertical: 14),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.borderColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.textColor),
        ),
      ),
    );
  }

  // Card that shows how many requests are active and opens My Requests.
  // ValueListenableBuilder redraws it when a new request is added.
  Widget _buildRequestsCard(BuildContext context) {
    return ValueListenableBuilder<List<BuyerRequest>>(
      valueListenable: RequestStore.requests,
      builder: (context, requests, _) {
        final active = requests.where((r) => r.isActive).length;
        return InkWell(
          onTap: () {
            if (AppNav.requireLogin(context, action: 'see your requests')) {
              _open(context, const MyRequestsScreen());
            }
          },
          borderRadius: BorderRadius.circular(12),
          child: Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: AppColors.selected.withValues(alpha: 0.45),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.borderColor),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.local_shipping_outlined,
                  color: AppColors.iconColor,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'My Requests',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textColor,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        active == 0
                            ? 'No active requests'
                            : '$active active ${active == 1 ? 'request' : 'requests'}',
                        style: const TextStyle(
                          fontSize: 11,
                          color: AppColors.textColor,
                        ),
                      ),
                    ],
                  ),
                ),
                const Icon(Icons.chevron_right, color: AppColors.iconColor),
              ],
            ),
          ),
        );
      },
    );
  }

  // All materials, two per row. LayoutBuilder gives us the screen width
  // so each card gets exactly half (minus the gap).
  Widget _buildMaterialsGrid(BuildContext context) {
    final items = sortedByDistance(kListings);

    return LayoutBuilder(
      builder: (context, constraints) {
        const gap = 12.0;
        final cardWidth = (constraints.maxWidth - gap) / 2;
        return Wrap(
          spacing: gap,
          runSpacing: gap,
          children: [
            for (final item in items)
              SizedBox(
                width: cardWidth,
                child: MaterialCard(
                  image: item.image,
                  title: item.title,
                  price: item.price,
                  distance: item.distanceLabel,
                  // Open Listing Details (Screen 15)
                  onTap: () =>
                      _open(context, ListingDetailsScreen(listing: item)),
                ),
              ),
          ],
        );
      },
    );
  }
}
