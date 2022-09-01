import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intola/src/features/product/data/repository/product_repository.dart';
import 'package:intola/src/features/product/presentation/product_carousel_slider.dart';
import 'package:intola/src/utils/network/api.dart';
import 'package:intola/src/widgets/error_display.dart';

class TopDealsCarousel extends StatelessWidget {
  const TopDealsCarousel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final productValue =
            ref.watch(getProductsProvider(endpoints["getProducts"]! + '/top'));
        return productValue.when(
          data: (data) => CustomCarouselSlider.getCarouselSlider(
            carouselItems: data,
          ),
          error: (error, stackTrace) => const ErrorDisplayWidget(),
          loading: () => const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
