// lib/navigation/navigation_helper.dart
import 'package:flutter/material.dart';
import 'app_routes.dart';
import '../models/event_model.dart';

class NavigationHelper {
  static void goToEventDetail(BuildContext context, EventModel event) {
    Navigator.pushNamed(
      context,
      Routes.eventDetail,
      arguments: {'event': event},
    );
  }

  static void goBack(BuildContext context) {
    Navigator.pop(context);
  }

  static void goToHomeAndClearStack(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(context, Routes.home, (route) => false);
  }

  static void navigateTo(
      BuildContext context,
      String routeName, {
        Map<String, dynamic>? arguments,
        bool clearStack = false,
      }) {
    if (clearStack) {
      Navigator.pushNamedAndRemoveUntil(
        context,
        routeName,
            (route) => false,
        arguments: arguments,
      );
    } else {
      Navigator.pushNamed(
        context,
        routeName,
        arguments: arguments,
      );
    }
  }
}
