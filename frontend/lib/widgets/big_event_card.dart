import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:event_tracker/theme/colors.dart';
import '../components/ui_utils.dart';
import '../screens/events/controller.dart';
import '../screens/events/events_detail.dart';

class BigEventCard extends StatelessWidget {
  final String title;
  final String genre;
  final String imageUrl;
  final String dateTime;
  final String price;
  final String? location;
  final String? about;
  final List<String>? galleryImages;

  const BigEventCard({
    super.key,
    required this.title,
    required this.genre,
    required this.imageUrl,
    required this.dateTime,
    required this.price,
    this.location,
    this.about,
    this.galleryImages,
  });

  @override
  Widget build(BuildContext context) {
    var isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      color: isDarkMode ? kDarkColor : kWhiteColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: kGrayColor.withValues(alpha: 0.3)),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => EventDetail(
                eventTitle: title,
              ),
            ),
          );
        },
        borderRadius: BorderRadius.circular(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      imageUrl,
                      width: double.infinity,
                      height: 190,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  top: 16,
                  left: 16,
                  child: Chip(
                    label: Text(
                      genre,
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        color: kDarkColor,
                      ),
                    ),
                    backgroundColor: kWhiteColor.withValues(alpha: 0.8),
                  ),
                ),
                Positioned(
                  top: 16,
                  right: 16,
                  child: Consumer<EventController>(
                    builder: (_, eventController, __) {
                      bool isFavourite = eventController.favourites[title] ?? false;
                      return InkWell(
                        onTap: () => eventController.toggleFavourite(title),
                        child: CircleAvatar(
                          backgroundColor: Colors.black45,
                          child: Icon(
                            isFavourite ? Icons.favorite : Icons.favorite_border,
                            color: kWhiteColor,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 1),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: isDarkMode ? kWhiteColor : kDarkColor,
                    ),
                  ),
                  vSpace(6),
                  Text(
                    dateTime,
                    style: TextStyle(
                      fontSize: 14,
                      color: isDarkMode ? kLightColor : kGrayColor,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(right: 2,bottom: 16),
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: isDarkMode
                                ? kWhiteColor.withValues(alpha: 0.8)
                                : kDarkColor.withValues(alpha: 0.6),
                            width: 1.2,
                          ),
                          color: isDarkMode ? kDarkColor : kWhiteColor,
                        ),
                        child: Text(
                          "₹$price",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: isDarkMode ? kSecondaryColor : kPrimaryColor,
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
