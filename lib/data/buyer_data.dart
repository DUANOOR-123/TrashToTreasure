import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';

// ---------------------------------------------------------------
// ONE place for all the buyer's dummy data.
// Home, Search, Map and Messages all read from here, so the same
// materials show up everywhere. Later: replace these lists with
// calls to your backend (Firebase) and nothing else has to change.
// ---------------------------------------------------------------

/// A category (Organic, Fabric...). Used by the home chips,
/// the Categories screen, the Search chips and the map pins.
class Category {
  final String name;
  final String subtitle;
  final IconData icon;
  final Color color;

  const Category(this.name, this.subtitle, this.icon, this.color);
}

/// The 5 categories from your design (same names as Screen 12).
/// Change a name or color here and it changes in every screen.
const List<Category> kCategories = [
  Category(
    'Organic',
    'Compost, peels, garden waste',
    Icons.eco,
    Color(0xFF2E9E5B),
  ),
  Category(
    'Fabric',
    'Clothes, textile, scraps',
    Icons.checkroom,
    Color(0xFFE2703A),
  ),
  Category(
    'Industrial',
    'Plastic, metal, etc.',
    Icons.precision_manufacturing,
    Color(0xFF3B6FB6),
  ),
  Category(
    'CDA-based',
    'City & CDA collection',
    Icons.location_city,
    Color(0xFF00897B),
  ),
  Category(
    'Local Citizen',
    'Nearby individuals',
    Icons.people,
    Color(0xFF7B4FD6),
  ),
];

/// Finds a category by its name (used to get the color of a pin, etc.)
Category categoryByName(String name) => kCategories.firstWhere(
  (c) => c.name == name,
  orElse: () => kCategories.first,
);

/// One material that a seller has listed.
class Listing {
  final int id;
  final String title;
  final String category; // must match a name in kCategories
  final int price; // per kg. 0 means free
  final double distanceKm;
  final String sellerName;
  final String description;
  final String location;
  final LatLng point; // pin position on the map
  final String image;
  final double rating;
  final int reviews;

  const Listing({
    required this.id,
    required this.title,
    required this.category,
    required this.price,
    required this.distanceKm,
    required this.sellerName,
    required this.description,
    required this.location,
    required this.point,
    this.image = 'assets/images/waste.png',
    this.rating = 4.8,
    this.reviews = 12,
  });

  /// "1.1 km"
  String get distanceLabel => '$distanceKm km';

  /// "Free" or "Rs. 200"
  String get priceLabel => price == 0 ? 'Free' : 'Rs. $price';
}

/// All materials near the buyer (dummy). Sorted by distance when shown.
const List<Listing> kListings = [
  Listing(
    id: 1,
    title: 'Fabric scraps (mixed)',
    category: 'Fabric',
    price: 200,
    distanceKm: 1.1,
    sellerName: 'Ayesha-Fabrics',
    description:
        'Mixed fabric pieces, suitable for bags, pouches, crafts and more.',
    location: 'F-7, Islamabad',
    point: LatLng(33.6844, 73.0479),
  ),
  Listing(
    id: 2,
    title: 'Cotton fabric pieces',
    category: 'Fabric',
    price: 100,
    distanceKm: 2.1,
    sellerName: 'Sara Textiles',
    description: 'Soft cotton offcuts from a tailoring shop. Clean and dry.',
    location: 'G-9, Islamabad',
    point: LatLng(33.6950, 73.0620),
  ),
  Listing(
    id: 3,
    title: 'Denim scraps',
    category: 'Fabric',
    price: 160,
    distanceKm: 2.5,
    sellerName: 'Umar Denim Works',
    description: 'Blue denim leftovers, good for patchwork and bags.',
    location: 'I-8, Islamabad',
    point: LatLng(33.6730, 73.0350),
  ),
  Listing(
    id: 4,
    title: 'Organic waste',
    category: 'Organic',
    price: 100,
    distanceKm: 2.4,
    sellerName: 'Green Farm Stall',
    description: 'Fruit and vegetable waste, ready for composting.',
    location: 'G-11, Islamabad',
    point: LatLng(33.6900, 73.0300),
  ),
  Listing(
    id: 5,
    title: 'Banana peels',
    category: 'Organic',
    price: 0,
    distanceKm: 0.8,
    sellerName: 'Zara Juice Corner',
    description: 'Fresh banana peels every evening. Free, come and collect.',
    location: 'F-6, Islamabad',
    point: LatLng(33.6890, 73.0530),
  ),
  Listing(
    id: 6,
    title: 'Garden leaves',
    category: 'Organic',
    price: 0,
    distanceKm: 1.6,
    sellerName: 'Rida Khan',
    description: 'Dry leaves and grass cuttings, good for mulch or compost.',
    location: 'F-8, Islamabad',
    point: LatLng(33.7010, 73.0400),
  ),
  Listing(
    id: 7,
    title: 'Plastic bottles',
    category: 'Industrial',
    price: 60,
    distanceKm: 3.2,
    sellerName: 'Bilal Traders',
    description: 'Cleaned PET bottles, sorted and ready for recycling.',
    location: 'I-9 Industrial Area',
    point: LatLng(33.6700, 73.0600),
  ),
  Listing(
    id: 8,
    title: 'Scrap metal pieces',
    category: 'Industrial',
    price: 120,
    distanceKm: 3.8,
    sellerName: 'Khan Workshop',
    description: 'Small iron and aluminium offcuts from a workshop.',
    location: 'I-10 Industrial Area',
    point: LatLng(33.6640, 73.0440),
  ),
  Listing(
    id: 9,
    title: 'Cardboard & paper',
    category: 'CDA-based',
    price: 40,
    distanceKm: 1.9,
    sellerName: 'City Collection Point',
    description: 'Flattened cardboard and office paper from city collection.',
    location: 'Blue Area, Islamabad',
    point: LatLng(33.7080, 73.0560),
  ),
  Listing(
    id: 10,
    title: 'Glass bottles',
    category: 'CDA-based',
    price: 30,
    distanceKm: 2.9,
    sellerName: 'Urban Recyclers',
    description: 'Mixed glass bottles collected from city bins. Washed.',
    location: 'G-6, Islamabad',
    point: LatLng(33.7120, 73.0680),
  ),
  Listing(
    id: 11,
    title: 'Old newspapers',
    category: 'Local Citizen',
    price: 25,
    distanceKm: 1.3,
    sellerName: 'Maryam Siddiqui',
    description: 'Two months of newspapers from a home. Dry and stacked.',
    location: 'F-10, Islamabad',
    point: LatLng(33.6780, 73.0580),
  ),
  Listing(
    id: 12,
    title: 'Used glass jars',
    category: 'Local Citizen',
    price: 0,
    distanceKm: 0.6,
    sellerName: 'Hina Malik',
    description:
        'About 20 clean jars with lids. Free to anyone who can pick up.',
    location: 'F-7, Islamabad',
    point: LatLng(33.6810, 73.0420),
  ),
];

