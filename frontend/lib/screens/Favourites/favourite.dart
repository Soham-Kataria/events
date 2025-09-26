import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../widgets/big_event_card.dart';
import '../events/controller.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Favourites"),
        backgroundColor: colorScheme.surface,
        foregroundColor: colorScheme.onSurface,
        elevation: 0,
      ),
      body: Consumer<EventController>(
        builder: (context, eventController, _) {
          // Get all events that are favourited
          var favouriteEvents = eventController.getFavouriteEvents()
              .fold<Map<String, Map<String, dynamic>>>({}, (map, event) {
            map[event["title"]] = event; // overwrite duplicates
            return map;
          })
              .values
              .toList();


          if (favouriteEvents.isEmpty) {
            return const Center(
              child: Text("No favourites yet"),
            );
          }

          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: favouriteEvents.length,
            separatorBuilder: (_, __) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              var event = favouriteEvents[index];
               // bool isFavourite = eventController.favourites[event["title"]!] ?? false;
              return BigEventCard(
                title: event["title"]!,
                genre: event["genre"]!,
                imageUrl: event["poster"]!,
                dateTime: event["dateTime"]!,
                price: event["price"]?.toString() ?? "0",
                // This toggle automatically updates the list
                //  onFavouriteToggle: () => eventController.toggleFavourite(event["title"]!),
              );
            },
          );
        },
      ),
    );
  }
}
