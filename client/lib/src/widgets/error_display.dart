import 'package:flutter/material.dart';

import '../utils/constant.dart';

class ErrorDisplayWidget extends StatelessWidget {
  const ErrorDisplayWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
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
        const Text(
          "Oops! No products found \nfor this category.",
          style: kAppBarTextStyle,
        )
      ],
    );
  }
}
