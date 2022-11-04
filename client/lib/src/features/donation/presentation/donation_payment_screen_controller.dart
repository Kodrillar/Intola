import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intola/src/features/cart/domain/model/product_item_model.dart';
import 'package:intola/src/features/donation/data/repository/donation_repository.dart';
import 'package:intola/src/features/payment/flutterwave_payment.dart';

class DonationPaymentScreenController extends StateNotifier<AsyncValue<void>> {
  DonationPaymentScreenController(
      {required this.flutterwavePayment, required this.donationRepository})
      : super(const AsyncData(null));

  final FlutterwavePayment flutterwavePayment;
  final DonationRepository donationRepository;

  Future<void> processDonationPayment(
      {required BuildContext context,
      required double amount,
      required ProductItem productItem,
      required Future<void> Function() onDonationComplete}) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => flutterwavePayment.processProductPayment(
        context: context,
        amount: amount,
        onPaymentSuccessful: () => _donateProduct(
          productItem: productItem,
          onDonationComplete: onDonationComplete,
        ),
      ),
    );
  }

  Future<void> _donateProduct({
    required ProductItem productItem,
    required Future<void> Function() onDonationComplete,
  }) async {
    final asyncValue = await AsyncValue.guard(() => donationRepository
        .donateProduct(productItem: productItem)
        .whenComplete(onDonationComplete));
    if (mounted) {
      state = asyncValue;
    }
  }
}

final donationPaymentScreenControllerProvider = StateNotifierProvider
    .autoDispose<DonationPaymentScreenController, AsyncValue>(
  (ref) => DonationPaymentScreenController(
    flutterwavePayment: ref.watch(flutterwavePaymentProvider),
    donationRepository: ref.watch(donationRepositoryProvider),
  ),
);
