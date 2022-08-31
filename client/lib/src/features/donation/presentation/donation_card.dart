import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intola/src/features/donation/presentation/screens/donation_product_screen.dart';
import 'package:intola/src/utils/network/api.dart';
import 'package:intola/src/utils/constant.dart';

class DonationCard extends StatefulWidget {
  const DonationCard({
    Key? key,
    this.id,
    required this.productImage,
    required this.productPrice,
    required this.productName,
    required this.productDescription,
    required this.email,
    required this.productQuantity,
    required this.spotsleft,
  }) : super(key: key);
  final id;
  final String productImage;
  final String productPrice;
  final String productName;
  final String email;
  final String productDescription;
  final String productQuantity;
  final String spotsleft;

  @override
  _DonationCardState createState() => _DonationCardState();
}

class _DonationCardState extends State<DonationCard> {
  // @override
  // void initState() {
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DonationProductScreen(
              productId: widget.id,
              image: widget.productImage,
              name: widget.productName,
              price: widget.productPrice,
              description: widget.productDescription,
              spotsleft: widget.spotsleft,
              email: widget.email,
            ),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 25),
        height: 455,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 15),
                child: Text(
                  "${widget.email} is donating:",
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: kDarkOrange,
                  ),
                ),
              ),
              _buildProductImage(),
              _buildProductName(),
              _buildTotalQuantity(),
              _buildSpotsLeft(),
              const Divider(
                endIndent: 16,
                indent: 16,
                color: kDarkOrange,
              )
            ],
          ),
        ),
      ),
    );
  }

  _buildProductImage() {
    return CachedNetworkImage(
      imageUrl: "${API.baseUrl}/uploads/${widget.productImage}",
      imageBuilder: (context, imageProvider) => Container(
        height: 200,
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
        child: Icon(Icons.error, color: Colors.red),
      ),
    );
  }

  _buildSpotsLeft() {
    return Padding(
      padding: const EdgeInsets.only(top: 16, bottom: 16, right: 18),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            "Spots left",
            style: kAppBarTextStyle,
          ),
          Text(
            "x${widget.spotsleft}",
            style: kAppBarTextStyle.copyWith(
              color: kDarkOrange,
            ),
          ),
        ],
      ),
    );
  }

  _buildTotalQuantity() {
    return Padding(
      padding: const EdgeInsets.only(right: 18),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            "Total quantity",
            style: kAppBarTextStyle,
          ),
          Text(
            "x${widget.productQuantity}",
            style: kAppBarTextStyle.copyWith(
              color: kDarkOrange,
            ),
          ),
        ],
      ),
    );
  }

  _buildProductName() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            widget.productName,
            style: kProductNameStyle,
          ),
          Text(
            "\$${widget.productPrice}",
            style: kProductNameStyle,
          ),
        ],
      ),
    );
  }
}
