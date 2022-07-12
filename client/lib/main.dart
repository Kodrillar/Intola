import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intola/src/screens/auth/logInScreen.dart';
import 'package:intola/src/screens/cartScreen.dart';
import 'package:intola/src/screens/delivery/deliveryScreen.dart';
import 'package:intola/src/screens/donation/donationProductScreen.dart';
import 'package:intola/src/screens/donation/donationScreen.dart';
import 'package:intola/src/screens/homeScreen.dart';
import 'package:intola/src/screens/onboardingScreen.dart';
import 'package:intola/src/screens/auth/signUpScreen.dart';
import 'package:intola/src/screens/purchaseHistoryScreen.dart';
import 'package:intola/src/screens/shippingInfoScreen.dart';
import 'package:intola/src/screens/profileScreen.dart';
import 'package:intola/src/screens/delivery/uploadDeliveryScreen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown],
  );
  runApp(const IntolaApp());
}

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
        OnboardingScreen.id: (context) => OnboardingScreen(),
        SignUpScreen.id: (context) => SignUpScreen(),
        LoginScreen.id: (context) => LoginScreen(),
        HomeScreen.id: (context) => HomeScreen(),
        PurchaseHistoryScreen.id: (context) => PurchaseHistoryScreen(),
        DonationScreen.id: (context) => DonationScreen(),
        DeliveryScreen.id: (context) => DeliveryScreen(),
        CartScreen.id: (context) => CartScreen(),
        ShippingInfoScreen.id: (context) => ShippingInfoScreen(),
        ProfileScreen.id: (context) => ProfileScreen(),
        UploadDeliveryScreen.id: (context) => UploadDeliveryScreen(),
        DonationProductScreen.id: (context) => DonationProductScreen(),
      },
    );
  }
}
