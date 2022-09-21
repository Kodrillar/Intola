import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intola/src/utils/constant.dart';
import 'package:intola/src/utils/network/api.dart';

class ProductImage extends StatelessWidget {
  const ProductImage({
    Key? key,
    required this.productImage,
  }) : super(key: key);

  final String productImage;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: "${API.baseUrl}/uploads/$productImage",
      imageBuilder: (context, imageProvider) => Container(
        margin: const EdgeInsets.all(16),
        height: 200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: kDarkOrange.withOpacity(.075),
          image: DecorationImage(
            image: imageProvider,
            fit: BoxFit.cover,
          ),
        ),
      ),
      placeholder: (context, url) => const Center(
        child: CircularProgressIndicator(),
      ),
      errorWidget: (context, url, error) => const Center(
        child: Icon(Icons.error, color: Colors.red),
      ),
    );
  }
}
