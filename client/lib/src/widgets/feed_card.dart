import 'package:flutter/material.dart';
import 'package:intola/src/utils/constant.dart';
import 'package:intola/src/utils/reduce_string_length.dart';
import 'package:intola/src/widgets/buttons/custom_round_button.dart';
import 'package:intola/src/features/delivery/presentation/delivery_product_image.dart';
import 'package:intola/src/widgets/product_image.dart';

enum FeedCardType {
  delivery('I want to deliver this.', 'Take delivery'),
  donation('I\'m donating this.', 'Claim');

  const FeedCardType(this.feedCardCaption, this.feedCardButtonName);
  final String feedCardCaption;
  final String feedCardButtonName;
}

class FeedCard extends StatelessWidget {
  const FeedCard({
    Key? key,
    required this.feedCardType,
    required this.userName,
    required this.feedImage,
    required this.leadingDetailValue,
    required this.trailingDetailValue,
    required this.onPressed,
  }) : super(key: key);

  final FeedCardType feedCardType;
  final String userName;
  final String feedImage;
  final String leadingDetailValue;
  final String trailingDetailValue;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      elevation: 3,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        height: 430,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Text(
                userName.reduceStringLength,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: kDarkOrange,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Text(
                feedCardType.feedCardCaption,
                style: const TextStyle(
                  fontSize: 12,
                  color: kDarkOrange,
                ),
              ),
            ),
            feedCardType == FeedCardType.delivery
                ? DeliveryProductImage(deliveryImage: feedImage)
                : ProductImage(productImage: feedImage),
            LeadingFeedCardDetail(
              leadingDetailValue: leadingDetailValue,
              feedCardType: feedCardType,
            ),
            TrailingFeedCardDetail(
              trailingDetailValue: trailingDetailValue,
              feedCardType: feedCardType,
            ),
            Center(
              child: CustomRoundButton(
                width: 180,
                onTap: onPressed,
                buttonText: feedCardType.feedCardButtonName,
                buttonColor: kDarkBlue,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class TrailingFeedCardDetail extends StatelessWidget {
  const TrailingFeedCardDetail(
      {Key? key, required this.trailingDetailValue, required this.feedCardType})
      : super(key: key);

  final String trailingDetailValue;
  final FeedCardType feedCardType;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 16,
        bottom: 30,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            feedCardType == FeedCardType.delivery ? "Weight" : "Quantity left",
            style: kAppBarTextStyle.copyWith(fontSize: 12),
          ),
          Text(
            feedCardType == FeedCardType.delivery
                ? "${trailingDetailValue}kg"
                : "x$trailingDetailValue",
            style: kAppBarTextStyle.copyWith(color: kDarkOrange, fontSize: 12),
          ),
        ],
      ),
    );
  }
}

class LeadingFeedCardDetail extends StatelessWidget {
  const LeadingFeedCardDetail({
    Key? key,
    required this.leadingDetailValue,
    required this.feedCardType,
  }) : super(key: key);
  final String leadingDetailValue;
  final FeedCardType feedCardType;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            feedCardType == FeedCardType.delivery ? "Price" : "Total Quantity",
            style: kAppBarTextStyle.copyWith(fontSize: 12),
          ),
          Text(
            feedCardType == FeedCardType.delivery
                ? "\$$leadingDetailValue"
                : "x$leadingDetailValue",
            style: kAppBarTextStyle.copyWith(color: kDarkOrange, fontSize: 12),
          ),
        ],
      ),
    );
  }
}
