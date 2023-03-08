import 'package:flutter/material.dart';
import 'package:intola/src/utils/constant.dart';

class PurchaseHistoryAppBar extends StatelessWidget with PreferredSizeWidget {
  const PurchaseHistoryAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      title: const Text(
        "Purchases",
        style: kAppBarTextStyle,
      ),
      bottom: PreferredSize(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            AppBarBottomHeading(text: 'What you bought'),
            AppBarBottomHeading(text: 'Delivery status'),
          ],
        ),
        preferredSize: const Size.fromHeight(60),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(80);
}

class AppBarBottomHeading extends StatelessWidget {
  const AppBarBottomHeading({
    required this.text,
    super.key,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Text(
        text,
        style: kProductDetailStyle.copyWith(
          fontWeight: FontWeight.w500,
          fontSize: 11,
        ),
      ),
    );
  }
}
