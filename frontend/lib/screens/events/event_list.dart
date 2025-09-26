import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../widgets/event_card.dart';
import '../../dummy/dummy_data.dart';

class EventListScreen extends StatelessWidget {
  final String filterType; // "Upcoming Events", "Popular Events", "Recommended for you"
  final bool showBottomNav;

  const EventListScreen({
    super.key,
    this.filterType = "All",
    this.showBottomNav = true,
  });

  @override
  Widget build(BuildContext context) {
    // Filter events based on type
    List<Map<String, dynamic>> filteredEvents = allEvents.where((e) {
      if (filterType == "Upcoming Events") return e["type"] == "upcoming";
      if (filterType == "Popular Events") return e["type"] == "popular";
      if (filterType == "Recommended for you") return e["type"] == "recommendation";
      return true; // "All" shows all events
    }).toList();

    var theme = Theme.of(context);
    var colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(filterType),
        backgroundColor: colorScheme.surface,
        foregroundColor: colorScheme.onSurface,
        elevation: 0,
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: filteredEvents.length,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          var event = filteredEvents[index];
          return EventCard(
            title: event["title"] ?? "No Title",
            location: event["location"] ?? "Unknown",
            imageUrl: event["poster"] ?? "",
            buttonLabel: "Book Now",
            onButtonPressed: () {
              if (kDebugMode) {
                print("${event["title"]} button pressed");
              }
            },
          );
        },
      ),
    );
  }
}
