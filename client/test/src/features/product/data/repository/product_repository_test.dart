import 'package:flutter_test/flutter_test.dart';
import 'package:intola/src/features/product/domain/model/product_model.dart';
import 'package:intola/src/utils/constant.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../../mocks.dart';

void main() {
  test('getProducts returns array of ProductModel', () async {
    final productRepository = MockProductRepository();
    when(() => productRepository.getProducts(endpointParam: 'endpointParam'))
        .thenAnswer(
      (_) => Future<List<ProductModel>>.value(kProductListReplica),
    );

    final productList =
        await productRepository.getProducts(endpointParam: 'endpointParam');
    expect(productList, kProductListReplica);
  });
}
