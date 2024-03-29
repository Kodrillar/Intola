import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intola/src/utils/constant.dart';

class CustomAlertDialog {
  static Future<void> showAlertDialog({
    required BuildContext context,
    required String title,
    required String content,
  }) {
    return showDialog(
      context: context,
      builder: Platform.isAndroid
          ? (BuildContext context) => AlertDialog(
                title: Text(title,
                    style: kAppBarTextStyle.copyWith(
                        fontSize: 15, color: kDarkOrange)),
                content: Text(
                  content,
                  style: kProductDetailStyle.copyWith(color: kDarkBlue),
                ),
                actions: [
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.close),
                  )
                ],
              )
          : (BuildContext context) => Material(
                color: Colors.transparent,
                child: CupertinoAlertDialog(
                  title: Text(title,
                      style: kAppBarTextStyle.copyWith(
                          fontSize: 15, color: kDarkOrange)),
                  content: Text(
                    content,
                    style: kProductDetailStyle.copyWith(color: kDarkBlue),
                  ),
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

  static Future<bool> showConfirmationAlertDialog(
      {required BuildContext context,
      required String title,
      required String content,
      Widget? falseConfirmationWidget,
      Widget? truthyConfirmationWidget}) async {
    return await showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => Platform.isAndroid
          ? AlertDialog(
              title: Text(
                title,
                style:
                    kAppBarTextStyle.copyWith(fontSize: 15, color: kDarkOrange),
              ),
              content: Text(
                content,
                style: kProductDetailStyle.copyWith(color: kDarkBlue),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context, false);
                  },
                  child: falseConfirmationWidget ?? const Text('no'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context, true);
                  },
                  child: truthyConfirmationWidget ?? const Text('yes'),
                ),
              ],
            )
          : CupertinoAlertDialog(
              title: Text(
                title,
                style: kAppBarTextStyle.copyWith(
                  fontSize: 15,
                  color: kDarkOrange,
                ),
              ),
              content: Text(
                content,
                style: kProductDetailStyle.copyWith(color: kDarkBlue),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context, false);
                  },
                  child: falseConfirmationWidget ?? const Text('no'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context, true);
                  },
                  child: truthyConfirmationWidget ?? const Text('yes'),
                ),
              ],
            ),
    );
  }
}
