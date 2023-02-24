import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intola/src/features/payment/flutterwave_payment.dart';
import 'package:intola/src/features/shipping/application/shipping_service.dart';

class ShippingInfoScreenController extends StateNotifier<AsyncValue> {
  ShippingInfoScreenController({
    required this.shippingService,
    required this.flutterwavePayment,
  }) : super(const AsyncData(null));

  ShippingService shippingService;
  FlutterwavePayment flutterwavePayment;

  Future<void> processProductPayment({
    required BuildContext context,
    required Future<void> Function() onPurchaseComplete,
  }) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final totalCartPrice = await shippingService.fetchCartTotalPrice();
      return flutterwavePayment.processProductPayment(
        context: context,
        //TODO: Verify that this can't be null at this point!
        amount: totalCartPrice!,
        onPaymentSuccessful: () =>
            _addPurchaseHistory(onPurchaseComplete: onPurchaseComplete),
      );
    });
  }

  Future<void> _addPurchaseHistory({
    required Future<void> Function() onPurchaseComplete,
  }) async {
    final asyncValue = await AsyncValue.guard(
      () => shippingService
          .addProductToPurchaseHistory()
          .whenComplete(onPurchaseComplete),
    );
    if (mounted) {
      state = asyncValue;
    }
  }
}

final shippingInfoScreenControllerProvider =
    StateNotifierProvider.autoDispose<ShippingInfoScreenController, AsyncValue>(
        (ref) {
  final shippingService = ref.watch(shippingServiceProvider);
  final flutterwavePayment = ref.watch(flutterwavePaymentProvider);
  return ShippingInfoScreenController(
      shippingService: shippingService, flutterwavePayment: flutterwavePayment);
});
