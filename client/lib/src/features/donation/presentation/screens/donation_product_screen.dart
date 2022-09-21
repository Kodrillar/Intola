import 'package:flutter/material.dart';
import 'package:intola/src/features/donation/presentation/donation_product_quantity.dart';
import 'package:intola/src/features/donation/presentation/donation_product_screen_app_bar.dart';
import 'package:intola/src/features/donation/presentation/screens/donation_shipping_info_screen.dart';
import 'package:intola/src/utils/constant.dart';
import 'package:intola/src/widgets/buttons/custom_round_button.dart';
import 'package:intola/src/widgets/product_details.dart';
import 'package:intola/src/widgets/product_image.dart';

class DonationProductScreen extends StatelessWidget {
  const DonationProductScreen({
    Key? key,
    required this.productImage,
    required this.productName,
    required this.price,
    required this.description,
    this.productId,
    this.spotsleft,
    required this.email,
  }) : super(key: key);
  final productId;
  final spotsleft;
  final String productImage;
  final String productName;
  final String price;
  final String description;
  final String email;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const DonationProductScreenAppBar(),
      body: ListView(
        children: [
          ProductImage(productImage: productImage),
          ProductDetails(
            productDescription: description,
            productName: productName,
            productPrice: price,
          ),
          const DonationProductQuantity(),
          DonationProductCtaButton(
            email: email,
            image: productImage,
            name: productName,
            productId: productId,
            spotsleft: spotsleft,
          )
        ],
      ),
    );
  }
}

class DonationProductCtaButton extends StatelessWidget {
  const DonationProductCtaButton({
    Key? key,
    required this.email,
    required this.image,
    required this.name,
    required this.productId,
    required this.spotsleft,
  }) : super(key: key);

  final String image;
  final String name;
  final productId;
  final spotsleft;
  final String email;

  @override
  Widget build(BuildContext context) {
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
                    image: image,
                    name: name,
                    productId: productId,
                    spotsleft: spotsleft,
                    donorEmail: email,
                  ),
                ),
              );
            },
            buttonText: "Checkout",
            buttonColor: kDarkBlue,
          ),
        ],
      ),
    );
  }
}
