import 'dart:convert';

import 'package:http/http.dart';
import 'package:intola/src/models/product_Model.dart';
import 'package:intola/src/services/product/productService.dart';
import 'package:intola/src/utils/requestResponse.dart';

class ProductRepository {
  ProductService _productService = ProductService();

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
