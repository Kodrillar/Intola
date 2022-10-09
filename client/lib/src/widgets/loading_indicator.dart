import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intola/src/utils/constant.dart';
import 'package:intola/src/widgets/annotated_region.dart';

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SystemUIOverlayAnnotatedRegion(
      systemUiOverlayStyle: SystemUiOverlayStyle.light,
      child: Scaffold(
        backgroundColor: kDarkBlue,
        body: Center(
          child: Text(
            'please wait...',
            style: TextStyle(
              color: kDarkOrange,
              fontWeight: FontWeight.w800,
              fontSize: 25,
            ),
          ),
        ),
      ),
    );
  }
}
