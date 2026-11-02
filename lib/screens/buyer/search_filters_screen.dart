import 'package:flutter/material.dart';

import 'package:trash2treasure/screens/buyer/listing_details_screen.dart';
import 'package:trash2treasure/screens/buyer/map_view_screen.dart';
import 'package:trash2treasure/core/app_colors.dart';
import 'package:trash2treasure/data/buyer_data.dart';
import 'package:trash2treasure/widgets/filter_pill.dart';
import 'package:trash2treasure/widgets/search_result_tile.dart';

/// Screen 13: Search & Filters (also the "results of a category" screen).
///
/// CHANGED:
///  - initialCategory: opening it from Organic/Fabric/... shows ONLY that
///    category (the buyer can still switch with the chips at the top)
///  - autofocus: opening it from the Home search bar puts the cursor in
///    the box right away
///  - search now looks in the title, category and description, and works
///    together with the category chip and the filters
///  - Distance opens a small menu (2 / 5 / 10 km), Free only toggles,
///    and "Clear" appears when any filter is on
///  - the Map icon opens the map with the CURRENT results
class SearchFiltersScreen extends StatefulWidget {
  final String? initialCategory; // e.g. 'Organic'. null = all categories
  final String initialQuery; // text already typed in the box
  final bool autofocus; // true = keyboard opens immediately

  const SearchFiltersScreen({
    super.key,
    this.initialCategory,
    this.initialQuery = '',
    this.autofocus = false,
  });

  @override
  State<SearchFiltersScreen> createState() => _SearchFiltersScreenState();
}

class _SearchFiltersScreenState extends State<SearchFiltersScreen> {
  // ---- Things that can change (the screen's "state") ----
  late final TextEditingController _searchController;
  late String _category; // 'All' or a category name
  String _query = ''; // text typed in the search box
  String _sortBy = 'Nearby'; // 'Nearby' or 'Price'
  bool _freeOnly = false; // "Free only" button on/off
  double? _maxKm; // null = any distance, otherwise 2, 5 or 10

