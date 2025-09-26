import 'package:event_tracker/widgets/event_card.dart';
import 'package:event_tracker/widgets/big_event_card.dart';
import 'package:event_tracker/components/ui_utils.dart';
import 'package:event_tracker/widgets/text_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../theme/colors.dart';
import '../events/controller.dart';
import '../events/event_list.dart';
import 'controller.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    var home = Provider.of<HomeController>(context);
    var theme = Theme.of(context);
    var colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorScheme.surface,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 2),
              child: Icon(Icons.location_on, color: Colors.red, size: 20),
            ),
            hSpace(4),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      'Home',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: colorScheme.onSurface,
                      ),
                    ),
                    hSpace(2),
                    Icon(Icons.keyboard_arrow_down,
                        color: colorScheme.onSurface, size: 24),
                  ],
                ),
                vSpace(4),
                Text(
                  'Surat',
                  style: TextStyle(
                    fontSize: 16,
                    color: colorScheme.onSurface.withValues(alpha: 0.7),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search Field
            Material(
              elevation: 6,
              borderRadius: BorderRadius.circular(12),
              child: customTextField(
                controller: home.txtHomeSearch,
                hintText: 'Search events...',
                prefixIcon: Icon(Icons.search, color: theme.iconTheme.color),
                suffixIcon: Icon(Icons.filter_alt_outlined, color: theme.iconTheme.color, size: 24),
              ),
            ),
            vSpace(16),
            // Quick Filters
            SizedBox(
              height: 40,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: home.quickFilters.length,
                itemBuilder: (context, index) {
                  var isSelected = index == home.selectedFilter;
                  var isDark = theme.brightness == Brightness.dark;
                  return GestureDetector(
                    onTap: () => home.selectFilter(index),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 8),
                      margin: const EdgeInsets.only(right: 8),
                      decoration: BoxDecoration(
                        color: isSelected ? kPrimaryColor : isDark ? kDarkColor : kWhiteColor,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: isSelected ? kPrimaryColor : isDark ? kGrayColor : kLightColor,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          home.quickFilters[index],
                          style: TextStyle(
                            color: isSelected ? kWhiteColor : isDark ? kWhiteColor : kDarkColor, fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            vSpace(16),
            // Upcoming Events
            _buildSectionHeader(
                "Upcoming Events", home.upcomingEvents),
            SizedBox(
              height: 130,
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                scrollDirection: Axis.horizontal,
                itemCount: home.upcomingEvents.length,
                separatorBuilder: (_, __) => hSpace(8),
                itemBuilder: (context, index) {
                  var event = home.upcomingEvents[index];
                  return ConstrainedBox(
                    constraints: BoxConstraints(
                      minWidth: 250,
                      maxWidth: MediaQuery.of(context).size.width * 0.9,
                    ),
                    child: EventCard(
                      title: event["title"]!,
                      location: event["location"]!,
                      imageUrl: event["poster"]!,
                      buttonLabel: "Notify",
                      onButtonPressed: () {
                        // Todo: Make Notification feature
                      },
                    ),
                  );
                },
              ),
            ),
            vSpace(16),

            // Popular Events
            _buildSectionHeader("Popular Events", home.popularEvents),
            SizedBox(
              height: 331,
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                scrollDirection: Axis.horizontal,
                itemCount: home.popularEvents.length,
                separatorBuilder: (_, __) => hSpace(8),
                itemBuilder: (context, index) {
                  var event = home.popularEvents[index];
                  return ConstrainedBox(
                    constraints: BoxConstraints(
                      minWidth: 250,
                      maxWidth: MediaQuery.of(context).size.width * 0.92,
                    ),
                    child: Consumer<EventController>(
                      builder: (context, eventController, _) {
                        // bool isFavourite = eventController.favourites[event["title"]!] ?? false;
                        return BigEventCard(
                          title: event["title"]!,
                          genre: event["genre"]!,
                          imageUrl: event["poster"]!,
                          dateTime: event["dateTime"]!,
                          price: event["price"]?.toString() ?? "0",
                          // isFavourite: isFavourite,
                          // onFavouriteToggle: () => eventController.toggleFavourite(event["title"]!),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
            vSpace(16),

            // Recommended Events
            _buildSectionHeader(
                "Recommended for you", home.recommendedEvents),
            ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: home.recommendedEvents.length,
              separatorBuilder: (_, __) => const SizedBox(height: 8),
              itemBuilder: (context, index) {
                var event = home.recommendedEvents[index];
                return EventCard(
                  title: event["title"]!,
                  location: event["location"]!,
                  imageUrl: event["poster"]!,
                  buttonLabel: "Book Now",
                  onButtonPressed: () {
                    // Navigate to detail if needed
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(
      String title, List<Map<String, dynamic>> events) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: Theme.of(context)
              .textTheme
              .titleMedium
              ?.copyWith(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => EventListScreen(
                  filterType: title,
                ),
              ),
            );
          },
          child: const Text("See All"),
        ),
      ],
    );
  }
}
