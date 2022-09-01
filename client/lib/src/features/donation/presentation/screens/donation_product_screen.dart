import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intola/src/features/donation/presentation/screens/donation_shipping_info_screen.dart';
import 'package:intola/src/utils/constant.dart';
import 'package:intola/src/utils/network/api.dart';
import 'package:intola/src/widgets/buttons/custom_round_button.dart';

class DonationProductScreen extends StatefulWidget {
  const DonationProductScreen({
    Key? key,
    this.image,
    this.name,
    this.price,
    this.description,
    this.productId,
    this.spotsleft,
    this.email,
  }) : super(key: key);
  final productId;
  final spotsleft;
  final image;
  final name;
  final price;
  final description;
  final email;
  static const id = "/donationProductScreen";

  @override
  _DonationProductScreenState createState() => _DonationProductScreenState();
}

class _DonationProductScreenState extends State<DonationProductScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: ListView(
        children: [
          _buildProductImage(),
          _buildProductDetails(),
          _buildProductQuantity(),
          _buildProductButton(),
        ],
      ),
    );
  }

  _buildProductButton() {
    return SizedBox(
      height: 100,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomRoundButton(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DonationShippingInfoScreen(
                    image: widget.image,
                    name: widget.name,
                    productId: widget.productId,
                    spotsleft: widget.spotsleft,
                    donorEmail: widget.email,
                  ),
                ),
              );
            },
            buttonName: "Checkout",
            buttonColor: kDarkBlue,
          ),
        ],
      ),
    );
  }

  _buildProductQuantity() {
    return Container(
      margin: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Quantity", style: kAppBarTextStyle),
          Padding(
            padding: const EdgeInsets.only(left: 16, top: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '1',
                  style: kAppBarTextStyle.copyWith(color: kDarkOrange),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  _buildProductDetails() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      height: 250,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "${widget.name}",
                style: kProductNameStyle,
              ),
              Text(
                "\$${widget.price}",
                style: kProductNameStyle,
              ),
            ],
          ),
          const SizedBox(height: 20),
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
      imageUrl: "${API.baseUrl}/uploads/${widget.image}",
      imageBuilder: (context, imageProvider) => Container(
        margin: const EdgeInsets.all(16),
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
      placeholder: (context, url) => const Center(
        child: CircularProgressIndicator(),
      ),
      errorWidget: (context, url, error) => const Center(
        child: Icon(Icons.error, color: Colors.red),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      leading: IconButton(
        color: kDarkBlue,
        icon: const Icon(Icons.arrow_back_ios),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      title: const Text(
        "Donation Shop",
        style: kAppBarTextStyle,
      ),
    );
  }
}
