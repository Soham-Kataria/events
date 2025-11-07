import 'package:event_tracker/theme/colors.dart';
import 'package:flutter/material.dart';
import '../../components/ui_utils.dart';
import '../../widgets/bottom_bar.dart';
import '../../models/event_model.dart';
import '../../widgets/event_card.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({super.key});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  String? selectedPayment = 'upi'; // Default selected option

  @override
  Widget build(BuildContext context) {
    // Hardcoded event & ticket data for UI demo
    final event = EventModel(
      id: '1',
      title: 'Music Concert',
      location: 'City Arena',
      dateTime: '2025-10-05 7:00 PM',
      poster: 'https://picsum.photos/400/200?11',
      genre: '',
      detailPoster: '',
      gallery: [],
      about: '',
      price: 500,
      type: '',
    );

    final selectedTickets = {'VIP': 2, 'General': 3};
    final ticketPrices = {'VIP': 2000.0, 'General': 500.0};

    // Calculate totals
    double subtotal = 0;
    selectedTickets.forEach((type, qty) {
      subtotal += (ticketPrices[type] ?? 0) * qty;
    });
    const tax = 50.0;
    const platformFee = 30.0;
    final total = subtotal + tax + platformFee;
    final totalTickets = selectedTickets.values.fold(0, (a, b) => a + b);

    var theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    var colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Order Summary"),
        centerTitle: true,
        elevation: 0,
        backgroundColor: colorScheme.surface,
        foregroundColor: colorScheme.onSurface,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // 🔹 Event Card
            EventCard(
              event: event,
              buttonLabel: '',
              showDateTime: true,
              titleSize: 16,
              bodySize: 14,
            ),
            vSpace(10),

            // 🔹 Order Summary Container
            Material(
              elevation: 2,
              borderRadius: BorderRadius.circular(12),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: isDark ? kDarkColor : kWhiteColor,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                      color: isDark ? kGrayColor : kLightColor, width: 1),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Order Summary",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: isDark ? kWhiteColor : kDarkColor,
                      ),
                    ),
                    vSpace(10),
                    const Divider(),

                    // 🔸 Ticket Details
                    ...selectedTickets.entries.map((entry) {
                      final type = entry.key;
                      final qty = entry.value;
                      final price = (ticketPrices[type] ?? 0) * qty;
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "$type ×$qty",
                              style: TextStyle(
                                color:
                                isDark ? Colors.white : Colors.black87,
                              ),
                            ),
                            Text(
                              "₹${price.toStringAsFixed(0)}",
                              style: TextStyle(
                                color:
                                isDark ? Colors.white : Colors.black87,
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                    const Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Tax",
                            style: TextStyle(
                                color: isDark
                                    ? Colors.white
                                    : Colors.black87)),
                        Text("₹${tax.toStringAsFixed(0)}",
                            style: TextStyle(
                                color: isDark
                                    ? Colors.white
                                    : Colors.black87)),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Platform Fee",
                            style: TextStyle(
                                color: isDark
                                    ? Colors.white
                                    : Colors.black87)),
                        Text("₹${platformFee.toStringAsFixed(0)}",
                            style: TextStyle(
                                color: isDark
                                    ? Colors.white
                                    : Colors.black87)),
                      ],
                    ),
                    const Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Total",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color:
                            isDark ? Colors.white : Colors.black87,
                          ),
                        ),
                        Text(
                          "₹${total.toStringAsFixed(0)}",
                          style: const TextStyle(
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            vSpace(16),

            // 🔹 Payment Options Section
            // 🔹 Payment Options Section (Compatible & Clean)
            Material(
              elevation: 2,
              borderRadius: BorderRadius.circular(12),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: isDark ? kDarkColor : kWhiteColor,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: isDark ? kGrayColor : kLightColor,
                    width: 1,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Select Payment Method",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: isDark ? kWhiteColor : kDarkColor,
                      ),
                    ),
                    const SizedBox(height: 8),

                    // UPI option
                    ListTile(
                      leading: Radio<String>(
                        value: 'upi',
                        groupValue: selectedPayment,
                        onChanged: (value) {
                          setState(() => selectedPayment = value!);
                        },
                      ),
                      title: const Text("UPI"),
                      subtitle: const Text("Pay using Google Pay, PhonePe, etc."),
                    ),

                    // Card option
                    ListTile(
                      leading: Radio<String>(
                        value: 'card',
                        groupValue: selectedPayment,
                        onChanged: (value) {
                          setState(() => selectedPayment = value!);
                        },
                      ),
                      title: const Text("Credit / Debit Card"),
                      subtitle: const Text("Visa, MasterCard, Rupay"),
                    ),

                    // Cash option
                    ListTile(
                      leading: Radio<String>(
                        value: 'cash',
                        groupValue: selectedPayment,
                        onChanged: (value) {
                          setState(() => selectedPayment = value!);
                        },
                      ),
                      title: const Text("Cash On Event"),
                      subtitle: const Text("Pay at the venue"),
                    ),
                  ],
                ),
              ),
            ),

          ],
        ),
      ),

      // 🔹 Bottom Bar
      bottomNavigationBar: CheckoutBottomBar(
        totalTickets: totalTickets,
        totalPrice: total,
        onCheckout: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Payment Method: $selectedPayment'),
            ),
          );
        },
      ),
    );
  }
}
