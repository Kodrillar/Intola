import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intola/src/utils/constant.dart';

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Container(
        color: kDarkBlue,
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
