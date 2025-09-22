import 'package:flutter/material.dart';

Widget customTextFormField({
  required TextEditingController controller,
  required String hintText,
  String? labelText,
  IconData ? icon,
  String? Function(String?)? validator,
  bool isPassword = false,
  TextInputType keyboardType = TextInputType.text,
}){
  return TextFormField(
    controller: controller,
    obscureText: isPassword,
    keyboardType: keyboardType,
    textAlign: TextAlign.start,
    decoration: InputDecoration(
      hintText: hintText,
      hintStyle: const TextStyle(color: Colors.grey),
      labelText: labelText,
      prefixIcon: icon != null ? Icon(icon) : null,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      filled: true,
      fillColor: Colors.white,
    ),
    validator: validator,
  );
}

Widget customTextField({
  required TextEditingController controller,
  required String label,
  required IconData icon,
  String? hintText,
  bool isPassword = false,
  TextInputType keyboardType = TextInputType.text,
}) {
  return TextField(
    controller: controller,
    obscureText: isPassword,
    textAlign: TextAlign.start,
    keyboardType: keyboardType,
    decoration: InputDecoration(
      labelText: label,
      hintText: hintText ?? 'Enter your $label',
      hintStyle: const TextStyle(color: Colors.grey),
      prefixIcon: icon != null ? Icon(icon) : null,
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
    decoration: InputDecoration(
      labelText: label,
      hintText: hintText ?? 'Enter your password',
      hintStyle: const TextStyle(color: Colors.grey),
      prefixIcon: const Icon(Icons.lock_outlined),
      suffixIcon: IconButton(
        icon: Icon(
          obscureText ? Icons.visibility_off_outlined : Icons.visibility_outlined,
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
