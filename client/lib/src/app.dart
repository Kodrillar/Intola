import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intola/src/cache_repository.dart';
import 'package:intola/src/features/auth/presentation/screen/sign_up/sign_up_screen.dart';
import 'package:intola/src/features/user_onboarding/presentation/screen/onboarding_screen.dart';
import 'package:intola/src/widgets/loading_indicator.dart';

import 'features/auth/presentation/screen/log_in/log_in_screen.dart';
import 'features/cart/presentation/screen/cart_screen.dart';
import 'features/delivery/presentation/screen/delivery_screen.dart';
import 'features/delivery/presentation/upload_delivery_screen.dart';
import 'features/donation/presentation/screens/donation_product_screen.dart';
import 'features/donation/presentation/screens/donation_screen.dart';
import 'features/home/presentation/screen/home_screen.dart';
import 'features/profile/presentation/screens/profile_screen.dart';
import 'features/purchase/presentation/screens/purchase_history_screen.dart';
import 'features/shipping/presentation/screens/shipping_info_screen.dart';

class IntolaApp extends ConsumerWidget {
  const IntolaApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final initialScreen = ref.watch(getInitialScreenProvider);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Intola',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
        appBarTheme: const AppBarTheme(
          systemOverlayStyle: SystemUiOverlayStyle.dark,
        ),
      ),
      home: initialScreen.when(
        data: (data) => data,
        loading: () => const LoadingIndicator(),
        error: (error, stackTrace) => ErrorWidget(error),
      ),
      routes: {
        OnboardingScreen.id: (context) => OnboardingScreen(),
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
