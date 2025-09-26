import 'package:flutter/material.dart';

const kDarkGray = Color(0xFF202020); // slightly darker grey for text, hint, and icons

Widget customTextFormField({
  required TextEditingController controller,
  required String hintText,
  String? labelText,
  IconData? icon,
  String? Function(String?)? validator,
  bool isPassword = false,
  TextInputType keyboardType = TextInputType.text,
}) {
  return TextFormField(
    controller: controller,
    obscureText: isPassword,
    keyboardType: keyboardType,
    textAlign: TextAlign.start,
    style: const TextStyle(color: kDarkGray),
    decoration: InputDecoration(
      hintText: hintText,
      hintStyle: const TextStyle(color: kDarkGray),
      labelText: labelText,
      labelStyle: const TextStyle(color: kDarkGray),
      prefixIcon: icon != null ? Icon(icon, color: kDarkGray) : null,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      filled: true,
      fillColor: Colors.white,
    ),
    validator: validator,
  );
}

Widget customTextField(
{
required
TextEditingController
controller,
String? label,
String? hintText,
Widget? prefixIcon,
Widget? suffixIcon,
bool isPassword = false,
TextInputType keyboardType = TextInputType.text,
}){
  return TextField(
    controller: controller,
    obscureText: isPassword,
    textAlign: TextAlign.start,
    keyboardType: keyboardType,
    style: TextStyle(color: kDarkGray),
    decoration: InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(color: kDarkGray),
      hintText: hintText ?? 'Enter your $label',
      hintStyle: const TextStyle(color: kDarkGray),
      prefixIcon: prefixIcon != null ? IconTheme(data: IconThemeData(color: kDarkGray), child: prefixIcon) : null,
      suffixIcon: suffixIcon != null ? IconTheme(data: IconThemeData(color: kDarkGray), child: suffixIcon) : null,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      filled: true,
      fillColor: Colors.white,

    ),
  );
}

Widget customPasswordFormField({
  required TextEditingController controller,
  String? label,
  String? hintText,
  required bool obscureText,
  required VoidCallback onToggleVisibility,
  String? Function(String?)? validator,
}) {
  return TextFormField(
    controller: controller,
    obscureText: obscureText,
    style: const TextStyle(color: kDarkGray),
    decoration: InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(color: kDarkGray),
      hintText: hintText ?? 'Enter your password',
      hintStyle: const TextStyle(color: kDarkGray),
      prefixIcon: const Icon(Icons.lock_outlined, color: kDarkGray),
      suffixIcon: IconButton(
        icon: Icon(
          obscureText ? Icons.visibility_off_outlined : Icons.visibility_outlined,
          color: kDarkGray,
        ),
        onPressed: onToggleVisibility,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      filled: true,
      fillColor: Colors.white,
    ),
    textAlign: TextAlign.start,
    validator: validator,
  );
}
