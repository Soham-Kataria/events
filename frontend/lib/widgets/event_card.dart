import 'package:event_tracker/theme/colors.dart';
import 'package:flutter/material.dart';
import '../components/ui_utils.dart';
import '../screens/events/events_detail.dart';

class EventCard extends StatelessWidget {
  final String title;
  final String location;
  final String imageUrl;
  final String buttonLabel;
  final VoidCallback? onButtonPressed;

  // Optional extra details for navigation
  final String? genre;
  final String? dateTime;
  final String? about;
  final List<String>? gallery;

  const EventCard({
    super.key,
    required this.title,
    required this.location,
    required this.imageUrl,
    required this.buttonLabel,
    this.onButtonPressed,
    this.genre,
    this.dateTime,
    this.about,
    this.gallery,
  });

  void _navigateToDetails(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => EventDetail(
          eventTitle: title, // Only this parameter is required
        ),
      ),
    );

  }

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
      color: isDark ? kDarkColor : kWhiteColor,
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => _navigateToDetails(context),
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Event Image
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

              // Details + Button
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
                          color: colorScheme.onSurface.withValues(alpha: 0.7),
                        ),
                        hSpace(4),
                        Expanded(
                          child: Text(
                            location,
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: colorScheme.onSurface.withValues(alpha: 0.7),
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    vSpace(6),

                    Align(
                      alignment: Alignment.bottomRight,
                      child: SizedBox(
                        width: 120,
                        height: 36,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            padding: EdgeInsets.zero,
                          ),
                          onPressed: () => _navigateToDetails(context),
                          child: Text(buttonLabel,style: TextStyle(color: kWhiteColor),),
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
