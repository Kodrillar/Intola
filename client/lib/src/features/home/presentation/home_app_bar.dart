import 'package:flutter/material.dart';
import 'package:intola/src/routing/route.dart';
import 'package:intola/src/utils/constant.dart';
import 'package:intola/src/utils/reduce_string_length.dart';

class HomeAppBar extends StatelessWidget with PreferredSizeWidget {
  const HomeAppBar({Key? key, required this.userName}) : super(key: key);

  final String? userName;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: IconButton(
        onPressed: () {
          Navigator.pushNamed(context, RouteName.profileScreen.name);
        },
        icon: const Icon(
          Icons.account_circle,
          color: kDarkBlue,
        ),
      ),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(30),
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  "Hi, ${userName?.reduceStringLength}",
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: kHeadingTextStyle.copyWith(
                    fontSize: 18,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      actions: [
        IconButton(
          onPressed: () {
            Navigator.pushNamed(context, RouteName.cartScreen.name);
          },
          icon: const Icon(
            Icons.shopping_cart_outlined,
            color: kDarkBlue,
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(110);
}
