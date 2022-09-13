import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intola/src/utils/constant.dart';
import 'package:intola/src/widgets/annotated_region.dart';

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SystemUIOverlayAnnotatedRegion(
      systemUiOverlayStyle: SystemUiOverlayStyle.light,
      child: Container(
        color: kDarkBlue,
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
