import 'dart:convert';

import 'package:intola/src/features/product/domain/model/product_model.dart';

class ProductItem {
  ProductItem({
    required this.productModel,
    required this.cartProductQuantity,
  });
  ProductModel productModel;
  int cartProductQuantity;

  double get productPrice =>
      (double.parse(productModel.price) * cartProductQuantity).roundToDouble();

  @override
  String toString() {
    return 'ProductItem(productModel: $productModel, productQuantity: $cartProductQuantity, productPrice:$productPrice)';
  }

  factory ProductItem.fromJson(jsonData) {
    final productJsonData = jsonDecode(jsonData['productModel']);
    return ProductItem(
      productModel: ProductModel.fromJson(productJsonData),
      cartProductQuantity: jsonData['productQuantity'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'productModel': productModel,
      'productQuantity': cartProductQuantity,
    };
  }

  String toJson() => jsonEncode(toMap());
}
