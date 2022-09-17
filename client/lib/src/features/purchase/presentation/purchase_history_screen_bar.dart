import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intola/src/utils/constant.dart';
import 'package:intola/src/utils/date_formatter.dart';
import 'package:intola/src/utils/network/api.dart';

class PurchaseHistoryScreenBar extends StatelessWidget {
  const PurchaseHistoryScreenBar({
    Key? key,
    required this.productName,
    required this.productStatus,
    required this.productImage,
    required this.date,
  }) : super(key: key);

  final String productName;
  final String productStatus;
  final String productImage;
  final String date;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      height: 150,
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: CachedNetworkImage(
                imageUrl: "${API.baseUrl}/uploads/$productImage",
                imageBuilder: (context, imageProvider) => Container(
                  height: 90,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
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
              ),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(productName, style: kAppBarTextStyle),
                const SizedBox(height: 10),
                Text(
                  DateTime.parse(date).getDateInTimeAgo,
                  style: kAppBarTextStyle.copyWith(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: kDarkOrange),
                ),
              ],
            ),
          ),
          Text(
            productStatus,
            style: kAppBarTextStyle.copyWith(
              color: kDarkOrange,
              fontSize: 15.5,
            ),
          )
        ],
      ),
    );
  }
}
