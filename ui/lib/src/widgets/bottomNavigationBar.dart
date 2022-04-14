import 'package:flutter/material.dart';
import 'package:intola/src/screens/delivery/deliveryScreen.dart';
import 'package:intola/src/screens/donation/donationScreen.dart';
import 'package:intola/src/screens/purchaseHistoryScreen.dart';
import 'package:intola/src/utils/constant.dart';
import '../screens/homeScreen.dart';

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
            icon: Icon(Icons.home_outlined),
          ),
          _navigationButton(
            context: context,
            routeName: DonationScreen.id,
            icon: Icon(Icons.clean_hands_outlined),
          ),
          _navigationButton(
            context: context,
            routeName: DeliveryScreen.id,
            icon: Icon(Icons.local_shipping_outlined),
          ),
          _navigationButton(
            context: context,
            routeName: PurchaseHistoryScreen.id,
            icon: Icon(
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
