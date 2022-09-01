import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intola/src/features/auth/presentation/screen/log_in/log_in_screen.dart';
import 'package:intola/src/features/auth/presentation/screen/sign_up/sign_up_screen.dart';
import 'package:intola/src/features/delivery/presentation/screen/delivery_screen.dart';
import 'package:intola/src/features/delivery/presentation/upload_delivery_screen.dart';
import 'package:intola/src/features/donation/presentation/screens/donation_product_screen.dart';
import 'package:intola/src/features/donation/presentation/screens/donation_screen.dart';
import 'package:intola/src/features/home/presentation/screen/home_screen.dart';
import 'package:intola/src/features/profile/presentation/screens/profile_screen.dart';
import 'package:intola/src/features/cart/presentation/screen/cart_screen.dart';
import 'package:intola/src/features/user_onboarding/presentation/screen/onboarding_screen.dart';
import 'package:intola/src/features/shipping/presentation/screens/shipping_info_screen.dart';

import 'features/purchase/presentation/screens/purchase_history_screen.dart';

class IntolaApp extends StatelessWidget {
  const IntolaApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Intola',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
        appBarTheme: const AppBarTheme(
          systemOverlayStyle: SystemUiOverlayStyle.dark,
        ),
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