  @override
  void initState() {
    super.initState();
    _category = widget.initialCategory ?? 'All';
    _query = widget.initialQuery;
    _searchController = TextEditingController(text: widget.initialQuery);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  // True when the buyer changed any filter (shows the "Clear" button)
  bool get _hasFilters => _freeOnly || _maxKm != null;

  // The list actually shown: apply category + search + filters, then sort.
  // A "getter" is a variable that is calculated each time it is read.
  List<Listing> get _results {
    final q = _query.trim().toLowerCase();

    final list = kListings.where((item) {
      // 1. Category chip
      if (_category != 'All' && item.category != _category) return false;

      // 2. Search: text must be in the title, category or description
      if (q.isNotEmpty) {
        final text = '${item.title} ${item.category} ${item.description}'
            .toLowerCase();
        if (!text.contains(q)) return false;
      }

      // 3. "Free only": keep only price 0
      if (_freeOnly && item.price != 0) return false;

      // 4. "Distance": keep only items inside the chosen radius
      if (_maxKm != null && item.distanceKm > _maxKm!) return false;

      return true; // passed all checks
    }).toList();

    // 5. Sort according to the selected chip
    list.sort((a, b) {
      if (_sortBy == 'Price') return a.price.compareTo(b.price);
      return a.distanceKm.compareTo(b.distanceKm); // Nearby
    });

    return list;
  }

  // Resets the search box and every filter (category stays)
  void _clearFilters() {
    setState(() {
      _freeOnly = false;
      _maxKm = null;
      _query = '';
      _searchController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    final results = _results; // calculate once per redraw

    return Scaffold(
      backgroundColor: AppColors.bg,
      appBar: AppBar(
        backgroundColor: AppColors.bg,
        title: Text(
          _category == 'All' ? 'Search & Filters' : _category,
          style: const TextStyle(
            color: AppColors.textColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        // Map icon on the right: opens the map with these results
        actions: [
          IconButton(
            tooltip: 'Show on map',
            icon: const Icon(Icons.map_outlined, color: AppColors.iconColor),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MapViewScreen(items: results),
                ),
              );
            },
          ),
        ],
      ),

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ---- Search box ----
              _buildSearchBar(),
              const SizedBox(height: 12),

              // ---- Category chips: All / Organic / Fabric ... ----
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    for (final name in [
                      'All',
                      ...kCategories.map((c) => c.name),
                    ])
                      Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: FilterPill(
                          label: name,
                          isSelected: _category == name,
                          onTap: () => setState(() => _category = name),
                        ),
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 12),

              // ---- Sort + result count ----
              Row(
                children: [
                  for (final name in ['Nearby', 'Price'])
                    Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: FilterPill(
                        label: name == 'Price' ? 'Price: low to high' : name,
                        isSelected: _sortBy == name,
                        onTap: () => setState(() => _sortBy = name),
                      ),
                    ),
                  const Spacer(),
                  Text(
                    '${results.length} found',
                    style: TextStyle(
                      fontSize: 11,
                      color: AppColors.textColor.withValues(alpha: 0.7),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // ---- Results list ----
              Expanded(
                child: results.isEmpty
                    ? _buildEmpty()
                    : ListView.builder(
                        itemCount: results.length,
                        itemBuilder: (context, index) {
                          final item = results[index];
                          return SearchResultTile(
                            image: item.image,
                            title: item.title,
                            price: item.price,
                            distance: item.distanceKm,
                            // Open Listing Details (Screen 15)
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      ListingDetailsScreen(listing: item),
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

      // ---- Bottom filter buttons ----
      bottomNavigationBar: _buildBottomFilters(),
    );
  }

  // Shown when nothing matches
  Widget _buildEmpty() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.search_off,
            size: 48,
            color: AppColors.textColor.withValues(alpha: 0.4),
          ),
          const SizedBox(height: 8),
          const Text(
            'No materials found',
            style: TextStyle(color: AppColors.textColor),
          ),
          const SizedBox(height: 8),
          TextButton(
            onPressed: _clearFilters,
            child: const Text('Clear search & filters'),
          ),
        ],
      ),
    );
  }

  // Search text box (same style as the Buyer Home search bar)
  Widget _buildSearchBar() {
    return TextField(
      controller: _searchController,
      autofocus: widget.autofocus,
      textInputAction: TextInputAction.search,
      // onChanged runs on every typed letter and updates the list live
      onChanged: (value) => setState(() => _query = value),
      decoration: InputDecoration(
        hintText: 'Search materials...',
        prefixIcon: const Icon(Icons.search, color: AppColors.iconColor),
        // "x" button to clear the text (only when something is typed)
        suffixIcon: _query.isEmpty
            ? null
            : IconButton(
                icon: const Icon(Icons.close, color: AppColors.iconColor),
                onPressed: () {
                  _searchController.clear();
                  setState(() => _query = '');
                },
              ),
        filled: true,
        fillColor: AppColors.backgroundColor,
        contentPadding: const EdgeInsets.symmetric(vertical: 12),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(24),
          borderSide: const BorderSide(color: AppColors.borderColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(24),
          borderSide: const BorderSide(color: AppColors.textColor),
        ),
      ),
    );
  }

  // Bar at the bottom with Distance / Free only / Clear
  Widget _buildBottomFilters() {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.backgroundColor,
        border: Border(top: BorderSide(color: AppColors.borderColor)),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Opens a small menu to pick the radius
              FilterPill(
                label: _maxKm == null
                    ? 'Distance'
                    : 'Within ${_maxKm!.toStringAsFixed(0)} km',
                showArrow: true,
                isSelected: _maxKm != null,
                onTap: _showDistanceSheet,
              ),
              // Toggle: on = only free items
              FilterPill(
                label: 'Free only',
                isSelected: _freeOnly,
                onTap: () => setState(() => _freeOnly = !_freeOnly),
              ),
              // Only visible when a filter is on
              if (_hasFilters)
                FilterPill(label: 'Clear', onTap: _clearFilters)
              else
                const SizedBox(width: 72),
            ],
          ),
        ),
      ),
    );
  }

  // Bottom sheet with the distance choices
  void _showDistanceSheet() {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: AppColors.bg,
      builder: (sheetContext) {
        // null means "any distance"
        final options = <double?>[null, 2, 5, 10];
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Padding(
                padding: EdgeInsets.all(16),
                child: Text(
                  'Distance',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textColor,
                  ),
                ),
              ),
              for (final km in options)
                ListTile(
                  title: Text(
                    km == null
                        ? 'Any distance'
                        : 'Within ${km.toStringAsFixed(0)} km',
                    style: const TextStyle(color: AppColors.textColor),
                  ),
                  trailing: _maxKm == km
                      ? const Icon(Icons.check, color: AppColors.textColor)
                      : null,
                  onTap: () {
                    setState(() => _maxKm = km);
                    Navigator.pop(sheetContext);
                  },
                ),
              const SizedBox(height: 8),
            ],
          ),
        );
      },
    );
  }
}
