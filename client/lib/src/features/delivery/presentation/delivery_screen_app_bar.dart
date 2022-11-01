import 'package:flutter/material.dart';
import 'package:intola/src/routing/route.dart';
import 'package:intola/src/utils/constant.dart';

class DeliveryScreenAppBar extends StatelessWidget with PreferredSizeWidget {
  const DeliveryScreenAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        color: kDarkBlue,
        icon: const Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).pushNamed(
            RouteName.uploadDeliveryScreen.name,
          );
        },
      ),
      actions: const [
        Center(
          child: Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: Text(
              "\$0",
              style: kAppBarTextStyle,
            ),
          ),
        ),
      ],
      elevation: 0,
      backgroundColor: Colors.transparent,
      title: const Text(
        "Delivery",
        style: kAppBarTextStyle,
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}
