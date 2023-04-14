import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intola/src/utils/environment/environment.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterwave_standard/flutterwave.dart';
import 'package:intola/src/utils/cache/secure_storage.dart';
import 'package:intola/src/widgets/snack_bar.dart';

class FlutterwavePayment {
  FlutterwavePayment({required this.secureStorage});

  final SecureStorage secureStorage;

  final publicKey = Environment.flPublicKey;

  String _generateReferenceText() {
    // TODO: use uuid to generate unique id
    var randomNum = Random().nextInt(110300);
    if (Platform.isAndroid) {
      return "AndroidRef294$randomNum/393";
    }
    return "IosRef283$randomNum/278";
  }

  void _showSnackBar({
    required BuildContext context,
    required String message,
    IconData? iconData,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      CustomSnackBar(snackBarMessage: message),
    );
  }

  Future<void> processProductPayment({
    required BuildContext context,
    required double amount,
    required Future<void> Function() onPaymentSuccessful,
  }) async {
    final String? user = await secureStorage.read(key: 'userName');
    if (user == null) return;

    try {
      final Customer customer = Customer(
        name: user,
        phoneNumber: "+234566677777",
        email: user,
      );

      final Flutterwave flutterwave = Flutterwave(
        context: context,
        publicKey: publicKey,
        currency: "USD",
        txRef: _generateReferenceText(),
        amount: amount.toString(),
        customer: customer,
        paymentOptions: "ussd, card, barter, payattitude",
        customization: Customization(title: "Test Payment"),
        isTestMode: true,
        redirectUrl: 'https://github.com/Kodrillar',
      );

      final ChargeResponse? response = await flutterwave.charge();
      if (response != null) {
        if (response.success!) {
          _showSnackBar(
            context: context,
            message: "Transaction successful",
            iconData: Icons.verified_rounded,
          );

          await onPaymentSuccessful();
        } else {
          //_showSnackBar(context: context, message: "Transaction Failed!");
        }
      } else {
        // User cancelled transaction
        _showSnackBar(context: context, message: "Transaction Canceled!");
      }
    } catch (ex) {
      _showSnackBar(context: context, message: "Transaction Failed!");
    }
  }
}

final flutterwavePaymentProvider = Provider.autoDispose<FlutterwavePayment>(
    (ref) => FlutterwavePayment(secureStorage: SecureStorage()));
