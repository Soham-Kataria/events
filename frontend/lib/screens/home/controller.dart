import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class HomeController with ChangeNotifier {
  // Search field controller
  var txtHomeSearch = TextEditingController();

  // Dummy data for upcoming events
  List<Map<String,String>> upcomingEvents = [
    {
      "title": "Music Concert",
      "location": "Surat",
      "image": "https://picsum.photos/150",
      "buttonLabel": "Book Now",
    },
    {
      "title": "Art Exhibition",
      "location": "city Center",
      "image": "https://picsum.photos/150",
      "buttonLabel": "Book Now",
    },
    {
      "title": "Dance Show",
      "location": "Apple Hub",
      "image": "https://picsum.photos/100",
      "buttonLabel": "Book Now",
    },
  ];

  // Dummy data for popular events
  List<Map<String,String>> popularEvents = [
    {
      "title": "Tech Conference",
      "genre": "Tech",
      "image": "https://picsum.photos/300",
      "dateTime": "25 Sep, 2025 10:00 AM",
      "price": "500",
    },
    {
      "title": "Food Festival",
      "genre": "Food",
      "image": "https://picsum.photos/300",
      "dateTime": "26 Sep, 2025 5:00 PM",
      "price": "200",
    },
    {
      "title": "Comedy Night",
      "genre": "Comedy",
      "image": "https://picsum.photos/300",
      "dateTime": "27 Sep, 2025 7:00 PM",
      "price": "300",
    },
  ];

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
