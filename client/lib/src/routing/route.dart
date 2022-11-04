import 'package:flutter/material.dart';
import 'package:intola/src/features/auth/presentation/screen/log_in/log_in_screen.dart';
import 'package:intola/src/features/auth/presentation/screen/sign_up/sign_up_screen.dart';
import 'package:intola/src/features/cart/presentation/screen/cart_screen.dart';
import 'package:intola/src/features/delivery/presentation/screen/delivery_screen.dart';
import 'package:intola/src/features/delivery/presentation/delivery_upload_screen.dart';
import 'package:intola/src/features/donation/presentation/screens/donation_screen.dart';
import 'package:intola/src/features/home/presentation/screen/home_screen.dart';
import 'package:intola/src/features/profile/presentation/screens/profile_screen.dart';
import 'package:intola/src/features/purchase/presentation/screens/purchase_history_screen.dart';
import 'package:intola/src/features/user_onboarding/presentation/screen/onboarding_screen.dart';

enum RouteName {
  onboardingScreen,
  signUpScreen,
  loginScreen,
  homeScreen,
  donationScreen,
  deliveryScreen,
  cartScreen,
  // shippingInfoScreen,
  profileScreen,
  uploadDeliveryScreen,
  //donationProductScreen,
  purchaseHistoryScreen,
}

class AppRoute {
  static Map<String, Widget Function(BuildContext)> routes = {
    RouteName.onboardingScreen.name: (context) => OnboardingScreen(),
    RouteName.signUpScreen.name: (context) => const SignUpScreen(),
    RouteName.loginScreen.name: (context) => const LoginScreen(),
    RouteName.homeScreen.name: (context) => HomeScreen(),
    RouteName.purchaseHistoryScreen.name: (context) =>
        const PurchaseHistoryScreen(),
    RouteName.donationScreen.name: (context) => const DonationScreen(),
    RouteName.deliveryScreen.name: (context) => const DeliveryScreen(),
    RouteName.cartScreen.name: (context) => const CartScreen(),
    //RouteName.shippingInfoScreen.name: (context) => const ShippingInfoScreen(),
    RouteName.profileScreen.name: (context) => const ProfileScreen(),
    RouteName.uploadDeliveryScreen.name: (context) =>
        const DeliveryUploadScreen(),
  };
}
