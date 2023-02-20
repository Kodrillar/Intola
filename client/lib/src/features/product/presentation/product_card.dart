import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intola/src/features/product/domain/model/product_model.dart';
import 'package:intola/src/features/product/presentation/screens/product_screen.dart';
import 'package:intola/src/utils/constant.dart';
import 'package:intola/src/utils/network/api.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({Key? key, required this.product}) : super(key: key);

  final ProductModel product;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductScreen(product: product),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: SizedBox(
                height: 100,
                width: 200,
                child: CachedNetworkImage(
                  imageUrl: "${API.baseUrl}/uploads/${product.image}",
                  // maxHeightDiskCache: 40,
                  // maxWidthDiskCache: 80,
                  fit: BoxFit.cover,
                  placeholder: (context, url) =>
                      const Center(child: CircularProgressIndicator()),
                  errorWidget: (context, url, error) =>
                      const Center(child: Icon(Icons.error, color: Colors.red)),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              product.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 16,
                color: kDarkBlue,
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //Slash price
                Text(
                  "\$${product.slashprice}",
                  style: const TextStyle(
                    decoration: TextDecoration.lineThrough,
                    color: Colors.grey,
                    fontSize: 12,
                  ),
                ),
                //Price
                Text(
                  "\$${product.price}",
                  style: const TextStyle(
                    color: kDarkBlue,
                    fontSize: 12,
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
