import 'package:event_tracker/components/ui_utils.dart';
import 'package:event_tracker/theme/colors.dart';
import 'package:event_tracker/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'controller.dart';

class EventDetail extends StatelessWidget {
  final String eventTitle;

  const EventDetail({super.key, required this.eventTitle});

  void _showAddressBottomSheet(BuildContext context, String location) {
    var theme = Theme.of(context);
    var isDark = theme.brightness == Brightness.dark;

    showModalBottomSheet(
      context: context,
      backgroundColor: isDark ? kDarkColor : kWhiteColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Venue',
                style: theme.textTheme.titleMedium
                    ?.copyWith(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              vSpace(8),
              Text(location, style: theme.textTheme.bodyMedium),
              vSpace(8),
              Align(
                alignment: Alignment.centerRight,
                child: Icon(Icons.keyboard_arrow_down,
                    color: isDark ? kWhiteColor : kDarkColor),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var event = Provider.of<EventController>(context);
    var theme = Theme.of(context);
    var isDark = theme.brightness == Brightness.dark;

    var fetchEvent = event.events.firstWhere(
          (e) => e["title"] == eventTitle,
      orElse: () => {},
    );

    if (fetchEvent.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: const Text("Event Not Found")),
        body: const Center(child: Text("Event data not available.")),
      );
    }

// Safe access with defaults
    var title = fetchEvent["title"] ?? "No Title";
    var genre = fetchEvent["genre"] ?? "Unknown Genre";
    var dateTime = fetchEvent["dateTime"] ?? "Unknown Date";
    var location = fetchEvent["location"] ?? "Unknown Location";
    var posterUrl = fetchEvent["detailPoster"] ?? fetchEvent["poster"]!;
    var about = fetchEvent["about"] ?? "No description available.";
    var galleryImages = List<String>.from(fetchEvent["gallery"] ?? []);
    var price = fetchEvent["price"]?.toString() ?? "TBA";

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: CircleAvatar(
            radius: 16, // same size as favorite/share buttons
            backgroundColor:  Colors.black45,
            child: IconButton(
              icon: Icon(Icons.arrow_back, color: isDark ? kWhiteColor : kDarkColor),
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ),
        actions: [
          Row(
            children: [
              Consumer<EventController>(
                builder: (context, event, child) {
                  bool isFav = event.favourites[title] ?? false;
                  return CircleAvatar(
                    backgroundColor: Colors.black45,
                    child: IconButton(
                      icon: Icon(
                        isFav ? Icons.favorite : Icons.favorite_border,
                        color: kWhiteColor,
                      ),
                      onPressed: () => event.toggleFavourite(title),
                    ),
                  );
                },
              ),
              hSpace(8),
              CircleAvatar(
                backgroundColor: Colors.black45,
                child: IconButton(
                  icon: const Icon(Icons.share, color: kWhiteColor),
                  onPressed: () {},
                ),
              ),
              hSpace(8),
            ],
          ),
        ],
      ),
      body: Stack(
        children: [
          // Background image
          if (posterUrl.isNotEmpty)
            SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: Image.network(
                posterUrl,
                fit: BoxFit.cover,
              ),
            ),
          // Draggable content
          DraggableScrollableSheet(
            initialChildSize: 0.4,
            minChildSize: 0.35,
            maxChildSize: 0.9,
            builder: (context, scrollController) {
              return Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: isDark ? kDarkColor : kWhiteColor,
                  borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(20)),
                ),
                child: SingleChildScrollView(
                  controller: scrollController,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Chip(
                        label: Text(
                          genre,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: isDark ? kWhiteColor : kDarkColor,
                          ),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
                        visualDensity: VisualDensity.compact,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        backgroundColor: isDark ? kGrayColor : kWhiteColor,
                      ),
                      vSpace(8),
                      Text(
                        title,
                        style: theme.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                          color: isDark ? kWhiteColor : kDarkColor,
                        ),
                      ),
                      vSpace(12),
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              shape: BoxShape.rectangle,
                              color: isDark ? kGrayColor : kWhiteColor,
                            ),
                            child: Icon(
                              Icons.calendar_month,
                              size: 28,
                              color: isDark ? kWhiteColor : kDarkColor,
                            ),
                          ),
                          hSpace(8),
                          Text(dateTime,style: theme.textTheme.bodyMedium?.copyWith(fontSize: 16, color: isDark ? kWhiteColor : kDarkColor)),
                        ],
                      ),
                      vSpace(8),
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              shape: BoxShape.rectangle,
                              color: isDark ? kGrayColor : kWhiteColor,
                            ),
                            child: Icon(
                              Icons.location_on,
                              size: 28,
                              color: isDark ? kWhiteColor : kDarkColor,
                            ),
                          ),
                          hSpace(8),
                          Expanded(child: Text(location)),
                          IconButton(
                            icon: const Icon(Icons.chevron_right, color: Colors.grey),
                            onPressed: () =>
                                _showAddressBottomSheet(context, location),
                          ),
                        ],
                      ),
                      vSpace(16),
                      Text(
                        'About the Event',
                        style: theme.textTheme.titleMedium
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      vSpace(8),
                      Text(about),
                      if (about.length > 100)
                        TextButton(onPressed: () {}, child: const Text('Read more')),
                      vSpace(16),
                      Text(
                        'Gallery',
                        style: theme.textTheme.titleMedium
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      vSpace(8),
                      SizedBox(
                        height: 120,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemCount: galleryImages.length,
                          separatorBuilder: (_, __) => hSpace(8),
                          itemBuilder: (context, index) {
                            return Container(
                              width: 150,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                image: DecorationImage(
                                  image: galleryImages.isNotEmpty
                                      ? NetworkImage(galleryImages[index])
                                      : const AssetImage(
                                      "assets/placeholder.png")
                                  as ImageProvider,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      vSpace(16),
                    ],
                  ),
                ),
              );
            },
          ),
          // Floating booking bar overlapping sheet
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                color: Theme.of(context).brightness == Brightness.dark
                    ? kDarkColor
                    : Theme.of(context).bottomSheetTheme.backgroundColor ?? kLightColor,
                border: Border(
                  top: BorderSide(color: Colors.grey.withValues(alpha:0.2)),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "₹$price ",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: isDark ? kWhiteColor : kDarkColor,
                          ),
                        ),
                        TextSpan(
                          text: "onwards",
                          style: TextStyle(
                            fontSize: 18,
                            color: isDark ? kWhiteColor : kDarkColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  elevatedButton(
                    minimumSize: const Size(120, 40),
                    onPressed: () {
                      //  Navigate to booking page
                      event.navigateToBookingPage(context, fetchEvent);
                    },
                    label: "Book Now",
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
