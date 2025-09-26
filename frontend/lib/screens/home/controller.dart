import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../dummy/dummy_data.dart';

class HomeController with ChangeNotifier {
  // Search field controller
  var txtHomeSearch = TextEditingController();


  // Quick filters
  List<String> quickFilters = [
    "All",
    "Music",
    "Art",
    "Tech",
    "Food",
  ];

  // Selected filter index (-1 = none)
  int _selectedFilter = -1;
  int get selectedFilter => _selectedFilter;

  // Methods
  void selectFilter(int index) {
    if (_selectedFilter == index) {
      _selectedFilter = -1; // unselect if clicked again
    } else {
      _selectedFilter = index;
    }
    notifyListeners();
  }

  // Filtered lists for UI
  List<Map<String, dynamic>> get upcomingEvents =>
      allEvents.where((e) => e["type"] == "upcoming").toList();

  List<Map<String, dynamic>> get popularEvents =>
      allEvents.where((e) => e["type"] == "popular").toList();

  List<Map<String, dynamic>> get recommendedEvents =>
      allEvents.where((e) => e["type"] == "recommendation").toList();


  // Methods
  void handleEventButton(String title) {
    if (kDebugMode) {
      print("Event action pressed for: $title");
    }
  }

  void handleFavouriteToggle(String title) {
    if (kDebugMode) {
      print("Favourite toggled for: $title");
    }
  }
}
