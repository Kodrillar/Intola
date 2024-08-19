import 'package:flutter/material.dart';
import 'package:intola/src/utils/constant.dart';

class ShippingInfoAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const ShippingInfoAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        color: kDarkBlue,
        icon: const Icon(Icons.arrow_back_ios),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      title: const Text(
        "Shipping Infomation",
        style: kAppBarTextStyle,
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(70);
}
