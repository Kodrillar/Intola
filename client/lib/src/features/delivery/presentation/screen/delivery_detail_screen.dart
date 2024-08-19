import 'package:flutter/material.dart';
import 'package:intola/src/features/delivery/domain/model/delivery_model.dart';
import 'package:intola/src/utils/constant.dart';
import 'package:intola/src/widgets/alert_dialog.dart';
import 'package:intola/src/widgets/app_bar_with_back_arrow.dart';
import 'package:intola/src/widgets/buttons/custom_round_button.dart';
import 'package:intola/src/features/delivery/presentation/delivery_product_image.dart';

class DeliveryDetailScreen extends StatelessWidget {
  const DeliveryDetailScreen({Key? key, required this.delivery})
      : super(key: key);

  final DeliveryModel delivery;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWithBackArrow(title: "Delivery details"),
      bottomNavigationBar: const DeliveryDetailScreenBottomAppBar(),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        child: ListView(
          children: [
            DeliveryProductImage(deliveryImage: delivery.image!),
            DeliveryDescriptionSection(description: delivery.description),
            DeliveryPickUpLocationSection(location: delivery.location),
            DeliveryPriceSection(price: delivery.price),
            DeliveryContactSection(contact: delivery.contact),
          ],
        ),
      ),
    );
  }
}

class DeliveryPriceSection extends StatelessWidget {
  const DeliveryPriceSection({Key? key, required this.price}) : super(key: key);
  final String price;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Text(
                "Price",
                style: kProductNameStyle,
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            "\$$price",
            textAlign: TextAlign.justify,
            style: kProductDetailStyle,
          )
        ],
      ),
    );
  }
}

class DeliveryContactSection extends StatelessWidget {
  const DeliveryContactSection({Key? key, required this.contact})
      : super(key: key);
  final String contact;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Text(
                "Contact",
                style: kProductNameStyle,
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            contact,
            textAlign: TextAlign.justify,
            style: kProductDetailStyle,
          )
        ],
      ),
    );
  }
}

class DeliveryPickUpLocationSection extends StatelessWidget {
  const DeliveryPickUpLocationSection({Key? key, required this.location})
      : super(key: key);

  final String location;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Text(
                "Pick up location",
                style: kProductNameStyle,
                overflow: TextOverflow.ellipsis,
                maxLines: 3,
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            location,
            textAlign: TextAlign.justify,
            style: kProductDetailStyle,
          )
        ],
      ),
    );
  }
}

class DeliveryDescriptionSection extends StatelessWidget {
  const DeliveryDescriptionSection({Key? key, required this.description})
      : super(key: key);
  final String description;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Text(
                "Description",
                style: kProductNameStyle,
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            description,
            textAlign: TextAlign.justify,
            style: kProductDetailStyle,
          )
        ],
      ),
    );
  }
}

class DeliveryDetailScreenBottomAppBar extends StatelessWidget {
  const DeliveryDetailScreenBottomAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      elevation: 0,
      color: Colors.transparent,
      child: SizedBox(
        height: 120,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomRoundButton(
              onTap: () {
                CustomAlertDialog.showAlertDialog(
                  context: context,
                  title: 'Delivery accepted!',
                  content: 'kindly go to pick up location',
                );
              },
              buttonText: "Accept",
              buttonColor: kDarkBlue,
            ),
            CustomRoundButton(
              onTap: () {
                Navigator.of(context).pop();
              },
              buttonText: "Cancel",
            )
          ],
        ),
      ),
    );
  }
}
