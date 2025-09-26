import 'package:event_tracker/screens/auth/controller.dart';
import 'package:event_tracker/screens/booking/backup_controller.dart';
import 'package:event_tracker/screens/events/controller.dart';
import 'package:event_tracker/screens/home/controller.dart';
import 'package:event_tracker/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/auth/login.dart';

void main() {
  runApp(
      MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (context) => AuthController()),
            ChangeNotifierProvider(create: (context) => HomeController()),
            ChangeNotifierProvider(create: (context) => EventController()),
            ChangeNotifierProvider(create: (context) => BookingController(ticketTypes: [])),
          ],
          child: const MyApp())
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Event Tracker',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      home: const Login(),
    );
  }
}
