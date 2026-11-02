import 'package:flutter/material.dart';

// ---------------------------------------------------------------
// ONE place for the seller's dummy data (same idea as buyer_data.dart).
// "My Listings" reads from here, "Publish" adds to it, and
// "Edit / Mark as Sold / Delete" change it.
// BACKEND LATER: replace these methods with calls to your backend.
// ---------------------------------------------------------------
class SellerStore {
  SellerStore._();

  static int _nextId = 5;

  /// Each listing is a map: id, image, title, price, weight, status.
  /// status is one of: Active, Sold, Draft.
  static final ValueNotifier<List<Map<String, dynamic>>> listings =
      ValueNotifier<List<Map<String, dynamic>>>([
        {
          'id': 1,
          'image': 'assets/images/waste.png',
          'title': 'Cardboard Boxes',
          'price': 250,
          'weight': '5 kg',
          'status': 'Active',
        },
        {
          'id': 2,
          'image': 'assets/images/waste.png',
          'title': 'Plastic Bottles',
          'price': 60,
          'weight': '2 kg',
          'status': 'Active',
        },
        {
          'id': 3,
          'image': 'assets/images/waste.png',
          'title': 'Waste Paper',
          'price': 120,
          'weight': '3 kg',
          'status': 'Sold',
        },
        {
          'id': 4,
          'image': 'assets/images/waste.png',
          'title': 'Polythene Bags',
          'price': 20,
          'weight': '1 kg',
          'status': 'Draft',
        },
      ]);

  /// Adds a new listing at the top of the list.
  static void add({
    required String title,
    required int price,
    required String weight,
    required String status,
  }) {
    final item = <String, dynamic>{
      'id': _nextId++,
      'image': 'assets/images/waste.png',
      'title': title,
      'price': price,
      'weight': weight,
      'status': status,
    };
    listings.value = [item, ...listings.value];
  }

  /// Changes some fields of one listing (found by its id).
  static void update(int id, Map<String, dynamic> changes) {
    listings.value = [
      for (final item in listings.value)
        if (item['id'] == id) {...item, ...changes} else item,
    ];
  }

  static void setStatus(int id, String status) {
    update(id, {'status': status});
  }

  static void remove(int id) {
    listings.value = [
      for (final item in listings.value)
        if (item['id'] != id) item,
    ];
  }
}
