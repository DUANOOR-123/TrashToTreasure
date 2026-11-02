import 'package:flutter/material.dart';

/// Materials the user saved (bookmarked). Stores only the listing ids.
/// The Saved Items screen and the bookmark icon on Listing Details
/// both listen to this, so they always agree.
/// BACKEND LATER: save these ids in the user's document.
class SavedStore {
  SavedStore._();

  static final ValueNotifier<Set<int>> ids = ValueNotifier<Set<int>>(<int>{});

  static bool isSaved(int id) => ids.value.contains(id);

  static void toggle(int id) {
    final next = Set<int>.from(ids.value);
    if (!next.remove(id)) {
      next.add(id);
    }
    ids.value = next;
  }
}
