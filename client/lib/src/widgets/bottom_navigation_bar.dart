import 'package:flutter/material.dart';
import 'package:intola/src/routing/route.dart';
import 'package:intola/src/utils/constant.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  const CustomBottomNavigationBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          NavigationButton(
            routeName: RouteName.homeScreen.name,
            icon: const Icon(Icons.home_outlined),
          ),
          NavigationButton(
            routeName: RouteName.donationScreen.name,
            icon: const Icon(Icons.clean_hands_outlined),
          ),
          NavigationButton(
            routeName: RouteName.deliveryScreen.name,
            icon: const Icon(Icons.local_shipping_outlined),
          ),
          NavigationButton(
            routeName: RouteName.purchaseHistoryScreen.name,
            icon: const Icon(
              Icons.shopping_cart_checkout_sharp,
            ),
          )
        ],
      ),
    );
  }
}

class NavigationButton extends StatelessWidget {
  const NavigationButton({
    Key? key,
    required this.icon,
    required this.routeName,
  }) : super(key: key);

  final Icon icon;
  final String routeName;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      color: kDarkBlue,
      onPressed: () {
        Navigator.pushNamedAndRemoveUntil(
          context,
          routeName,
          (route) => false,
        );
      },
      icon: icon,
    );
  }
}
