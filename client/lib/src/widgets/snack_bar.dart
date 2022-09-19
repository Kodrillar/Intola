import 'package:flutter/material.dart';
import 'package:intola/src/utils/constant.dart';

SnackBar customSnackBar({required String snackBarMessage, IconData? iconData}) {
  return SnackBar(
    content: Row(
      children: [
        Icon(iconData ?? Icons.error, color: kDarkOrange),
        const SizedBox(width: 5),
        Text(snackBarMessage, style: kSnackBarTextStyle),
      ],
    ),
    backgroundColor: kDarkBlue,
  );
}
