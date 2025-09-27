class OrderModel {
  final String? id; // backend _id
  final String userId;
  final String eventId;
  final String? ticketId;
  final int quantity;
  final bool isScanned;
  final String? qrCode;
  final String status;
  final double totalPrice;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  OrderModel({
    this.id,
    required this.userId,
    required this.eventId,
    this.ticketId,
    required this.quantity,
    this.isScanned = false,
    this.qrCode,
    this.status = 'Pending',
    required this.totalPrice,
    this.createdAt,
    this.updatedAt,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['_id'] ?? json['id'],
      userId: json['userId'] ?? '',
      eventId: json['eventId'] ?? '',
      ticketId: json['ticketId'],
      quantity: json['quantity'] ?? 0,
      isScanned: json['isScanned'] ?? false,
      qrCode: json['qrCode'],
      status: json['status'] ?? 'Pending',
      totalPrice: (json['totalPrice'] ?? 0).toDouble(),
      createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'eventId': eventId,
      'ticketId': ticketId,
      'quantity': quantity,
      'isScanned': isScanned,
      'qrCode': qrCode,
      'status': status,
      'totalPrice': totalPrice,
    };
  }
}
