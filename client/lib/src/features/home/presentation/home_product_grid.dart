import 'package:flutter/material.dart';
import 'package:intola/src/features/product/domain/model/product_model.dart';
import 'package:intola/src/features/product/presentation/product_card.dart';

class HomeProductGrid extends StatelessWidget {
  const HomeProductGrid({Key? key, required this.data}) : super(key: key);

  final List<ProductModel> data;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: GridView.builder(
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        itemCount: data.length,
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: MediaQuery.of(context).size.width / 2,
          mainAxisExtent: 215,
          mainAxisSpacing: 15.0,
          crossAxisSpacing: 0.0,
        ),
        itemBuilder: (context, index) => ProductCard(
          productName: data[index].name,
          productImage: data[index].image,
          productDescription: data[index].description,
          productPrice: data[index].price,
          productSlashprice: data[index].slashprice,
        ),
      ),
    );
  }
}
