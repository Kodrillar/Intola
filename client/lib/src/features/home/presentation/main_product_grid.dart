import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intola/src/features/home/home_controller.dart';
import 'package:intola/src/features/home/presentation/home_product_grid.dart';
import 'package:intola/src/features/product/data/repository/product_repository.dart';
import 'package:intola/src/utils/network/api.dart';
import 'package:intola/src/utils/product_filter_options.dart';
import 'package:intola/src/widgets/error_display.dart';

class MainProductGrid extends StatelessWidget {
  const MainProductGrid({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: ((_, ref, child) {
        final productCategoryTextValue =
            ref.watch(homeScreenControllerProvider);
        final endpoint = Endpoints.fetchProducts +
            ProductFilterOptions.getCategoryFilter(productCategoryTextValue);
        final productValue = ref.watch(getProductsProvider(endpoint));
        return SizedBox(
          height: 450,
          child: productValue.when(
            data: (data) => HomeProductGrid(data: data),
            error: (error, stackTrace) => ErrorDisplayWidget(
              errorMessage: error.toString(),
            ),
            loading: () => const Center(
              child: CircularProgressIndicator(),
            ),
          ),
        );
      }),
    );
  }
}
