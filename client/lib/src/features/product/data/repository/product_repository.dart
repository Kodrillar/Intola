import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intola/src/features/product/domain/model/product_model.dart';
import 'package:intola/src/features/product/data/network/product_network_helper.dart';

class ProductRepository {
  final ProductNetworkHelper _productService = ProductNetworkHelper();

  Future<List<ProductModel>> getProducts({required String endpoint}) async {
    // try {
    var products = await _productService.getProducts(endpoint: endpoint);

    return products.map<ProductModel>(ProductModel.fromJson).toList();
    // } on Response catch (response) {
    //   var responseBody = RequestResponse.requestResponse(response);

    //   return jsonDecode(responseBody);
    // }
  }
}

final productRepositoryProvider =
    Provider.autoDispose<ProductRepository>((ref) => ProductRepository());

final getProductsProvider =
    FutureProvider.autoDispose.family<List<ProductModel>, String>(
  (ref, endpoint) {
    final productRepository = ref.read(productRepositoryProvider);
    return productRepository.getProducts(endpoint: endpoint);
  },
);
