import 'package:flutter/material.dart';
import 'package:intola/src/features/delivery/presentation/delivery_screen.dart';
import 'package:intola/src/features/donation/presentation/screens/donation_screen.dart';
import 'package:intola/src/features/purchase/presentation/screens/purchase_history_screen.dart';
import 'package:intola/src/utils/constant.dart';
import '../features/home/screens/home_screen.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  const CustomBottomNavigationBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _navigationButton(
            context: context,
            routeName: HomeScreen.id,
            icon: const Icon(Icons.home_outlined),
          ),
          _navigationButton(
            context: context,
            routeName: DonationScreen.id,
            icon: const Icon(Icons.clean_hands_outlined),
          ),
          _navigationButton(
            context: context,
            routeName: DeliveryScreen.id,
            icon: const Icon(Icons.local_shipping_outlined),
          ),
          _navigationButton(
            context: context,
            routeName: PurchaseHistoryScreen.id,
            icon: const Icon(
              Icons.shopping_cart_checkout_sharp,
            ),
          )
        ],
      ),
    );
  }

  IconButton _navigationButton(
      {required Icon icon, required String routeName, required context}) {
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
