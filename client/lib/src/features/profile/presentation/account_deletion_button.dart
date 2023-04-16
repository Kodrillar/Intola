import 'package:flutter/material.dart';

class AccounDeletionButton extends StatelessWidget {
  const AccounDeletionButton({super.key, required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: onPressed,
      icon: const Icon(Icons.delete),
      label: const Text('Delete account'),
      style: ButtonStyle(
        foregroundColor: const MaterialStatePropertyAll(Colors.red),
        overlayColor: MaterialStatePropertyAll(
          Colors.red.withOpacity(.1),
        ),
      ),
    );
  }
}
