import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
import '../../models/ticket_model.dart';
import '../../models/event_model.dart';


class BookingController with ChangeNotifier {
  EventModel? event; // The event being booked
  List<TicketModel> tickets = [];

  // Selected ticket quantities
  Map<String, int> selectedTickets = {};

  BookingController({  this.event,  this.tickets = const []}) {
    // Initialize selectedTickets with 0 for each ticket type
    for (var ticket in tickets) {
      selectedTickets[ticket.ticketType] = 0;
    }
  }

  // Increase quantity of a ticket
  void incrementTicket(String ticketType) {
    if (selectedTickets[ticketType]! < tickets
        .firstWhere((t) => t.ticketType == ticketType)
        .ticketsAvail) {
      selectedTickets[ticketType] = selectedTickets[ticketType]! + 1;
      notifyListeners();
    }
  }

  // Decrease quantity of a ticket
  void decrementTicket(String ticketType) {
    if (selectedTickets[ticketType]! > 0) {
      selectedTickets[ticketType] = selectedTickets[ticketType]! - 1;
      notifyListeners();
    }
  }

  // Get total price
  double get totalPrice {
    double total = 0;
    for (var ticket in tickets) {
      final qty = selectedTickets[ticket.ticketType] ?? 0;
      total += qty * ticket.ticketPrice;
    }
    return total;
  }

  // Get total tickets selected
  int get totalTicketsSelected {
    return selectedTickets.values.fold(0, (sum, qty) => sum + qty);
  }

  // Book tickets (this will connect to backend later)
  /// Book a ticket: reduce available tickets, increase sold tickets, assign userId
  void bookTicket(TicketModel ticket, {String userId = "user1"}) {
    if (ticket.ticketsAvail <= 0) return;

    ticket.ticketsAvail -= 1;
    ticket.ticketsSold += 1;
    ticket.userId = userId;

    notifyListeners();
  }

  /// Check if a ticket is already booked by this user
  bool isBooked(TicketModel ticket, {String userId = "user1"}) {
    return ticket.userId == userId;
  }

  /// Get all tickets for the current event
  List<TicketModel> getEventTickets() {
    if (event == null) return [];
    return tickets.where((t) => t.eventId == event!.id).toList();
  }
}
