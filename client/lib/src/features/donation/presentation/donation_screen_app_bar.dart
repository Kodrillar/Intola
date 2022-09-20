import 'package:flutter/material.dart';
import 'package:intola/src/utils/constant.dart';

class DonationScreenAppBar extends StatelessWidget with PreferredSizeWidget {
  const DonationScreenAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      title: const Text(
        "Donations",
        style: kAppBarTextStyle,
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}
