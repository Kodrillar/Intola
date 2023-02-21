import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intola/src/features/cart/data/repository/cart_repository.dart';
import 'package:intola/src/features/purchase/data/network/purchase_network_helper.dart';
import 'package:intola/src/features/purchase/data/repository/purchase_repository.dart';
import 'package:intola/src/utils/cache/secure_storage.dart';

class ShippingService {
  ShippingService(
      {required this.purchaseHistoryRepository, required this.cartRepository});

  final PurchaseHistoryRepository purchaseHistoryRepository;
  final CartRepository cartRepository;

  Future<double?> fetchCartTotalPrice() async {
    return await cartRepository.getTotalPrice();
  }

  Future<void> addProductToPurchaseHistory() async {
    await purchaseHistoryRepository.addPurchaseHistory();
  }
}

final shippingServiceProvider = Provider<ShippingService>((ref) {
  final SecureStorage secureStorage = ref.watch(secureStorageProvider);
  final CartRepository cartRepository =
      CartRepository(secureStorage: secureStorage);
  return ShippingService(
    purchaseHistoryRepository: PurchaseHistoryRepository(
      cartRepository: cartRepository,
      secureStorage: secureStorage,
      purchaseHistoryNetworkHelper:
          PurchaseHistoryNetworkHelper(secureStorage: secureStorage),
    ),
    cartRepository: cartRepository,
  );
});
