import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intola/src/exceptions/app_exception.dart';
import 'package:intola/src/features/product/domain/model/product_model.dart';
import 'package:intola/src/features/product/data/network/product_network_helper.dart';
import 'package:intola/src/utils/cache/secure_storage.dart';

class ProductRepository {
  ProductRepository({required this.productNetworkHelper});
  final ProductNetworkHelper productNetworkHelper;

  Future<List<ProductModel>> getProducts({
    required String endpointParam,
  }) async {
    try {
      var products =
          await productNetworkHelper.getProducts(endpointParam: endpointParam);

      return products.map<ProductModel>(ProductModel.fromJson).toList();
    } on SocketException catch (ex) {
      throw AppException.dissabledNetworkException(ex.customMessage);
    } on FormatException catch (ex) {
      throw AppException.clientException(ex.customMessage);
    } catch (ex) {
      rethrow;
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
  (ref, endpointParam) {
    final productRepository = ref.read(productRepositoryProvider);
    return productRepository.getProducts(endpointParam: endpointParam);
  },
);

final cartProductQuantityProvider = StateProvider.autoDispose<int>((ref) => 1);
