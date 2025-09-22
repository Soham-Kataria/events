import 'package:flutter/material.dart';

/// A reusable label text widget for forms and pages.
///
/// [text] - the label string to display.
/// [textTheme] - the TextTheme from the current theme, used for styling.
class LabelText extends StatelessWidget {
  final String text;
  final TextTheme textTheme;

  const LabelText({
    super.key,
    required this.text,
    required this.textTheme,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.left,
      style: textTheme.titleMedium?.copyWith(fontSize: 18),
    );
  }
}
