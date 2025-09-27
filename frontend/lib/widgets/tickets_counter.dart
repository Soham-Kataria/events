import 'package:flutter/material.dart';

class TicketCounter extends StatelessWidget {
  final int count;
  final VoidCallback onIncrement;
  final VoidCallback? onDecrement;

  const TicketCounter({
    super.key,
    required this.count,
    required this.onIncrement,
    this.onDecrement,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgColor = isDark ? Colors.grey[850] : Colors.grey[200];
    final iconColor = isDark ? Colors.white : Colors.black;

    return Container(
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: Icon(Icons.remove, color: iconColor),
            onPressed: onDecrement,
            padding: EdgeInsets.zero,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text(
              '$count',
              style: TextStyle(
                color: iconColor,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.add, color: iconColor),
            onPressed: onIncrement,
            padding: EdgeInsets.zero,
          ),
        ],
      ),
    );
  }
}
