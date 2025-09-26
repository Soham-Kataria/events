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
        color: textColor ?? kButtonTextColor,
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
}) {
  return OutlinedButton.icon(
    onPressed: onPressed,
    icon: icon ?? const SizedBox.shrink(),
    label: Text(
      label,
      style: TextStyle(fontSize: fontSize),
    ),
    style: OutlinedButton.styleFrom(
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,
      minimumSize: minimumSize ?? Size(fontSize * 10, fontSize * 3),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius),
      ),
    ),
  );
}
