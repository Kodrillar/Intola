import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intola/src/widgets/alert_dialog.dart';

extension AsyncValueDisplayX on AsyncValue {
  showErrorAlertDialog(BuildContext context) {
    if (!isRefreshing && hasError) {
      showAlertDialog(
        context: context,
        title: 'Error',
        content: error.toString(),
      );
    }
  }
}
