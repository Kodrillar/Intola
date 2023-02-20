import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intola/src/features/home/presentation/home_controller.dart';
import 'package:intola/src/features/home/presentation/home_product_grid.dart';
import 'package:intola/src/widgets/error_display.dart';

class MainProductGrid extends StatelessWidget {
  const MainProductGrid({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: ((_, ref, child) {
        final state = ref.watch(homeScreenControllerProvider);
        return SizedBox(
          child: state.productGridAsyncValue.when(
            data: (data) => HomeProductGrid(data: data),
            error: (error, stackTrace) => ErrorDisplayWidget(
              error: error,
              onRetry: () => ref
                  .read(homeScreenControllerProvider.notifier)
                  .updateProductGridOnReload(),
            ),
            loading: () => const Center(
              child: CircularProgressIndicator.adaptive(),
            ),
          ),
        );
      }),
    );
  }
}
