import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:intola/src/models/product_model.dart';
import 'package:intola/src/screens/product_screen.dart';
import 'package:intola/src/services/api.dart';
import 'package:intola/src/utils/constant.dart';

class CustomCarouselSlider {
  static getCarouselSlider({required List<ProductModel> carouselItems}) {
    return CarouselSlider(
      options: CarouselOptions(
        height: 180,
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
                          productImage: product.image,
                          productDescription: product.description,
                          productName: product.name,
                          productPrice: product.price,
                        ),
                      ),
                    );
                  },
                  child: CachedNetworkImage(
                    imageUrl: "${API.baseUrl}/uploads/${product.image}",
                    imageBuilder: (context, imageProvider) => Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: kDarkOrange.withOpacity(.08),
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    placeholder: (context, url) =>
                        const Center(child: CircularProgressIndicator()),
                    errorWidget: (context, url, error) => const Center(
                        child: Icon(Icons.error, color: Colors.red)),
                  ),
                );
              },
            ),
          )
          .toList(),
    );
  }
}
