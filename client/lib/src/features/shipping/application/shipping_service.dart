import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intola/src/features/cart/data/repository/cart_repository.dart';
import 'package:intola/src/features/payment/flutterwave_payment.dart';
import 'package:intola/src/features/purchase/data/network/purchase_network_helper.dart';
import 'package:intola/src/features/purchase/data/repository/purchase_repository.dart';
import 'package:intola/src/utils/cache/secure_storage.dart';

class ShippingService extends StateNotifier<AsyncValue<void>> {
  ShippingService({
    required this.flutterwavePayment,
    required this.purchaseHistoryRepository,
    required this.cartRepository,
  }) : super(const AsyncData(null));

  final FlutterwavePayment flutterwavePayment;
  final PurchaseHistoryRepository purchaseHistoryRepository;
  final CartRepository cartRepository;

  Future<void> processProductPayment({
    required BuildContext context,
    required Future<void> Function() onPurchaseComplete,
  }) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final totalCartPrice = await cartRepository.getTotalPrice();
      return flutterwavePayment.processProductPayment(
        context: context,
        amount: totalCartPrice!,
        onPaymentSuccessful: () =>
            _addPurchaseHistory(onPurchaseComplete: onPurchaseComplete),
      );
    });
  }

  Future<void> _addPurchaseHistory({
    required Future<void> Function() onPurchaseComplete,
  }) async {
    final asyncValue = await AsyncValue.guard(() => purchaseHistoryRepository
        .addPurchaseHistory()
        .whenComplete(onPurchaseComplete));
    if (mounted) {
      state = asyncValue;
    }
  }
}

final shippingServiceProvider =
    StateNotifierProvider<ShippingService, AsyncValue>((ref) {
  final SecureStorage secureStorage = SecureStorage();
  final CartRepository cartRepository =
      CartRepository(secureStorage: secureStorage);
  return ShippingService(
    flutterwavePayment: FlutterwavePayment(secureStorage: secureStorage),
    purchaseHistoryRepository: PurchaseHistoryRepository(
      cartRepository: cartRepository,
      secureStorage: secureStorage,
      purchaseHistoryNetworkHelper:
          PurchaseHistoryNetworkHelper(secureStorage: secureStorage),
    ),
    cartRepository: cartRepository,
  );
});
