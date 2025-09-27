// screens/home/controller.dart
import 'package:flutter/material.dart';
import '../../dummy/dummy_data.dart';
import '../../models/event_model.dart';

class HomeController with ChangeNotifier {
  var txtHomeSearch = TextEditingController();

  List<String> quickFilters = ["All", "Music", "Art", "Tech", "Food"];
  int _selectedFilter = -1;
  int get selectedFilter => _selectedFilter;

  void selectFilter(int index) {
    _selectedFilter = _selectedFilter == index ? -1 : index;
    notifyListeners();
  }

  List<EventModel> get upcomingEvents =>
      allEvents.map((e) => EventModel.fromJson(e))
          .where((e) => e.type == "upcoming")
          .toList();

  List<EventModel> get popularEvents =>
      allEvents.map((e) => EventModel.fromJson(e))
          .where((e) => e.type == "popular")
          .toList();

  List<EventModel> get recommendedEvents =>
      allEvents.map((e) => EventModel.fromJson(e))
          .where((e) => e.type == "recommendation")
          .toList();
}
