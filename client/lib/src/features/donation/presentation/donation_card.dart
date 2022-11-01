import 'package:flutter/material.dart';
import 'package:intola/src/features/donation/domain/model/donation_model.dart';
import 'package:intola/src/features/donation/presentation/screens/donation_product_screen.dart';
import 'package:intola/src/widgets/feed_card.dart';

class DonationCard extends StatelessWidget {
  const DonationCard({
    Key? key,
    required this.donation,
  }) : super(key: key);

  final DonationModel donation;
  @override
  Widget build(BuildContext context) {
    return FeedCard(
      feedCardType: FeedCardType.donation,
      userName: donation.email!,
      feedImage: donation.image,
      leadingDetailValue: donation.quantity,
      trailingDetailValue: donation.spotsleft,
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DonationProductScreen(donation: donation),
          ),
        );
      },
    );
  }
}
