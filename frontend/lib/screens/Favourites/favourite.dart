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
          // Get all favourited events
          var favouriteEvents = eventController.getFavouriteEvents();

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
             // bool isFavourite = eventController.favourites[event.title] ?? false;

              return BigEventCard(
                event: event, // Pass the EventModel object directly
                // Optionally, you can add favourite toggle logic inside BigEventCard
              );
            },
          );
        },
      ),
    );
  }
}
