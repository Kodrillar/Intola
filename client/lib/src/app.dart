import 'package:flutter/material.dart';
import 'package:intola/src/screens/auth/log_in_screen.dart';
import 'package:intola/src/screens/cart_screen.dart';
import 'package:intola/src/screens/delivery/delivery_screen.dart';
import 'package:intola/src/screens/donation/donation_product_screen.dart';
import 'package:intola/src/screens/donation/donation_screen.dart';
import 'package:intola/src/screens/home_screen.dart';
import 'package:intola/src/screens/onboarding_screen.dart';
import 'package:intola/src/screens/auth/sign_up_screen.dart';
import 'package:intola/src/screens/purchase_history_screen.dart';
import 'package:intola/src/screens/shipping_info_screen.dart';
import 'package:intola/src/screens/profile_screen.dart';
import 'package:intola/src/screens/delivery/upload_delivery_screen.dart';

class IntolaApp extends StatelessWidget {
  const IntolaApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Intola',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      initialRoute: OnboardingScreen.id,
      routes: {
        OnboardingScreen.id: (context) => const OnboardingScreen(),
        SignUpScreen.id: (context) => const SignUpScreen(),
        LoginScreen.id: (context) => const LoginScreen(),
        HomeScreen.id: (context) => const HomeScreen(),
        PurchaseHistoryScreen.id: (context) => const PurchaseHistoryScreen(),
        DonationScreen.id: (context) => const DonationScreen(),
        DeliveryScreen.id: (context) => const DeliveryScreen(),
        CartScreen.id: (context) => const CartScreen(),
        ShippingInfoScreen.id: (context) => const ShippingInfoScreen(),
        ProfileScreen.id: (context) => const ProfileScreen(),
        UploadDeliveryScreen.id: (context) => const UploadDeliveryScreen(),
        DonationProductScreen.id: (context) => const DonationProductScreen(),
      },
    );
  }
}
