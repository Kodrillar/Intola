import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:intola/src/features/home/presentation/screen/home_screen.dart';
import 'package:intola/src/features/purchase/data/repository/purchase_repository.dart';
import 'package:intola/src/utils/network/api.dart';
import 'package:intola/src/utils/cache/secure_storage.dart';
import 'package:intola/src/widgets/text_field.dart';
import 'package:flutterwave_standard/flutterwave.dart';

import '../../../../utils/constant.dart';
import '../../../../widgets/alert_dialog.dart';
import '../../../../widgets/buttons/custom_round_button.dart';

const publicKey = "FLWPUBK_TEST-29a3cd01a75a67bdb3ac35c87e1da9f3-X";

PurchaseRepository _purchaseRepository = PurchaseRepository();

class ShippingInfoScreen extends StatefulWidget {
  const ShippingInfoScreen({Key? key, this.price, this.image, this.name})
      : super(key: key);

  final price;
  final image;
  final name;

  static const id = "/shippingInfo";

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
      alertDialog(
        context: context,
        title: "Network Error",
        content: "Unable to connect to the internet!",
      );
    } catch (_) {
      alertDialog(
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
      appBar: _buildAppBar(),
      bottomNavigationBar: _buildBottomAppBar(),
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
                context, HomeScreen.id, (route) => false);
          });
        } else {
          // Transaction not successful
          _showSnackBar(message: "Transaction Failed!");
        }
      } else {
        // User cancelled
        debugPrint("Transaction CANCELED BY USER!!!");
        _showSnackBar(message: "Transaction Failed!");
      }
    } catch (_) {
      _showSnackBar(message: "Transaction Failed!");
    }
  }

  // _payNow({required BuildContext context}) async {
  //   try {
  //     Flutterwave flutterwave = Flutterwave.forUIPayment(
  //       context: this.context,
  //       encryptionKey: ENCRYPTION_KEY,
  //       publicKey: PUBLIC_KEY,
  //       currency: _currency,
  //       amount: widget.price.toString(),
  //       email: userEmail!,
  //       fullName: "Intola",
  //       txRef: _refText!,
  //       isDebugMode: true,
  //       phoneNumber: "0123456789",
  //       acceptCardPayment: true,
  //       acceptUSSDPayment: true,
  //       acceptAccountPayment: true,
  //       acceptFrancophoneMobileMoney: false,
  //       acceptGhanaPayment: false,
  //       acceptMpesaPayment: false,
  //       acceptRwandaMoneyPayment: false,
  //       acceptUgandaPayment: false,
  //       acceptZambiaPayment: false,
  //     );

  //     final ChargeResponse response =
  //         await flutterwave.initializeForUiPayments();

  //     if (response == null) {
  //       print("Transaction Failed! Try again");
  //     } else {
  //       print(response.message);
  //       print(response.status);

  //       if (response.status == "success") {
  //         _showSnackBar(
  //           message: "Transaction sucessful",
  //           iconData: Icons.verified_rounded,
  //         );

  //         addPurchaseHistory()
  //             .then(
  //           (value) => print("this is value from Future addingpuchase" + value),
  //         )
  //             .whenComplete(() {
  //           Navigator.pushNamedAndRemoveUntil(
  //               context, HomeScreen.id, (route) => false);
  //         });

  //         //add to purchase History
  //       }
  //     }
  //   } catch (error) {
  //     print("this is ERROR =>$error");
  //     _showSnackBar(message: "Transaction Failed!");
  //   }
  // }

  _buildBottomAppBar() {
    return BottomAppBar(
      elevation: 0,
      child: SizedBox(
        height: 120,
        child: Center(
          child: CustomRoundButton(
            onTap: () {
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
            },
            buttonName: "Pay now",
            buttonColor: kDarkBlue,
          ),
        ),
      ),
    );
  }

  //Abstract this to a single widget
  void _showSnackBar({required String message, IconData? iconData}) {
    var _snackBar = SnackBar(
      content: Row(
        children: [
          Icon(iconData ?? Icons.error, color: kDarkOrange),
          const SizedBox(width: 5),
          Text(message, style: kSnackBarTextStyle),
        ],
      ),
      backgroundColor: kDarkBlue,
    );

    ScaffoldMessenger.of(context).showSnackBar(_snackBar);
  }

  AppBar _buildAppBar() {
    return AppBar(
      leading: IconButton(
        color: kDarkBlue,
        icon: const Icon(Icons.arrow_back_ios),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      title: const Text(
        "Shipping Infomation",
        style: kAppBarTextStyle,
      ),
    );
  }
}
