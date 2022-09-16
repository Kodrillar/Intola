import 'package:flutter/material.dart';
import 'package:intola/src/features/home/presentation/home_product_grid.dart';
import 'package:intola/src/features/product/domain/model/product_model.dart';
import 'package:intola/src/widgets/error_display.dart';

class ExcitingOfferProductGrid extends StatelessWidget {
  const ExcitingOfferProductGrid({Key? key, required this.getProductsData})
      : super(key: key);

  final Future<List<ProductModel>>? Function(String category) getProductsData;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 450,
      child: FutureBuilder<List<ProductModel>>(
        future: getProductsData("/exciting_offers"),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var data = snapshot.data;
            return HomeProductGrid(data: data!);
          }
          if (snapshot.hasError) {
            return ErrorDisplayWidget(
              errorMessage: snapshot.error.toString(),
            );
          }

          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
