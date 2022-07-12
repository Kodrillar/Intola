import 'dart:convert';

import 'package:http/http.dart';
import 'package:intola/src/models/purchaseHistoryModel.dart';
import 'package:intola/src/services/purchase/purchaseService.dart';
import 'package:intola/src/utils/requestResponse.dart';

class PurchaseRepository {
  PurchaseHistoryService _purchaseHistoryService = PurchaseHistoryService();

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
