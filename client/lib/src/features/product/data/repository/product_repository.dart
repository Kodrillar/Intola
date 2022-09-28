import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intola/src/features/product/domain/model/product_model.dart';
import 'package:intola/src/features/product/data/network/product_network_helper.dart';
import 'package:intola/src/utils/cache/secure_storage.dart';

class ProductRepository {
  ProductRepository({required this.productNetworkHelper});
  final ProductNetworkHelper productNetworkHelper;

  Future<List<ProductModel>> getProducts({required String endpoint}) async {
    var products = await productNetworkHelper.getProducts(endpoint: endpoint);

    return products.map<ProductModel>(ProductModel.fromJson).toList();
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

 // try {

 // } on Response catch (response) {
    //   var responseBody = RequestResponse.requestResponse(response);

    //   return jsonDecode(responseBody);
    // }