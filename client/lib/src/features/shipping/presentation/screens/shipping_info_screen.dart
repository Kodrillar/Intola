import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:intola/src/features/purchase/data/network/purchase_network_helper.dart';
import 'package:intola/src/features/purchase/data/repository/purchase_repository.dart';
import 'package:intola/src/features/shipping/presentation/shipping_info_app_bar.dart';
import 'package:intola/src/features/shipping/presentation/shipping_info_bottom_app_bar.dart';
import 'package:intola/src/routing/route.dart';
import 'package:intola/src/utils/network/api.dart';
import 'package:intola/src/utils/cache/secure_storage.dart';
import 'package:intola/src/widgets/snack_bar.dart';
import 'package:intola/src/widgets/text_field.dart';
import 'package:flutterwave_standard/flutterwave.dart';

import '../../../../utils/constant.dart';
import '../../../../widgets/alert_dialog.dart';

const publicKey = "FLWPUBK_TEST-29a3cd01a75a67bdb3ac35c87e1da9f3-X";

PurchaseHistoryRepository _purchaseRepository = PurchaseHistoryRepository(
    purchaseHistoryNetworkHelper: PurchaseHistoryNetworkHelper());

class ShippingInfoScreen extends StatefulWidget {
  const ShippingInfoScreen({
    Key? key,
    required this.price,
    required this.image,
    required this.name,
  }) : super(key: key);

  final double price;
  final String image;
  final String name;

  @override
  _ShippingInfoScreenState createState() => _ShippingInfoScreenState();
}

class _ShippingInfoScreenState extends State<ShippingInfoScreen> {
  String? _refText;
  String? userEmail;

  TextEditingController addressController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController apartmentController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController zipCodeController = TextEditingController();

  Future addPurchaseHistory() async {
    try {
      await _purchaseRepository.addPurchaseHistory(
        endpoint: endpoints["addPurchase"],
        email: userEmail,
        image: widget.image,
        name: widget.name,
      );
    } on SocketException {
      showAlertDialog(
        context: context,
        title: "Network Error",
        content: "Unable to connect to the internet!",
      );
    } catch (_) {
      showAlertDialog(
        context: context,
        title: "Oops! something went wrong.",
        content: "Contact support team",
      );
    }
  }

  void getUserEmail() async {
    var email = await SecureStorage.storage.read(key: "userName");
    setState(() {
      userEmail = email;
    });
  }

  void setRef() {
    var randomNum = Random().nextInt(110300);
    if (Platform.isAndroid) {
      setState(() {
        _refText = "AndroidRef294$randomNum/393";
      });
    } else {
      setState(() {
        _refText = "IosRef283$randomNum/278";
      });
    }
  }

  @override
  void initState() {
    getUserEmail();
    setRef();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const ShippingInfoAppBar(),
      bottomNavigationBar:
          ShippingInfoBottomAppBar(onTap: validateAndHandlePayment),
      body: ListView(
        children: [
          CustomTextField(
            controller: addressController,
            hintText: "Address",
            labelText: "Address",
          ),
          CustomTextField(
            controller: apartmentController,
            hintText: "Apartment suite(optional)",
            labelText: "Apartment suite",
          ),
          CustomTextField(
            controller: cityController,
            hintText: "City",
            labelText: "City",
          ),
          CustomTextField(
            controller: countryController,
            hintText: "Country",
            labelText: "Country",
          ),
          CustomTextField(
            controller: phoneController,
            hintText: "Phone",
            labelText: "Phone",
          ),
          CustomTextField(
            controller: zipCodeController,
            hintText: "Zip code",
            labelText: "Zip code",
          ),
        ],
      ),
    );
  }

  _handleProductPayment() async {
    try {
      final style = FlutterwaveStyle(
          appBarText: "Secured by Flutterwave",
          buttonColor: kDarkOrange,
          appBarTitleTextStyle: kAppBarTextStyle.copyWith(color: Colors.white),
          appBarIcon: const Icon(Icons.message, color: kDarkBlue),
          buttonTextStyle:
              kAppBarTextStyle.copyWith(fontSize: 18, color: kDarkBlue),
          appBarColor: kDarkBlue,
          dialogCancelTextStyle: const TextStyle(
            color: kDarkOrange,
            fontSize: 18,
          ),
          dialogContinueTextStyle: const TextStyle(
            color: kDarkBlue,
            fontSize: 18,
          ));
      final Customer customer = Customer(
        name: userEmail!,
        phoneNumber: "1234566677777",
        email: userEmail!,
      );

      final Flutterwave flutterwave = Flutterwave(
        context: context,
        style: style,
        publicKey: publicKey,
        currency: "USD",
        txRef: _refText!,
        amount: widget.price.toString(),
        customer: customer,
        paymentOptions: "ussd, card, barter, payattitude",
        customization: Customization(title: "Test Payment"),
        isTestMode: true,
        redirectUrl: 'https://github.com/Kodrillar',
      );

      final ChargeResponse response = await flutterwave.charge();
      if (response != null) {
        if (response.success!) {
          debugPrint("Transaction succeeded!!!");
          _showSnackBar(
            message: "Transaction successful",
            iconData: Icons.verified_rounded,
          );

          addPurchaseHistory()
              .then(
            (value) => debugPrint("value from Future addingpuchase" + value),
          )
              .whenComplete(() {
            Navigator.pushNamedAndRemoveUntil(
                context, RouteName.homeScreen.name, (route) => false);
          });
        } else {
          // Transaction not successful
          _showSnackBar(message: "Transaction Failed!");
        }
      } else {
        // User cancelled transaction
        debugPrint("Transaction CANCELED BY USER!!!");
        _showSnackBar(message: "Transaction Failed!");
      }
    } catch (_) {
      _showSnackBar(message: "Transaction Failed!");
    }
  }

  void validateAndHandlePayment() {
    if (addressController.text.trim().isEmpty ||
        cityController.text.trim().isEmpty ||
        countryController.text.trim().isEmpty ||
        phoneController.text.trim().isEmpty ||
        zipCodeController.text.trim().isEmpty) {
      _showSnackBar(
        message: "Fields not marked \nas 'optional' can't be empty!",
      );
    } else {
      _handleProductPayment();
    }
  }

  void _showSnackBar({required String message, IconData? iconData}) {
    ScaffoldMessenger.of(context).showSnackBar(
      customSnackBar(snackBarMessage: message),
    );
  }
}
