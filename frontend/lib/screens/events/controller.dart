import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../dummy/dummy_data.dart';
import '../../models/event_model.dart';


class EventController with ChangeNotifier {
  List<EventModel> events = allEvents.map((e) => EventModel.fromJson(e)).toList();
  Map<String, bool> favourites = {};

  EventController() {
    for (var e in events) {
      favourites[e.title] = false;
    }
  }

  void toggleFavourite(String title) {
    favourites[title] = !(favourites[title] ?? false);
    if (kDebugMode) print("Favourite toggled for $title: ${favourites[title]}");
    notifyListeners();
  }

  List<EventModel> getFavouriteEvents() {
    return events.where((e) => favourites[e.title] == true).toList();
  }

  void navigateToBookingPage(BuildContext context, EventModel event) {
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //     builder: (_) => BookingScreen(event: event),
    //   ),
    // );
  }
}
