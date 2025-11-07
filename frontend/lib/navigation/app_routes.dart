// lib/navigation/app_routes.dart
import 'package:flutter/material.dart';
import '../dummy/dummy_data.dart';
import '../screens/booking/booking.dart';
import '../screens/booking/order.dart';
import '../screens/home/home.dart';
import '../screens/events/event_list.dart';
import '../screens/events/events_detail.dart';
import '../screens/home/mainscreen.dart';
import '../screens/Profile/profile.dart';
import '../screens/Favourites/favourite.dart';
import '../screens/tickets/tickets.dart';
import '../screens/auth/login.dart';
import '../screens/auth/register.dart';
import '../models/event_model.dart';

class Routes {
  static const home = '/';
  static const mainScreen = '/mainScreen';
  static const eventList = '/eventList';
  static const eventDetail = '/eventDetail';
  static const profile = '/profile';
  static const favourites = '/favourites';
  static const tickets = '/tickets';
  static const login = '/login';
  static const register = '/register';
  static const booking = '/booking';
  static const order = '/order';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return MaterialPageRoute(builder: (_) => HomeScreen());
      case mainScreen:
        return MaterialPageRoute(builder: (_) => MainScreen());
      case eventList:
        return MaterialPageRoute(builder: (_) => EventListScreen());
      case eventDetail:
        final args = settings.arguments as Map<String, dynamic>;
        final EventModel event = args['event'];
        return MaterialPageRoute(
          builder: (_) => EventDetail(event: event),
        );
      case profile:
        return MaterialPageRoute(builder: (_) => ProfileScreen());
      case favourites:
        return MaterialPageRoute(builder: (_) => FavouriteScreen());
      case tickets:
        return MaterialPageRoute(builder: (_) => TicketScreen());
      case login:
        return MaterialPageRoute(builder: (_) => Login());
      case register:
        return MaterialPageRoute(builder: (_) => Register());
      case booking:
        final event = settings.arguments as EventModel;

        // Filter tickets for this event
        final eventTickets = allTickets
            .where((t) => t.eventId == event.id) // use event.title if you don't have id yet
            .toList();

        return MaterialPageRoute(
          builder: (_) => BookingScreen(
            event: event,
            tickets: eventTickets,
          ),
        );

      case order:
        return MaterialPageRoute(
          builder: (_) => OrderPage(),
        );

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}
