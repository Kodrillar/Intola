import 'package:flutter/material.dart';
import 'package:intola/src/features/home/data/repository/home_repository.dart';
import 'package:intola/src/features/home/presentation/home_product_grid.dart';
import 'package:intola/src/features/product/domain/model/product_model.dart';
import 'package:intola/src/utils/product_filter_options.dart';
import 'package:intola/src/widgets/error_display.dart';

class MainProductGrid extends StatelessWidget {
  const MainProductGrid({Key? key, required this.getProductsData})
      : super(key: key);

  final Future<List<ProductModel>>? Function(String category) getProductsData;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: dropdownValueNotifier,
      builder: ((_, value, child) => SizedBox(
            height: 450,
            child: FutureBuilder<List<ProductModel>>(
              future: getProductsData(
                ProductFilterOptions.categoryFilter(value.toString()),
              ),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  var data = snapshot.data;
                  return HomeProductGrid(data: data!);
                }
                if (snapshot.hasError) {
                  return const ErrorDisplayWidget();
                }

                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          )),
    );
  }
}
