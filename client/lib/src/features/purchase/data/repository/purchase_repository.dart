import 'dart:convert';
import 'package:http/http.dart';
import 'package:intola/src/features/purchase/domain/model/purchase_history_model.dart';
import 'package:intola/src/features/purchase/data/network/purchase_network_helper.dart';
import 'package:intola/src/utils/network/request_response.dart';

class PurchaseRepository {
  final PurchaseHistoryNetworkHelper _purchaseHistoryService =
      PurchaseHistoryNetworkHelper();

  Future<List<PurchaseHistoryModel>> getPurchaseHistory({
    required endpoint,
    // required email,
    // required image,
    // required name,
  }) async {
    try {
      var getPurchaseHistory =
          await _purchaseHistoryService.getPurchaseHistory(endpoint: endpoint);

      return getPurchaseHistory
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
      var addPurchaseHistory = await _purchaseHistoryService.addPurchaseHistory(
        endpoint: endpoint,
        email: email,
        image: image,
        name: name,
      );
      return addPurchaseHistory;
    } on Response catch (response) {
      var responseBody = RequestResponse.requestResponse(response);
      return jsonDecode(responseBody);
    }
  }
}
