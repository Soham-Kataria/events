import 'package:event_tracker/dummy/dummy_data.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../booking/booking.dart';

class EventController with ChangeNotifier {

  //All events
  List<Map<String, dynamic>> events = allEvents;

  // Favourite toggles
  Map<String, bool> favourites = {};

  EventController() {
    // Initialize favourites map with all events as false
    for (var event in allEvents) {
      favourites[event["title"]!] = false;
    }
  }

  void toggleFavourite(String title) {
    favourites[title] = !(favourites[title] ?? false);
    if (kDebugMode) print("Favourite toggled for $title: ${favourites[title]}");
    notifyListeners();
  }

  // Get only favourited events
  List<Map<String, dynamic>> getFavouriteEvents() {
    return allEvents
        .where((event) => favourites[event["title"]!] == true)
        .toList();
  }

  void navigateToBookingPage(BuildContext context, Map<String, dynamic> event) {
    // Navigator.push(
    //     context,
    //     MaterialPageRoute(
    //       builder: (_) => BookingScreen(eventTitle: event["title"] ?? "Event"),
    //     )
    // );
  }
}