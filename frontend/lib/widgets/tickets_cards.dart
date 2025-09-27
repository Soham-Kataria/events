import 'package:event_tracker/widgets/tickets_counter.dart';
import 'package:flutter/material.dart';
import 'add_button.dart';
import '../theme/colors.dart';

class TicketOptionCard extends StatelessWidget {
  final String title;
  final String price;
  final String subtitle;
  final int count;
  final ValueChanged<int> onCountChanged;
  final bool isDynamicCounter;

  const TicketOptionCard({
    super.key,
    required this.title,
    required this.price,
    required this.subtitle,
    required this.count,
    required this.onCountChanged,
    required this.isDynamicCounter,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? kWhiteColor : kDarkColor;
    final secondaryColor = isDark ? Colors.white70 : Colors.black54;
    final borderColor = isDark ? Colors.white24 : Colors.black26;
    final bgColor = isDark ? kDarkColor : kWhiteColor;

    return Container(
      decoration: BoxDecoration(
        color: bgColor,
        border: Border.all(color: borderColor),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: isDark ? Colors.black26 : Colors.grey.withValues(alpha:0.2),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.only(bottom: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Ticket Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: TextStyle(
                        color: textColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 18)),
                const SizedBox(height: 4),
                Text(price,
                    style: TextStyle(
                        color: textColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w600)),
                const SizedBox(height: 4),
                Text(subtitle, style: TextStyle(color: secondaryColor)),
              ],
            ),
          ),

          // Action Button / Counter
          isDynamicCounter && count == 0
              ? AddButton(onPressed: () => onCountChanged(1))
              : TicketCounter(
            count: count,
            onIncrement: () => onCountChanged(count + 1),
            onDecrement: () =>
            count > 0 ? onCountChanged(count - 1) : null,
          ),
        ],
      ),
    );
  }
}
