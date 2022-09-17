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
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}
