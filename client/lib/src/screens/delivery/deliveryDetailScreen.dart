import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../utils/constant.dart';
import '../../widgets/buttons/customButton.dart';

class DeliveryDetailScreen extends StatefulWidget {
  const DeliveryDetailScreen({
    required this.image,
    required this.location,
    required this.price,
    required this.contact,
    required this.description,
    required this.weight,
  });

  final String image;
  final String location;
  final String price;
  final String contact;
  final String weight;
  final String description;

  static const id = "/deliveryDetailScreen";

  @override
  _DeliveryDetailScreenState createState() => _DeliveryDetailScreenState();
}

class _DeliveryDetailScreenState extends State<DeliveryDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      bottomNavigationBar: _buildBottomAppBar(),
      body: ListView(children: [
        _buildProductImage(),
        _buildProductDetails(),
        _buildPickUpLocation(),
        _buildContact(),
        _buildPrice(),
      ]),
    );
  }

  _buildPrice() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 5),
      height: 85,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                "Price",
                style: kProductNameStyle,
              ),
            ],
          ),
          SizedBox(height: 10),
          Text(
            "\$${widget.price}",
            textAlign: TextAlign.justify,
            style: kProductDetailStyle,
          )
        ],
      ),
    );
  }

  _buildContact() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 5),
      height: 85,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                "Contact",
                style: kProductNameStyle,
              ),
            ],
          ),
          SizedBox(height: 10),
          Text(
            "${widget.contact}",
            textAlign: TextAlign.justify,
            style: kProductDetailStyle,
          )
        ],
      ),
    );
  }

  _buildPickUpLocation() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 5),
      height: 85,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                "Pick up location",
                style: kProductNameStyle,
              ),
            ],
          ),
          SizedBox(height: 10),
          Text(
            "${widget.location}",
            textAlign: TextAlign.justify,
            style: kProductDetailStyle,
          )
        ],
      ),
    );
  }

  _buildProductDetails() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 5),
      height: 145,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                "Description",
                style: kProductNameStyle,
              ),
            ],
          ),
          SizedBox(height: 10),
          Text(
            "${widget.description}",
            textAlign: TextAlign.justify,
            style: kProductDetailStyle,
          )
        ],
      ),
    );
  }

  _buildProductImage() {
    return CachedNetworkImage(
      imageUrl: "${widget.image}",
      imageBuilder: (context, imageProvider) => Container(
        margin: EdgeInsets.all(16),
        height: 200,
        decoration: BoxDecoration(
          image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
          borderRadius: BorderRadius.circular(15),
          color: kDarkOrange.withOpacity(.08),
        ),
      ),
      placeholder: (context, url) => Center(
        child: CircularProgressIndicator(),
      ),
      errorWidget: (context, url, error) => Center(
        child: Icon(Icons.error, color: Colors.red),
      ),
    );
  }

  _buildBottomAppBar() {
    return BottomAppBar(
      elevation: 0,
      child: Container(
        height: 80,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomButton(
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  _buildSnackBar(),
                );
              },
              buttonName: "Accept",
              buttonColor: kDarkBlue,
            ),
            CustomButton(
              onTap: () {
                Navigator.of(context).pop();
              },
              buttonName: "Cancel",
            )
          ],
        ),
      ),
    );
  }

  _buildSnackBar() {
    return SnackBar(
      backgroundColor: kDarkBlue,
      content: Text(
        "Delivery accepted! kindly go to pick up location",
      ),
      action: SnackBarAction(
        label: "UNDO",
        onPressed: () {},
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      leading: IconButton(
        color: kDarkBlue,
        icon: Icon(Icons.arrow_back_ios),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      title: Text(
        "Delivery details",
        style: kAppBarTextStyle,
      ),
    );
  }
}
