import 'package:flutter/material.dart';
import 'button.dart';

class CheckoutBottomBar extends StatelessWidget {
  final int totalTickets;
  final double totalPrice;

  const CheckoutBottomBar({
    super.key,
    required this.totalTickets,
    required this.totalPrice,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return SafeArea(
      top: false,
      child: Container(
        height: 80,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: colorScheme.surface,
          border: Border(
            top: BorderSide(color: colorScheme.outline.withValues(alpha:0.2)),
          ),
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '$totalTickets Ticket${totalTickets > 1 ? 's' : ''}',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: colorScheme.onSurface.withValues(alpha:0.7),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '₹${totalPrice.toStringAsFixed(0)}',
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: colorScheme.onSurface,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            elevatedButton(
              minimumSize: const Size(120, 40),
              onPressed: () {
                debugPrint('Proceed to checkout with $totalTickets tickets');
              },
              label: "Checkout",
              backgroundColor: colorScheme.primary,
              textColor: colorScheme.onPrimary,
            ),
          ],
        ),
      ),
    );
  }
}
