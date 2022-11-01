import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intola/src/utils/constant.dart';

class DeliveryProductImage extends StatelessWidget {
  const DeliveryProductImage({Key? key, required this.deliveryImage})
      : super(key: key);

  final String deliveryImage;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: deliveryImage,
      imageBuilder: (context, imageProvider) => Container(
        height: 200,
        decoration: BoxDecoration(
          image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
          borderRadius: BorderRadius.circular(10),
          color: kDarkOrange.withOpacity(.08),
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
