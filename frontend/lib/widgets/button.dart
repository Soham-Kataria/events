import 'package:event_tracker/widgets/text_field.dart';
import 'package:flutter/material.dart';
import '../theme/colors.dart';

Widget elevatedButton({
  required String label,
  required Function() onPressed,
  Color? backgroundColor,
  Color? textColor,
  borderRadius = 50.0,
  Size? minimumSize,
  double fontSize = 20,
}) => ElevatedButton(
    onPressed: onPressed,
    style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor ??  kButtonBackgroundColor,
      minimumSize: minimumSize ?? Size(fontSize*6, fontSize*2.5),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius),
      ),
    ),
    child: Text(
      label,
      style: TextStyle(
        color: kWhiteColor,
        fontSize: fontSize,
      ),
    ),
);

Widget outlinedButton({
  required String label,
  required Function() onPressed,
  Widget? icon,
  double fontSize = 16,
  double borderRadius = 50.0,
  Size? minimumSize,
  ButtonStyle? style,
  bool forceWhite = false, // new flag
}) {
  return Builder(
    builder: (context) {
      final isDark = Theme.of(context).brightness == Brightness.dark;

      // Decide colors based on theme or forceWhite
      final bgColor = forceWhite ? Colors.white : (isDark ? kDarkGray : kWhiteColor);
      final textColor = forceWhite ? Colors.black : (isDark ? kWhiteColor : Theme.of(context).colorScheme.primary);

      return OutlinedButton.icon(
        onPressed: onPressed,
        icon: icon ?? const SizedBox.shrink(),
        label: Text(
          label,
          style: TextStyle(
            fontSize: fontSize,
            color: textColor,
          ),
        ),
        style: OutlinedButton.styleFrom(
          backgroundColor: bgColor,
          foregroundColor: textColor,
          minimumSize: minimumSize ?? Size(fontSize * 10, fontSize * 3),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          side: BorderSide(color: textColor, width: 1.5),
        ),
      );
    },
  );
}