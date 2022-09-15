import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Future<void> showAlertDialog({
  required BuildContext context,
  required String title,
  required String content,
}) {
  return Platform.isAndroid
      ? showDialog(
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
        )
      : showCupertinoDialog(
          context: context,
          builder: (BuildContext context) => Material(
            color: Colors.transparent,
            child: CupertinoAlertDialog(
              title: Text(title),
              content: Text(content),
              actions: [
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close),
                )
              ],
            ),
          ),
        );
}
