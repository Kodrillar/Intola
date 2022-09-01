import 'package:flutter/material.dart';
import 'package:intola/src/features/delivery/presentation/screen/delivery_screen.dart';
import 'package:intola/src/features/donation/presentation/screens/donation_screen.dart';
import 'package:intola/src/features/home/presentation/screen/home_screen.dart';
import 'package:intola/src/features/purchase/presentation/screens/purchase_history_screen.dart';
import 'package:intola/src/utils/constant.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  const CustomBottomNavigationBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: const [
          NavigationButton(
            routeName: HomeScreen.id,
            icon: Icon(Icons.home_outlined),
          ),
          NavigationButton(
            routeName: DonationScreen.id,
            icon: Icon(Icons.clean_hands_outlined),
          ),
          NavigationButton(
            routeName: DeliveryScreen.id,
            icon: Icon(Icons.local_shipping_outlined),
          ),
          NavigationButton(
            routeName: PurchaseHistoryScreen.id,
            icon: Icon(
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
          ModalRoute.withName('/'),
        );
      },
      icon: icon,
    );
  }
}
