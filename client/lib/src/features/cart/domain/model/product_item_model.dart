import 'dart:convert';

import 'package:intola/src/features/product/domain/model/product_model.dart';

class ProductItem {
  ProductItem({
    required this.productModel,
    required this.productQuantity,
  });
  ProductModel productModel;
  int productQuantity;

  double get productPrice => double.parse(productModel.price) * productQuantity;

  @override
  String toString() {
    return 'ProductItem(productModel: $productModel, productQuantity: $productQuantity, productPrice:$productPrice)';
  }

  factory ProductItem.fromJson(jsonData) {
    final productJsonData = jsonDecode(jsonData['productModel']);
    return ProductItem(
      productModel: ProductModel.fromJson(productJsonData),
      productQuantity: jsonData['productQuantity'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'productModel': productModel,
      'productQuantity': productQuantity,
    };
  }

  String toJson() => jsonEncode(toMap());
}
