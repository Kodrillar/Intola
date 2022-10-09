import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intola/src/features/donation/domain/model/donation_model.dart';
import 'package:intola/src/features/donation/presentation/screens/donation_product_screen.dart';
import 'package:intola/src/utils/network/api.dart';
import 'package:intola/src/utils/constant.dart';

class DonationCard extends StatefulWidget {
  const DonationCard({
    Key? key,
    required this.donation,
  }) : super(key: key);

  final DonationModel donation;

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
              donation: widget.donation,
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
                  "${widget.donation.email} is donating:",
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
      imageUrl: "${API.baseUrl}/uploads/${widget.donation.image}",
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
            "x${widget.donation.spotsleft}",
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
            "x${widget.donation.quantity}",
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
            widget.donation.name,
            style: kProductNameStyle,
          ),
          Text(
            "\$${widget.donation.price}",
            style: kProductNameStyle,
          ),
        ],
      ),
    );
  }
}
