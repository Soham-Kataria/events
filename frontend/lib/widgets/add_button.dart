import 'package:flutter/material.dart';
import 'package:event_tracker/widgets/button.dart';

class AddButton extends StatelessWidget {
  final VoidCallback onPressed;

  const AddButton({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return outlinedButton(
      onPressed: onPressed,
      label: 'Add',
      minimumSize: const Size(100, 45),
      borderRadius: 10,
      fontSize: 16,
    );
  }
}
