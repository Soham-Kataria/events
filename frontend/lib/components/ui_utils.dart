import 'package:flutter/material.dart';

SizedBox vSpace([double height = 16]) => SizedBox(height: height);
SizedBox hSpace([double width = 16]) => SizedBox(width: width);

InputDecoration inputDecoration({
  required String hint,
  String? label,
  IconData? prefixIcon,
  required BuildContext context,
}) =>
    InputDecoration(
      hintText: hint,
      labelText: label,
      prefixIcon: prefixIcon != null ? Icon(prefixIcon, color: Theme.of(context).iconTheme.color) : null,
      filled: true,
      fillColor: Theme.of(context).colorScheme.surface,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
      ),
    );
