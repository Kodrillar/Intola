import 'package:flutter/material.dart';

import '../utils/constant.dart';

class ErrorDisplayWidget extends StatelessWidget {
  const ErrorDisplayWidget({Key? key, required this.errorMessage})
      : super(key: key);

  final String errorMessage;

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
                  errorMessage,
                  style: kErrorTextStyle,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
