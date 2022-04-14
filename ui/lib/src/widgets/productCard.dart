import 'package:flutter/material.dart';
import 'package:intola/src/screens/productScreen.dart';
import 'package:intola/src/services/api.dart';
import 'package:intola/src/utils/constant.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ProductCard extends StatefulWidget {
  const ProductCard({
    required this.productName,
    required this.productImage,
    required this.productDescription,
    required this.productPrice,
    required this.productSlashprice,
  });

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
        margin: EdgeInsets.symmetric(
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
                  Center(child: CircularProgressIndicator()),
              errorWidget: (context, url, error) =>
                  Center(child: Icon(Icons.error, color: Colors.red)),
            ),
            SizedBox(height: 10),
            Text(
              widget.productName,
              style: TextStyle(
                fontSize: 20,
                color: kDarkBlue,
              ),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //Slash price
                Text(
                  "\$${widget.productSlashprice}",
                  style: TextStyle(
                      decoration: TextDecoration.lineThrough,
                      color: Colors.grey,
                      fontSize: 17),
                ),
                //Price
                Text(
                  "\$${widget.productPrice}",
                  style: TextStyle(
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
