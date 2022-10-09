import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';
import 'package:intola/src/features/product/domain/model/product_model.dart';
import 'package:intola/src/features/purchase/domain/model/purchase_history_model.dart';
import 'package:intola/src/features/purchase/data/network/purchase_network_helper.dart';
import 'package:intola/src/utils/cache/secure_storage.dart';
import 'package:intola/src/utils/network/request_response.dart';

class PurchaseHistoryRepository {
  PurchaseHistoryRepository(
      {required this.purchaseHistoryNetworkHelper,
      required this.secureStorage});

  final PurchaseHistoryNetworkHelper purchaseHistoryNetworkHelper;

  final SecureStorage secureStorage;

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

  Future<void> addPurchaseHistory(
      {required List<ProductModel> products}) async {
    try {
      await purchaseHistoryNetworkHelper.addPurchaseHistory(products: products);
    } on Response catch (response) {
      final responseBody = RequestResponse.requestResponse(response);
      return jsonDecode(responseBody);
    }
  }
}

final purchaseHistoryRepositoryProvider =
    Provider.autoDispose<PurchaseHistoryRepository>(
  (ref) => PurchaseHistoryRepository(
    secureStorage: SecureStorage(),
    purchaseHistoryNetworkHelper: PurchaseHistoryNetworkHelper(
      secureStorage: SecureStorage(),
    ),
  ),
);

final fetchPurchaseHistoryProvider =
    FutureProvider.autoDispose<List<PurchaseHistoryModel>>((ref) {
  final purchaseHistoryRepository =
      ref.watch(purchaseHistoryRepositoryProvider);

  return purchaseHistoryRepository.fetchPurchaseHistory();
});
