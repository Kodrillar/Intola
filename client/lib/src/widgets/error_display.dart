import 'package:flutter/material.dart';
import 'package:intola/src/exceptions/app_exception.dart';

import '../utils/constant.dart';

class ErrorDisplayWidget extends StatelessWidget {
  const ErrorDisplayWidget(
      {Key? key, required this.error, required this.onRetry})
      : super(key: key);
  final void Function() onRetry;
  final Object error;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                child: Icon(
                  Icons.error,
                  color: kDarkBlue.withOpacity(.35),
                  size: 100,
                ),
                height: 150,
              ),
              Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: Text(
                  _errorText(error),
                  style: kErrorTextStyle,
                  textAlign: TextAlign.center,
                ),
              ),
              TextButton(
                onPressed: onRetry,
                child: const Text('Try again'),
              )
            ],
          ),
        ),
      ),
    );
  }

//TODO: Check this method. It might be useless
  String _errorText(Object err) {
    if (err is AppException) {
      return '${err.message} (ErrorCode: ${err.errorCode})';
    }
    return err.toString();
  }
}
