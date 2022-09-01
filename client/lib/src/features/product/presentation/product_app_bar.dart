import 'package:flutter/material.dart';
import 'package:intola/src/utils/constant.dart';

class ProductAppBar extends StatelessWidget with PreferredSizeWidget {
  const ProductAppBar({Key? key}) : super(key: key);

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
      actions: [
        IconButton(
          onPressed: () {
            //shopping cart not implemented
            // Navigator.pushNamed(context, CartScreen.id);
          },
          icon: const Icon(Icons.shopping_cart_outlined),
          color: kDarkBlue,
        )
      ],
      elevation: 0,
      backgroundColor: Colors.transparent,
      title: const Text(
        "Shop",
        style: kAppBarTextStyle,
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(35);
}