/// Sorts a list of listings nearest first (does not change the original).
List<Listing> sortedByDistance(Iterable<Listing> items) =>
    items.toList()..sort((a, b) => a.distanceKm.compareTo(b.distanceKm));

// ---------------------------------------------------------------
// Chat conversations (Messages tab)
// ---------------------------------------------------------------
class Conversation {
  final String sellerName;
  final String lastMessage;
  final String time;
  final int unread; // 0 = nothing new

  const Conversation({
    required this.sellerName,
    required this.lastMessage,
    required this.time,
    this.unread = 0,
  });
}

const List<Conversation> kConversations = [
  Conversation(
    sellerName: 'Ayesha-Fabrics',
    lastMessage: 'Yes, it is. Would you like to see some photos?',
    time: '10:45 AM',
    unread: 2,
  ),
  Conversation(
    sellerName: 'Sara Textiles',
    lastMessage: 'Thanks! I will keep it for you till evening.',
    time: 'Yesterday',
  ),
  Conversation(
    sellerName: 'Zara Juice Corner',
    lastMessage: 'Can you share your location?',
    time: 'Mon',
    unread: 1,
  ),
];

/// Total unread messages (shown as a red badge on the Messages tab).
int get totalUnread => kConversations.fold(0, (sum, c) => sum + c.unread);

// ---------------------------------------------------------------
// Buyer's pickup requests (My Requests screen)
// ---------------------------------------------------------------
class BuyerRequest {
  final Listing listing;
  final double quantity; // kg
  final String time; // preferred pickup time
  final String status; // Pending, Confirmed, Canceled or Completed

  const BuyerRequest({
    required this.listing,
    required this.quantity,
    required this.time,
    required this.status,
  });

  /// Active = still going on. Completed tab = finished or canceled.
  bool get isActive => status == 'Pending' || status == 'Confirmed';
}

/// The list of requests. It is a ValueNotifier, so any screen that
/// listens to it (My Requests, the Home card) redraws when you add one.
/// Later: replace with data from the backend.
class RequestStore {
  static final ValueNotifier<List<BuyerRequest>> requests =
      ValueNotifier<List<BuyerRequest>>([
        BuyerRequest(
          listing: kListings[0],
          quantity: 2,
          time: 'Today, 4–6 PM',
          status: 'Pending',
        ),
        BuyerRequest(
          listing: kListings[3],
          quantity: 5,
          time: 'Tomorrow, 10 AM–12 PM',
          status: 'Confirmed',
        ),
        BuyerRequest(
          listing: kListings[2],
          quantity: 3,
          time: 'Jan 10, 5 PM',
          status: 'Completed',
        ),
        BuyerRequest(
          listing: kListings[6],
          quantity: 10,
          time: 'Jan 5, 11 AM',
          status: 'Canceled',
        ),
      ]);

  /// Adds a new request at the top of the list.
  static void add(BuyerRequest request) {
    requests.value = [request, ...requests.value];
  }
}
