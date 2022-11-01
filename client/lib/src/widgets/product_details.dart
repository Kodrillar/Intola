import 'package:flutter/material.dart';
import 'package:intola/src/utils/constant.dart';

class ProductDetails extends StatelessWidget {
  const ProductDetails({
    Key? key,
    required this.productDescription,
    required this.productName,
    required this.productPrice,
  }) : super(key: key);
  final String productName;
  final String productPrice;
  final String productDescription;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                productName,
                style: kProductNameStyle,
              ),
              Text(
                "\$$productPrice",
                style: kProductNameStyle,
              ),
            ],
          ),
          const SizedBox(height: 20),
          Text(
            productDescription,
            style: kProductDetailStyle,
          )
        ],
      ),
    );
  }
}
