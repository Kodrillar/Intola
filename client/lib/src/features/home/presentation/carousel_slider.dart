import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:intola/src/features/product/domain/model/product_model.dart';
import 'package:intola/src/features/product/presentation/screens/product_screen.dart';
import 'package:intola/src/utils/network/api.dart';

class CustomCarouselSlider extends StatelessWidget {
  const CustomCarouselSlider({Key? key, required this.carouselItems})
      : super(key: key);

  final List<ProductModel> carouselItems;

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        height: 150,
        scrollDirection: Axis.horizontal,
        viewportFraction: 0.8,
        autoPlay: true,
        enlargeCenterPage: true,
      ),
      items: carouselItems
          .map(
            (product) => Builder(
              builder: (BuildContext context) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductScreen(
                          product: product,
                        ),
                      ),
                    );
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: SizedBox(
                      width: double.infinity,
                      child: CachedNetworkImage(
                        imageUrl: "${API.baseUrl}/uploads/${product.image}",
                        // maxHeightDiskCache: 120,
                        //maxWidthDiskCache: 150,
                        fit: BoxFit.cover,
                        placeholder: (context, url) =>
                            const Center(child: CircularProgressIndicator()),
                        errorWidget: (context, url, error) => const Center(
                          child: Icon(Icons.error, color: Colors.red),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          )
          .toList(),
    );
  }
}
