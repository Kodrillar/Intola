import 'package:flutter/material.dart';
import 'package:intola/src/features/product/presentation/screens/product_screen.dart';
import 'package:intola/src/utils/network/api.dart';
import 'package:intola/src/utils/constant.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ProductCard extends StatefulWidget {
  const ProductCard({
    Key? key,
    required this.productName,
    required this.productImage,
    required this.productDescription,
    required this.productPrice,
    required this.productSlashprice,
  }) : super(key: key);

  final String productName;
  final String productImage;
  final String productSlashprice;
  final String productPrice;
  final String productDescription;

  @override
  _ProductCardState createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductScreen(
              productImage: widget.productImage,
              productName: widget.productName,
              productDescription: widget.productDescription,
              productPrice: widget.productPrice,
            ),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(
          horizontal: 8,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CachedNetworkImage(
              imageUrl: "${API.baseUrl}/uploads/${widget.productImage}",
              imageBuilder: (context, imageProvider) => Container(
                height: 115,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: kDarkOrange.withOpacity(.08),
                  image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              placeholder: (context, url) =>
                  const Center(child: CircularProgressIndicator()),
              errorWidget: (context, url, error) =>
                  const Center(child: Icon(Icons.error, color: Colors.red)),
            ),
            const SizedBox(height: 10),
            Text(
              widget.productName,
              style: const TextStyle(
                fontSize: 20,
                color: kDarkBlue,
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //Slash price
                Text(
                  "\$${widget.productSlashprice}",
                  style: const TextStyle(
                      decoration: TextDecoration.lineThrough,
                      color: Colors.grey,
                      fontSize: 17),
                ),
                //Price
                Text(
                  "\$${widget.productPrice}",
                  style: const TextStyle(
                    color: kDarkBlue,
                    fontSize: 17,
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
