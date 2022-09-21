import 'package:flutter/material.dart';
import 'package:intola/src/utils/constant.dart';

class DonationProductQuantity extends StatelessWidget {
  const DonationProductQuantity({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
}
