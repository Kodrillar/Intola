import 'package:flutter/material.dart';
import 'package:intola/src/features/donation/domain/model/donation_model.dart';
import 'package:intola/src/features/donation/presentation/donation_product_quantity.dart';
import 'package:intola/src/features/donation/presentation/screens/donation_shipping_info_screen.dart';
import 'package:intola/src/utils/constant.dart';
import 'package:intola/src/widgets/app_bar_with_back_arrow.dart';
import 'package:intola/src/widgets/buttons/custom_round_button.dart';
import 'package:intola/src/widgets/product_details.dart';
import 'package:intola/src/widgets/product_image.dart';

class DonationProductScreen extends StatelessWidget {
  const DonationProductScreen({Key? key, required this.donation})
      : super(key: key);

  final DonationModel donation;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: DonationProductCtaButton(donation: donation),
      appBar: const AppBarWithBackArrow(title: "Donation Shop"),
      body: ListView(
        children: [
          ProductImage(productImage: donation.image),
          ProductDetails(
            productDescription: donation.description,
            productName: donation.name,
            productPrice: donation.price,
          ),
          const DonationProductQuantity(),
        ],
      ),
    );
  }
}

class DonationProductCtaButton extends StatelessWidget {
  const DonationProductCtaButton({required this.donation, Key? key})
      : super(key: key);

  final DonationModel donation;

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: Colors.transparent,
      elevation: 0,
      child: SizedBox(
        height: 120,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomRoundButton(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DonationShippingInfoScreen(
                      donation: donation,
                    ),
                  ),
                );
              },
              buttonText: "Checkout",
              buttonColor: kDarkBlue,
            ),
          ],
        ),
      ),
    );
  }
}
