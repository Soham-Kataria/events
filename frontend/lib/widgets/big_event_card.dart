import 'package:flutter/material.dart';
import 'package:event_tracker/theme/colors.dart';

import '../components/ui_utils.dart';

class BigEventCard extends StatefulWidget {
  final String title;
  final String genre;
  final String imageUrl;
  final String dateTime;
  final String price;
  final VoidCallback? onFavouriteToggle;

  const BigEventCard({
    super.key,
    required this.title,
    required this.genre,
    required this.imageUrl,
    required this.dateTime,
    required this.price,
    this.onFavouriteToggle,
  });

  @override
  State<BigEventCard> createState() => _BigEventCardState();
}

class _BigEventCardState extends State<BigEventCard> {
  bool isFavourite = false;

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      color: isDarkMode ? kDarkColor : kWhiteColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: kGrayColor.withValues(alpha:0.3)),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () {
          // TODO: navigate to details page
        },
        borderRadius: BorderRadius.circular(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Image with overlays
            Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0), // even spacing around image
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      widget.imageUrl,
                      width: double.infinity,
                      height: 190,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                // Genre chip
                Positioned(
                  top: 16,
                  left: 16,
                  child: Chip(
                    label: Text(
                      widget.genre,
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        color: kDarkColor,
                      ),
                    ),
                    backgroundColor: kWhiteColor.withValues(alpha:0.8),
                  ),
                ),
                // Favourite button
                Positioned(
                  top: 16,
                  right: 16,
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        isFavourite = !isFavourite;
                      });
                      if (widget.onFavouriteToggle != null) {
                        widget.onFavouriteToggle!();
                      }
                    },
                    child: CircleAvatar(
                      backgroundColor: Colors.black45,
                      child: Icon(
                        isFavourite ? Icons.favorite : Icons.favorite_border,
                        color: kWhiteColor,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            // Event details
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  Text(
                    widget.title,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: isDarkMode ? kWhiteColor : kDarkColor,
                    ),
                  ),
                  vSpace(6),
                  // Date & Time
                  Text(
                    widget.dateTime,
                    style: TextStyle(
                      fontSize: 14,
                      color: isDarkMode ? kLightColor : kGrayColor,
                    ),
                  ),
                  vSpace(12),
                  // Price at bottom-right
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        widget.price,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: kSecondaryColor,
                        ),
                      ),
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
