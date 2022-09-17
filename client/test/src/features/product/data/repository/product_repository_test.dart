import 'package:flutter_test/flutter_test.dart';
import 'package:intola/src/features/product/domain/model/product_model.dart';
import 'package:intola/src/utils/constant.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../../mocks.dart';

void main() {
  final productRepository = MockProductRepository();

  test('getProducts returns array of ProductModel', () async {
    when(() => productRepository.getProducts(endpoint: 'endpoint')).thenAnswer(
      (_) => Future<List<ProductModel>>.value(kProductListReplica),
    );

    final productList =
        await productRepository.getProducts(endpoint: 'endpoint');
    expect(productList, kProductListReplica);
  });
}
