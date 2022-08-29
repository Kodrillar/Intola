import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intola/src/screens/delivery/delivery_detail_screen.dart';

import 'package:intola/src/utils/constant.dart';

import 'buttons/custom_button.dart';

class DeliveryCard extends StatefulWidget {
  const DeliveryCard({
    Key? key,
    required this.email,
    required this.contact,
    required this.deliveryImage,
    required this.deliveryWeight,
    required this.deliveryPrice,
    required this.description,
    required this.location,
  }) : super(key: key);

  final String deliveryImage;
  final String email;
  final String deliveryPrice;
  final String deliveryWeight;
  final String description;
  final String location;
  final String contact;

  @override
  _DeliveryCardState createState() => _DeliveryCardState();
}

class _DeliveryCardState extends State<DeliveryCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 25),
      height: 500,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 15),
              child: Text(
                "${widget.email} wants to deliver goods:",
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: kDarkOrange,
                ),
              ),
            ),
            _buildProductImage(),
            _buildPrice(),
            _buildWeight(),
            Center(
              child: CustomButton(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DeliveryDetailScreen(
                        image: widget.deliveryImage,
                        location: widget.location,
                        price: widget.deliveryPrice,
                        contact: widget.contact,
                        description: widget.description,
                        weight: widget.deliveryWeight,
                      ),
                    ),
                  );
                },
                buttonName: "Take delivery",
                buttonColor: kDarkBlue,
              ),
            )
          ],
        ),
      ),
    );
  }

  _buildWeight() {
    return Padding(
      padding: const EdgeInsets.only(top: 16, bottom: 30, right: 18),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            "Weight",
            style: kAppBarTextStyle,
          ),
          Text(
            "${widget.deliveryWeight}kg",
            style: kAppBarTextStyle.copyWith(
              color: kDarkOrange,
            ),
          ),
        ],
      ),
    );
  }

  _buildPrice() {
    return Padding(
      padding: const EdgeInsets.only(right: 18, top: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            "Price",
            style: kAppBarTextStyle,
          ),
          Text(
            "\$${widget.deliveryPrice}",
            style: kAppBarTextStyle.copyWith(
              color: kDarkOrange,
            ),
          ),
        ],
      ),
    );
  }

  _buildProductImage() {
    return CachedNetworkImage(
      imageUrl: widget.deliveryImage,
      imageBuilder: (context, imageProvider) => Container(
        height: 200,
        decoration: BoxDecoration(
          image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
          borderRadius: BorderRadius.circular(15),
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
