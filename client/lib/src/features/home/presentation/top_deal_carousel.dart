import 'package:flutter/material.dart';
import 'package:intola/src/features/product/domain/model/product_model.dart';
import 'package:intola/src/features/product/presentation/product_carousel_slider.dart';

class TopDealsCarousel extends StatelessWidget {
  const TopDealsCarousel({Key? key, required this.getProductsData})
      : super(key: key);

  final Future<List<ProductModel>> Function(String category) getProductsData;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<ProductModel>>(
      future: getProductsData("/top"),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          var data = snapshot.data;
          return CustomCarouselSlider.getCarouselSlider(
            carouselItems: data!,
          );
        }

        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
