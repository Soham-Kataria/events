import 'package:event_tracker/widgets/event_card.dart';
import 'package:event_tracker/components/ui_utils.dart';
import 'package:event_tracker/widgets/text_field.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../theme/colors.dart';
import '../../widgets/big_event_card.dart';
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
    var textTheme = theme.textTheme;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorScheme.surface,
        elevation: 0,
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.transparent,
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
                    color: colorScheme.onSurface.withValues(alpha:0.7),
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
                suffixIcon: Icon(Icons.filter_alt_outlined,
                    color: theme.iconTheme.color, size: 24),
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
                    onTap: () => setState(() => home.selectFilter(index)),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 8),
                      margin: const EdgeInsets.only(right: 8),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? kPrimaryColor
                            : isDark
                            ? kDarkColor
                            : kWhiteColor,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: isSelected
                              ? kPrimaryColor
                              : isDark
                              ? kGrayColor
                              : kLightColor,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          home.quickFilters[index],
                          style: TextStyle(
                            color: isSelected
                                ? kWhiteColor
                                : isDark
                                ? kWhiteColor
                                : kDarkColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            vSpace(4),

            // Upcoming Events Header
            _buildSectionHeader("Upcoming Events", () {}),

            // Upcoming Events Horizontal List
            SizedBox(
              height: 130,
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                scrollDirection: Axis.horizontal,
                itemCount: home.upcomingEvents.length,
                separatorBuilder: (_, __) => const SizedBox(width: 8),
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
                      imageUrl: event["image"]!,
                      buttonLabel: event["buttonLabel"]!,
                      onButtonPressed: () {
                        if (kDebugMode) {
                          print("${event["title"]} button pressed");
                        }
                      },
                    ),
                  );
                },
              ),
            ),

            // Popular Events Header
            _buildSectionHeader("Popular Events", () {}),

            vSpace(2),

            // Popular Events Horizontal List
            SizedBox(
              height: 350,
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                scrollDirection: Axis.horizontal,
                itemCount: home.popularEvents.length,
                separatorBuilder: (_, __) => const SizedBox(width: 8),
                itemBuilder: (context, index) {
                  var event = home.popularEvents[index];
                  return ConstrainedBox(
                    constraints: BoxConstraints(
                      minWidth: 250,
                      maxWidth: MediaQuery.of(context).size.width * 0.85,
                    ),
                    child: BigEventCard(
                      title: event["title"]!,
                      genre: event["genre"]!,
                      imageUrl: event["image"]!,
                      dateTime: event["dateTime"]!,
                      price: event["price"]!,
                      onFavouriteToggle: () =>
                          home.handleFavouriteToggle(event["title"]!),
                    ),
                  );
                },
              ),
            ),

            // Recommendation Header
            _buildSectionHeader("Recommendation for you", () {}),

            vSpace(4),

            // Recommendation Vertical List
            ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: home.upcomingEvents.length,
              separatorBuilder: (_, __) => const SizedBox(height: 8),
              itemBuilder: (context, index) {
                var event = home.upcomingEvents[index];
                return EventCard(
                  title: event["title"]!,
                  location: event["location"]!,
                  imageUrl: event["image"]!,
                  buttonLabel: event["buttonLabel"]!,
                  onButtonPressed: () {
                    if (kDebugMode) {
                      print("${event["title"]} button pressed");
                    }
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title, VoidCallback onSeeAll) {
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
        TextButton(onPressed: onSeeAll, child: const Text("See All")),
      ],
    );
  }
}
