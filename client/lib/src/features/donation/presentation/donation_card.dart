import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intola/src/features/donation/domain/model/donation_model.dart';
import 'package:intola/src/features/donation/presentation/screens/donation_product_screen.dart';
import 'package:intola/src/utils/network/api.dart';
import 'package:intola/src/utils/constant.dart';

class DonationCard extends StatelessWidget {
  const DonationCard({
    Key? key,
    required this.donation,
  }) : super(key: key);

  final DonationModel donation;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DonationProductScreen(
              donation: donation,
            ),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
        height: 415,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 15),
              child: Text(
                "${donation.email} is donating:",
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: kDarkOrange,
                ),
              ),
            ),
            DonationCardProductImage(donation: donation),
            DonationCardProductName(donation: donation),
            DonationCardProductQuantity(donation: donation),
            DonationCardSpotsLeft(donation: donation),
            const Divider(
              endIndent: 16,
              indent: 16,
              color: kDarkOrange,
            )
          ],
        ),
      ),
    );
  }
}

class DonationCardSpotsLeft extends StatelessWidget {
  const DonationCardSpotsLeft({Key? key, required this.donation})
      : super(key: key);
  final DonationModel donation;

  @override
  Widget build(BuildContext context) {
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
            "x${donation.spotsleft}",
            style: kAppBarTextStyle.copyWith(
              color: kDarkOrange,
            ),
          ),
        ],
      ),
    );
  }
}

class DonationCardProductQuantity extends StatelessWidget {
  const DonationCardProductQuantity({Key? key, required this.donation})
      : super(key: key);
  final DonationModel donation;

  @override
  Widget build(BuildContext context) {
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
            "x${donation.quantity}",
            style: kAppBarTextStyle.copyWith(
              color: kDarkOrange,
            ),
          ),
        ],
      ),
    );
  }
}

class DonationCardProductName extends StatelessWidget {
  const DonationCardProductName({Key? key, required this.donation})
      : super(key: key);

  final DonationModel donation;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            donation.name,
            style: kProductNameStyle,
          ),
          Text(
            "\$${donation.price}",
            style: kProductNameStyle,
          ),
        ],
      ),
    );
  }
}

class DonationCardProductImage extends StatelessWidget {
  const DonationCardProductImage({Key? key, required this.donation})
      : super(key: key);

  final DonationModel donation;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: "${API.baseUrl}/uploads/${donation.image}",
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
}
