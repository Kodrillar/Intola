import 'package:flutter/material.dart';
import 'package:intola/src/utils/constant.dart';

class CustomSnackBar extends SnackBar {
  CustomSnackBar({
    Key? key,
    required this.snackBarMessage,
    this.iconData = Icons.error,
  }) : super(
          key: key,
          content: Row(
            children: [
              Icon(iconData, color: kDarkOrange),
              const SizedBox(width: 5),
              Text(snackBarMessage, style: kSnackBarTextStyle),
            ],
          ),
          backgroundColor: kDarkBlue,
        );

  final String snackBarMessage;
  final IconData? iconData;
}
