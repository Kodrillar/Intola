import 'dart:convert';

import 'package:http/http.dart';
import 'package:intola/src/models/product_model.dart';
import 'package:intola/src/services/product/product_service.dart';
import 'package:intola/src/utils/request_response.dart';

class ProductRepository {
  final ProductService _productService = ProductService();

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
