import 'dart:convert';
import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';
import 'package:intola/src/exceptions/app_exceptions.dart';
import 'package:intola/src/features/product/domain/model/product_model.dart';
import 'package:intola/src/features/product/data/network/product_network_helper.dart';
import 'package:intola/src/utils/cache/secure_storage.dart';
import 'package:intola/src/utils/network/request_response.dart';

class ProductRepository {
  ProductRepository({required this.productNetworkHelper});
  final ProductNetworkHelper productNetworkHelper;

  Future<List<ProductModel>> getProducts({required String endpoint}) async {
    try {
      var products = await productNetworkHelper.getProducts(endpoint: endpoint);

      return products.map<ProductModel>(ProductModel.fromJson).toList();
    } on SocketException {
      throw DissabledNetworkException();
    } on Response catch (response) {
      var responseBody = RequestResponse.requestResponse(response);

      return jsonDecode(responseBody);
    }
  }
}

final productRepositoryProvider = Provider.autoDispose<ProductRepository>(
  (ref) => ProductRepository(
      productNetworkHelper:
          ProductNetworkHelper(secureStorage: SecureStorage())),
);

final getProductsProvider =
    FutureProvider.autoDispose.family<List<ProductModel>, String>(
  (ref, endpoint) {
    final productRepository = ref.read(productRepositoryProvider);
    return productRepository.getProducts(endpoint: endpoint);
  },
);

final cartProductQuantityProvider = StateProvider.autoDispose<int>((ref) => 1);
