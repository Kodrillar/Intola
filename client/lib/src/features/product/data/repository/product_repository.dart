import 'dart:convert';

import 'package:http/http.dart';
import 'package:intola/src/features/product/domain/model/product_model.dart';
import 'package:intola/src/features/product/data/network/product_network_helper.dart';
import 'package:intola/src/utils/network/request_response.dart';

class ProductRepository {
  final ProductNetworkHelper _productService = ProductNetworkHelper();

  Future<List<ProductModel>> getProducts({required endpoint}) async {
    try {
      var products = await _productService.getProducts(endpoint: endpoint);

      return products.map<ProductModel>(ProductModel.fromJson).toList();
    } on Response catch (response) {
      var responseBody = RequestResponse.requestResponse(response);

      return jsonDecode(responseBody);
    }
  }
}
