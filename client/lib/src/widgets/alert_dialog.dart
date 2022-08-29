import 'package:flutter/material.dart';

Future<void> alertDialog(
    {required BuildContext context, required title, required content}) {
  return showDialog(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: [
        IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.close),
        )
      ],
    ),
  );
}
