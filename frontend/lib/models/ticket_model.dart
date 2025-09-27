// models/ticket_model.dart
class TicketModel {
  final String? id; // Optional, from backend (_id)
   String? userId;
  final String? eventId;
  final double ticketPrice;
  final int totalTickets;
  int ticketsAvail;
  int ticketsSold;
  final String ticketType; // VIP / General
  final bool isFree;
  final DateTime? bookingStartLine;
  final DateTime? bookingDeadLine;
  final String status; // active / inactive / cancelled
  final bool isUsed;

  TicketModel({
    this.id,
    this.userId,
    this.eventId,
    this.ticketPrice = 0,
    this.totalTickets = 1,
    this.ticketsAvail = 0,
    this.ticketsSold = 0,
    this.ticketType = "General",
    this.isFree = false,
    this.bookingStartLine,
    this.bookingDeadLine,
    this.status = "active",
    this.isUsed = false,
  });

  // Factory constructor to create a TicketModel from JSON
  factory TicketModel.fromJson(Map<String, dynamic> json) {
    return TicketModel(
      id: json['_id'] as String?,
      userId: json['userId'] as String?,
      eventId: json['eventId'] as String?,
      ticketPrice: (json['ticketPrice'] ?? 0).toDouble(),
      totalTickets: json['totalTickets'] ?? 1,
      ticketsAvail: json['ticketsAvail'] ?? 0,
      ticketsSold: json['ticketsSold'] ?? 0,
      ticketType: json['ticketType'] ?? "General",
      isFree: json['isFree'] ?? false,
      bookingStartLine: json['bookingStartLine'] != null
          ? DateTime.parse(json['bookingStartLine'])
          : null,
      bookingDeadLine: json['bookingDeadLine'] != null
          ? DateTime.parse(json['bookingDeadLine'])
          : null,
      status: json['status'] ?? "active",
      isUsed: json['isUsed'] ?? false,
    );
  }

  // Convert TicketModel to JSON for backend requests
  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'userId': userId,
      'eventId': eventId,
      'ticketPrice': ticketPrice,
      'totalTickets': totalTickets,
      'ticketsAvail': ticketsAvail,
      'ticketsSold': ticketsSold,
      'ticketType': ticketType,
      'isFree': isFree,
      'bookingStartLine':
      bookingStartLine?.toIso8601String(),
      'bookingDeadLine':
      bookingDeadLine?.toIso8601String(),
      'status': status,
      'isUsed': isUsed,
    };
  }
}
