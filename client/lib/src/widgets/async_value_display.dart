import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intola/src/exceptions/app_exception.dart';
import 'package:intola/src/widgets/alert_dialog.dart';

extension AsyncValueDisplayX on AsyncValue {
  showErrorAlertDialog(BuildContext context) {
    if (!isRefreshing && hasError) {
      CustomAlertDialog.showAlertDialog(
        context: context,
        title: 'Error',
        content: error is AppException
            ? '${(error as AppException).message} (ErrorCode:${(error as AppException).errorCode})'
            : error.toString(),
      );
    }
  }
}
