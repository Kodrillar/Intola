import 'package:flutter/material.dart';
import 'package:intola/src/features/auth/presentation/log_in_screen.dart';
import 'package:intola/src/features/auth/presentation/sign_up_screen.dart';
import 'package:intola/src/features/delivery/presentation/delivery_screen.dart';
import 'package:intola/src/features/delivery/presentation/upload_delivery_screen.dart';
import 'package:intola/src/features/donation/presentation/screens/donation_product_screen.dart';
import 'package:intola/src/features/donation/presentation/screens/donation_screen.dart';
import 'package:intola/src/features/profile/presentation/screens/profile_screen.dart';
import 'package:intola/src/screens/cart_screen.dart';
import 'package:intola/src/screens/home_screen.dart';
import 'package:intola/src/screens/onboarding_screen.dart';
import 'package:intola/src/screens/purchase_history_screen.dart';
import 'package:intola/src/screens/shipping_info_screen.dart';

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
      initialRoute: LoginScreen.id,
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
