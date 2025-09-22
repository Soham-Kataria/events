import 'package:event_tracker/theme/colors.dart';
import 'package:flutter/material.dart';

import '../components/ui_utils.dart';

class EventCard extends StatelessWidget {
  final String title;
  final String location;
  final String imageUrl;
  final String buttonLabel;
  final VoidCallback onButtonPressed;

  const EventCard({
    super.key,
    required this.title,
    required this.location,
    required this.imageUrl,
    required this.buttonLabel,
    required this.onButtonPressed,
  });

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var colorScheme = theme.colorScheme;
    var isDark = theme.brightness == Brightness.dark;

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: isDark ? kGrayColor : kLightColor, width: 1),
      ),
      color: isDark ? kDarkColor : kWhiteColor, // adapts to light/dark
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () {
          // TODO: navigate to details page
        },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(12), // even spacing around image
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Event Image with even padding inside card
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  padding: const EdgeInsets.all(4),
                  color: isDark ? kDarkBackgroundColor : kLightBackgroundColor,
                  child: Image.network(
                    imageUrl,
                    width: 80,
                    height: 80,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              hSpace(12),

              // Title + Location + Button
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      title,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: isDark ? kWhiteColor : kDarkColor,
                      ),
                    ),
                    vSpace(2),
                    Row(
                      children: [
                        Icon(
                          Icons.location_on_outlined,
                          size: 16,
                          color: colorScheme.onSurface.withValues(alpha:0.7),
                        ),
                        hSpace(4),
                        Expanded(
                          child: Text(
                            location,
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: colorScheme.onSurface.withValues(alpha:0.7),
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    vSpace(6),

                    // Button bottom-right
                    Align(
                      alignment: Alignment.bottomRight,
                      child: SizedBox(
                        width: 120, // half-width style button
                        height: 36,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            padding: EdgeInsets.zero,
                          ),
                          onPressed: onButtonPressed,
                          child: Text(buttonLabel),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
