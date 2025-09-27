import 'package:event_tracker/theme/colors.dart';
import 'package:flutter/material.dart';
import '../components/ui_utils.dart';
import '../navigation/app_routes.dart';
import '../models/event_model.dart';

class EventCard extends StatelessWidget {
  final EventModel event;
  final String buttonLabel;
  final VoidCallback? onButtonPressed;
  final bool showDateTime;
  final double? titleSize;
  final double? bodySize;



  const EventCard({
    super.key,
    required this.event,
    required this.buttonLabel,
    this.onButtonPressed,
    this.showDateTime = false,
    this.titleSize,
    this.bodySize,
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
      color: isDark ? kDarkColor : kWhiteColor,
      // clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(
            context,
            Routes.eventDetail,
            arguments: {
              'event': event,
            },
          );
        },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Event Image
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    event.poster,
                    width: 80,
                    height: 80,
                    fit: BoxFit.cover,
                  ),
                ),
              hSpace(12),

              // Details + Button
              Flexible(
                fit: FlexFit.loose,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      event.title,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: titleSize ??  16,
                        color: isDark ? kWhiteColor : kDarkColor,
                      ),
                    ),
                    vSpace(4),
                    Column(
                      children: [
                        Row(
                          children:[
                            Icon(
                            Icons.location_on_outlined,
                            size: 16,
                            color: colorScheme.onSurface.withValues(alpha: 0.7),
                            ),
                            hSpace(4),
                            Expanded(
                              child: Text(
                                event.location,
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  color: colorScheme.onSurface.withValues(alpha: 0.7),
                                  fontSize: bodySize ?? 14,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ]
                        ),
                        if (showDateTime)
                        Row(
                            children:[
                              Icon(
                                Icons.date_range_outlined,
                                size: 16,
                                color: colorScheme.onSurface.withValues(alpha: 0.7),
                              ),
                              hSpace(4),
                              Expanded(
                                child: Text(
                                  event.dateTime,
                                  style: theme.textTheme.bodyMedium?.copyWith(
                                    color: colorScheme.onSurface.withValues(alpha: 0.7),
                                    fontSize: bodySize ?? 14,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ]
                        ),
                      ],
                    ),
                    vSpace(6),

                    if (buttonLabel.isNotEmpty && onButtonPressed != null)
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
                          onPressed: () {
                              Navigator.pushNamed(
                                context,
                                Routes.booking,
                                arguments: event, // EventModel instance
                              );
                          },
                          child: Text(buttonLabel, style: const TextStyle(color: kWhiteColor)),
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
