import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';
import 'package:intola/src/features/cart/data/repository/cart_repository.dart';
import 'package:intola/src/features/cart/domain/model/product_item_model.dart';
import 'package:intola/src/features/product/domain/model/product_model.dart';
import 'package:intola/src/features/purchase/domain/model/purchase_history_model.dart';
import 'package:intola/src/features/purchase/data/network/purchase_network_helper.dart';
import 'package:intola/src/utils/cache/secure_storage.dart';
import 'package:intola/src/utils/network/request_response.dart';

class PurchaseHistoryRepository {
  PurchaseHistoryRepository(
      {required this.purchaseHistoryNetworkHelper,
      required this.cartRepository,
      required this.secureStorage});

  final PurchaseHistoryNetworkHelper purchaseHistoryNetworkHelper;

  final SecureStorage secureStorage;
  final CartRepository cartRepository;

  Future<List<PurchaseHistoryModel>> fetchPurchaseHistory() async {
    try {
      final purchaseHistoryData =
          await purchaseHistoryNetworkHelper.fetchPurchaseHistory();

      final List<Map> purchasedProductList = [];

      //TODO: improve time complexity
      for (var purchase in purchaseHistoryData) {
        for (var product in purchase['products']) {
          purchasedProductList.add({
            'id': purchase['id'],
            'name': product['name'],
            'image': product['image'],
            'status': product['status'],
            'date': purchase['created_at']
          });
        }
      }

      return purchasedProductList
          .map<PurchaseHistoryModel>(PurchaseHistoryModel.fromJson)
          .toList();
    } on Response catch (response) {
      final responseBody = RequestResponse.requestResponse(response);
      return jsonDecode(responseBody);
    }
  }

  Future<void> addPurchaseHistory() async {
    try {
      Map<String, ProductItem>? shoppingCart = await cartRepository.fetchCart();

      if (shoppingCart == null) return;

      List<ProductModel> cartProducts = [];

      for (var entry in shoppingCart.entries) {
        cartProducts.add(entry.value.productModel);
      }
      //add purchases to db
      await purchaseHistoryNetworkHelper.addPurchaseHistory(
        products: cartProducts,
      );

      //clear cart after purchases
      await secureStorage.delete(key: 'cart');
    } on Response catch (response) {
      final responseBody = RequestResponse.requestResponse(response);
      return jsonDecode(responseBody);
    }
  }
}

final purchaseHistoryRepositoryProvider =
    Provider.autoDispose<PurchaseHistoryRepository>((ref) {
  final SecureStorage secureStorage = SecureStorage();

  return PurchaseHistoryRepository(
    secureStorage: secureStorage,
    cartRepository: CartRepository(secureStorage: secureStorage),
    purchaseHistoryNetworkHelper: PurchaseHistoryNetworkHelper(
      secureStorage: secureStorage,
    ),
  );
});

final fetchPurchaseHistoryProvider =
    FutureProvider.autoDispose<List<PurchaseHistoryModel>>((ref) {
  final purchaseHistoryRepository =
      ref.watch(purchaseHistoryRepositoryProvider);

  return purchaseHistoryRepository.fetchPurchaseHistory();
});
