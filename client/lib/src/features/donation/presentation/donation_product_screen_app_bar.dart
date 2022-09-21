import 'package:flutter/material.dart';
import 'package:intola/src/utils/constant.dart';

class DonationProductScreenAppBar extends StatelessWidget
    with PreferredSizeWidget {
  const DonationProductScreenAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        color: kDarkBlue,
        icon: const Icon(Icons.arrow_back_ios),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      title: const Text(
        "Donation Shop",
        style: kAppBarTextStyle,
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}
