import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';
import 'package:intola/src/features/purchase/domain/model/purchase_history_model.dart';
import 'package:intola/src/features/purchase/data/network/purchase_network_helper.dart';
import 'package:intola/src/utils/cache/secure_storage.dart';
import 'package:intola/src/utils/network/request_response.dart';

class PurchaseHistoryRepository {
  PurchaseHistoryRepository({required this.purchaseHistoryNetworkHelper});

  final PurchaseHistoryNetworkHelper purchaseHistoryNetworkHelper;

  Future<List<PurchaseHistoryModel>> fetchPurchaseHistory() async {
    try {
      var purchaseHistoryData =
          await purchaseHistoryNetworkHelper.fetchPurchaseHistory();

      return purchaseHistoryData
          .map<PurchaseHistoryModel>(PurchaseHistoryModel.fromJson)
          .toList();
    } on Response catch (response) {
      var responseBody = RequestResponse.requestResponse(response);
      return jsonDecode(responseBody);
    }
  }

  Future<dynamic> addPurchaseHistory({
    required endpoint,
    required email,
    required image,
    required name,
  }) async {
    try {
      var purchaseHistoryResponse =
          await purchaseHistoryNetworkHelper.addPurchaseHistory(
        purchaseHistoryModel: PurchaseHistoryModel(
          email: email,
          image: image,
          name: name,
        ),
      );
      return purchaseHistoryResponse;
    } on Response catch (response) {
      var responseBody = RequestResponse.requestResponse(response);
      return jsonDecode(responseBody);
    }
  }
}

final purchaseHistoryRepositoryProvider =
    Provider.autoDispose<PurchaseHistoryRepository>(
  (ref) => PurchaseHistoryRepository(
    purchaseHistoryNetworkHelper:
        PurchaseHistoryNetworkHelper(secureStorage: SecureStorage()),
  ),
);

final fetchPurchaseHistoryProvider =
    FutureProvider.autoDispose<List<PurchaseHistoryModel>>((ref) {
  final purchaseHistoryRepository =
      ref.watch(purchaseHistoryRepositoryProvider);

  return purchaseHistoryRepository.fetchPurchaseHistory();
});
