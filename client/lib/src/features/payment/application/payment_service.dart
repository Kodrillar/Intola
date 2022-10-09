import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterwave_standard/flutterwave.dart';
import 'package:intola/src/features/cart/data/repository/cart_repository.dart';
import 'package:intola/src/features/cart/domain/model/product_item_model.dart';
import 'package:intola/src/features/payment/presentation/payment_view.dart';
import 'package:intola/src/features/product/domain/model/product_model.dart';
import 'package:intola/src/routing/route.dart';
import 'package:intola/src/utils/cache/secure_storage.dart';
import 'package:intola/src/widgets/snack_bar.dart';

import '../../purchase/data/repository/purchase_repository.dart';

class PaymentService extends StateNotifier<AsyncValue> {
  PaymentService({
    required this.purchaseHistoryRepository,
    required this.secureStorage,
    required this.cartRepository,
  }) : super(const AsyncData(null));

  final PurchaseHistoryRepository purchaseHistoryRepository;
  final CartRepository cartRepository;

  final SecureStorage secureStorage;

  static const publicKey = "FLWPUBK_TEST-29a3cd01a75a67bdb3ac35c87e1da9f3-X";

  String generateReferenceText() {
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

  Future<void> _addPurchaseHistory() async {
    state = const AsyncLoading();
    Map<String, ProductItem>? shoppingCart = await cartRepository.fetchCart();

    if (shoppingCart == null) return;

    List<ProductModel> cartProducts = [];

    for (var entry in shoppingCart.entries) {
      cartProducts.add(entry.value.productModel);
    }
    final asyncValue = await AsyncValue.guard(() =>
        purchaseHistoryRepository.addPurchaseHistory(products: cartProducts));
    if (mounted) {
      state = asyncValue;
    }
  }

  Future<void> processProductPayment(BuildContext context) async {
    final user = await secureStorage.read(key: 'userName');
    final amount = await cartRepository.getTotalPrice();

    if (user == null || amount == null) return;
    try {
      final style = PaymentView();
      final Customer customer = Customer(
        name: user,
        phoneNumber: "+234566677777",
        email: user,
      );

      final Flutterwave flutterwave = Flutterwave(
        context: context,
        style: style,
        publicKey: publicKey,
        currency: "USD",
        txRef: generateReferenceText(),
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
          //Add to user purchases
          _addPurchaseHistory().whenComplete(() async {
            //Clear user cart
            await secureStorage.delete(key: 'cart');
            Navigator.pushNamedAndRemoveUntil(
                context, RouteName.homeScreen.name, (route) => false);
          });
        } else {
          //_showSnackBar(context: context, message: "Transaction Failed!");
        }
      } else {
        // User cancelled transaction
        _showSnackBar(context: context, message: "Transaction Canceled!");
      }
    } catch (_) {
      _showSnackBar(context: context, message: "Transaction Failed!");
    }
  }
}

final paymentServiceProvider =
    StateNotifierProvider.autoDispose<PaymentService, AsyncValue>((ref) {
  final purchaseHistoryRepository =
      ref.watch(purchaseHistoryRepositoryProvider);
  final cartRepository = ref.watch(cartRepositoryProvider);
  return PaymentService(
    purchaseHistoryRepository: purchaseHistoryRepository,
    cartRepository: cartRepository,
    secureStorage: SecureStorage(),
  );
});
