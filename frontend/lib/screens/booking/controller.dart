import 'package:flutter/foundation.dart';
import '../../models/ticket_model.dart';
import '../../models/event_model.dart';

enum PaymentMethod { card, netBanking, upi }

class BookingController with ChangeNotifier {
  EventModel? event; // The event being booked
  List<TicketModel> tickets = [];

  // Getters
  EventModel? get selectedEvent => event;
  List<String> get ticketTypes => tickets.map((t) => t.ticketType).toList();

  // Selected ticket quantities
  Map<String, int> selectedTickets = {};

  // Payment
  PaymentMethod? selectedPaymentMethod;

  BookingController({this.event, this.tickets = const []}) {
    // Initialize selectedTickets with 0 for each ticket type
    for (var ticket in tickets) {
      selectedTickets[ticket.ticketType] = 0;
    }
  }

  // ---------------- Ticket Selection ----------------

  void incrementTicket(String ticketType) {
    if (selectedTickets[ticketType]! < tickets
        .firstWhere((t) => t.ticketType == ticketType)
        .ticketsAvail) {
      selectedTickets[ticketType] = selectedTickets[ticketType]! + 1;
      notifyListeners();
    }
  }

  void decrementTicket(String ticketType) {
    if (selectedTickets[ticketType]! > 0) {
      selectedTickets[ticketType] = selectedTickets[ticketType]! - 1;
      notifyListeners();
    }
  }

  int get totalTicketsSelected =>
      selectedTickets.values.fold(0, (sum, qty) => sum + qty);

  double get totalPrice {
    double total = 0;
    for (var ticket in tickets) {
      final qty = selectedTickets[ticket.ticketType] ?? 0;
      total += qty * ticket.ticketPrice;
    }
    return total;
  }

  // ---------------- Order Summary ----------------

  double get subtotal => totalPrice;

  double get tax => subtotal * 0.1; // 10% tax example

  double get platformFee => subtotal * 0.05; // 5% platform fee

  double get total => subtotal + tax + platformFee;

  bool get hasTicketsSelected =>
      selectedTickets.values.any((qty) => qty > 0);

  void resetOrder() {
    selectedTickets.updateAll((key, value) => 0);
    selectedPaymentMethod = null;
    notifyListeners();
  }

  // ---------------- Payment ----------------

  void selectPaymentMethod(PaymentMethod method) {
    selectedPaymentMethod = method;
    notifyListeners();
  }

  // ---------------- Booking ----------------

  void bookTicket(TicketModel ticket, {String userId = "user1"}) {
    if (ticket.ticketsAvail <= 0) return;

    ticket.ticketsAvail -= 1;
    ticket.ticketsSold += 1;
    ticket.userId = userId;

    notifyListeners();
  }

  bool isBooked(TicketModel ticket, {String userId = "user1"}) {
    return ticket.userId == userId;
  }

  List<TicketModel> getEventTickets() {
    if (event == null) return [];
    return tickets.where((t) => t.eventId == event!.id).toList();
  }

  // ---------------- Place Order ----------------

  Future<bool> placeOrder({required String userId}) async {
    if (!hasTicketsSelected || selectedPaymentMethod == null) return false;

    final orders = tickets
        .where((t) => selectedTickets[t.ticketType]! > 0)
        .map((ticket) => {
      "ticketId": ticket.id,
      "quantity": selectedTickets[ticket.ticketType],
      "price": ticket.ticketPrice,
    })
        .toList();

    final payload = {
      "userId": userId,
      "eventId": event!.id,
      "tickets": orders,
      "paymentMethod": selectedPaymentMethod.toString().split('.').last,
      "totalPrice": total,
    };

    // TODO: call backend API to place order
    // final response = await api.post("/orders", payload);
    // return response.isSuccess;

    return true; // temporary for UI
  }
}
