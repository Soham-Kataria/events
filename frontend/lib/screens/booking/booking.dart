import 'package:flutter/material.dart';
import '../../models/event_model.dart';
import '../../models/ticket_model.dart';
import '../../widgets/bottom_bar.dart';
import '../../widgets/tickets_cards.dart';


class BookingScreen extends StatefulWidget {
  final EventModel event;
  final List<TicketModel> tickets;

  const BookingScreen({
    super.key,
    required this.event,
    required this.tickets,
  });

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  final Map<String, int> _selectedCounts = {};

  @override
  void initState() {
    super.initState();
    for (var t in widget.tickets) {
      _selectedCounts[t.ticketType] = 0;
    }
  }

  int get _totalTickets =>
      _selectedCounts.values.fold(0, (sum, qty) => sum + qty);

  double get _totalPrice {
    double total = 0;
    for (var t in widget.tickets) {
      total += (_selectedCounts[t.ticketType] ?? 0) * t.ticketPrice;
    }
    return total;
  }

  void _updateCount(String ticketType, int newCount) {
    setState(() {
      _selectedCounts[ticketType] = newCount;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.event.title),
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: widget.tickets.map((ticket) {
            final count = _selectedCounts[ticket.ticketType] ?? 0;
            return Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: TicketOptionCard(
                title: ticket.ticketType,
                price: "₹${ticket.ticketPrice.toStringAsFixed(0)}",
                subtitle: "Entry for 1 person",
                count: count,
                onCountChanged: (newCount) =>
                    _updateCount(ticket.ticketType, newCount),
                isDynamicCounter: true,
              ),
            );
          }).toList(),
        ),
      ),
      bottomNavigationBar: _totalTickets > 0
          ? CheckoutBottomBar(
        totalTickets: _totalTickets,
        totalPrice: _totalPrice,
      )
          : null,
    );
  }
}
