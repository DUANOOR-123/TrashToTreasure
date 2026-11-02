import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import '../core/app_colors.dart';
import '../data/buyer_data.dart';
import '../widgets/filter_pill.dart';
import 'listing_details_screen.dart';
import 'request_pickup_screen.dart';

/// Screen 14: Map View.
/// Shows a real map with pins for nearby materials.
/// Tapping a pin selects it and the card at the bottom updates.
///
/// CHANGED:
///  - isTab: true  -> used as the "Map" tab, so the bottom bar stays visible
///    (no back arrow). isTab: false -> opened from Search with its results.
///  - pins come from the shared kListings list and are colored by category
///  - category chips on top of the map filter the pins
///  - the bottom card has "View Details" AND "Request Pickup" (both work)
class MapViewScreen extends StatefulWidget {
  /// true when shown as a tab inside BuyerShell
  final bool isTab;

  /// Items to show. null = all materials (used by the Map tab).
  final List<Listing>? items;

  const MapViewScreen({super.key, this.isTab = false, this.items});

  @override
  State<MapViewScreen> createState() => _MapViewScreenState();
}

class _MapViewScreenState extends State<MapViewScreen> {
  // Center of the map (Islamabad). Change this to move the map.
  static const LatLng _center = LatLng(33.6844, 73.0479);

  String _category = 'All'; // selected chip above the map
  Listing? _selected; // the pin that is selected (null = none yet)

  // The pins to show: the given items (or all), filtered by the chip
  List<Listing> get _visible {
    final source = widget.items ?? kListings;
    if (_category == 'All') return source;
    return source.where((l) => l.category == _category).toList();
  }

  @override
  Widget build(BuildContext context) {
    final visible = _visible;

    // If the selected pin was filtered out, fall back to the first pin
    final current = _selected;
    final stillVisible =
        current != null && visible.any((l) => l.id == current.id);
    final Listing? item = stillVisible
        ? current
        : (visible.isEmpty ? null : visible.first);

    return Scaffold(
      backgroundColor: AppColors.bg,
      appBar: AppBar(
        backgroundColor: AppColors.bg,
        // As a tab there is nothing to go back to
        automaticallyImplyLeading: !widget.isTab,
        title: const Text(
          'Map View',
          style: TextStyle(
            color: AppColors.textColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: Column(
        children: [
          // ---- Category chips (filter the pins) ----
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(16, 4, 16, 10),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  for (final name in ['All', ...kCategories.map((c) => c.name)])
                    Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: FilterPill(
                        label: name,
                        isSelected: _category == name,
                        onTap: () => setState(() {
                          _category = name;
                          _selected = null;
                        }),
                      ),
                    ),
                ],
              ),
            ),
          ),

          // ---- Map: Expanded makes it fill all space above the card ----
          Expanded(
            child: FlutterMap(
              // Where the map starts and how zoomed in it is
              options: const MapOptions(
                initialCenter: _center,
                initialZoom: 13.5,
              ),
              children: [
                // Layer 1: the map pictures (tiles) from OpenStreetMap
                TileLayer(
                  urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  userAgentPackageName: 'com.example.trash2treasure',
                ),
                // Layer 2: the pins on top of the map
                MarkerLayer(markers: _buildMarkers(visible, item)),
              ],
            ),
          ),

          // ---- Bottom card: details of the selected pin ----
          if (item != null)
            _buildBottomCard(context, item)
          else
            const Padding(
              padding: EdgeInsets.all(20),
              child: Text(
                'No materials in this category',
                style: TextStyle(color: AppColors.textColor),
              ),
            ),
        ],
      ),
    );
  }

  // Turns every item in the list into a pin on the map
  List<Marker> _buildMarkers(List<Listing> visible, Listing? selected) {
    return [
      for (final l in visible)
        Marker(
          point: l.point,
          width: 44,
          height: 44,
          // The tip of the pin sits exactly on the location
          alignment: Alignment.topCenter,
          child: GestureDetector(
            // Tap a pin: remember it and redraw the screen
            onTap: () => setState(() => _selected = l),
            child: Icon(
              Icons.location_on,
              // Selected pin is bigger and dark green, others use the
              // color of their category
              size: l.id == selected?.id ? 44 : 32,
              color: l.id == selected?.id
                  ? AppColors.textColor
                  : categoryByName(l.category).color,
            ),
          ),
        ),
    ];
  }

  // Card at the bottom: photo, title, price, distance, two buttons
  Widget _buildBottomCard(BuildContext context, Listing item) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: const BoxDecoration(
        color: AppColors.backgroundColor,
        border: Border(top: BorderSide(color: AppColors.borderColor)),
      ),
      // As a tab the bottom bar is already below, so no extra SafeArea.
      // Opened from Search there is no bar, so we keep the gesture area free.
      child: SafeArea(
        top: false,
        bottom: !widget.isTab,
        child: Column(
          mainAxisSize: MainAxisSize.min, // card is only as tall as needed
          children: [
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    item.image,
                    height: 56,
                    width: 56,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.title,
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
                        '${item.priceLabel} · ${item.distanceLabel} · ${item.category}',
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
            const SizedBox(height: 12),

            // Two buttons side by side
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.textColor,
                      side: const BorderSide(color: AppColors.textColor),
                    ),
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            ListingDetailsScreen(listing: item),
                      ),
                    ),
                    child: const Text('View Details'),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.textColor,
                      foregroundColor: Colors.white,
                    ),
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            RequestPickupScreen(listing: item),
                      ),
                    ),
                    child: const Text('Request Pickup'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
