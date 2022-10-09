import 'package:flutter/material.dart';
import 'package:flutterwave_standard/flutterwave.dart';

import '../../../utils/constant.dart';

class PaymentView extends FlutterwaveStyle {
  PaymentView()
      : super(
          appBarText: "Secured by Flutterwave",
          buttonColor: kDarkOrange,
          appBarTitleTextStyle: kAppBarTextStyle.copyWith(color: Colors.white),
          appBarIcon: const Icon(Icons.arrow_back_ios, color: kDarkOrange),
          buttonTextStyle:
              kAppBarTextStyle.copyWith(fontSize: 18, color: kDarkBlue),
          appBarColor: kDarkBlue,
          dialogCancelTextStyle: const TextStyle(
            color: kDarkOrange,
            fontSize: 18,
          ),
          dialogContinueTextStyle: const TextStyle(
            color: kDarkBlue,
            fontSize: 18,
          ),
        );
}
