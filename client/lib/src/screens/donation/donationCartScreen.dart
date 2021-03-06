import 'dart:io';
import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intola/src/repositories/donation/donation_repository.dart';
import 'package:intola/src/services/api.dart';
import 'package:intola/src/widgets/buttons/customButton.dart';
import '../../utils/constant.dart';
import '../../utils/secureStorage.dart';
import 'package:flutterwave_standard/flutterwave.dart';

import '../../widgets/alertDialog.dart';
import '../homeScreen.dart';

const PUBLIC_KEY = "FLWPUBK_TEST-29a3cd01a75a67bdb3ac35c87e1da9f3-X";

DonationRepository _donationRepository = DonationRepository();

class DonationCartScreen extends StatefulWidget {
  const DonationCartScreen({
    this.image,
    this.price,
    this.quantity,
    this.name,
    this.description,
  });

  final image;
  final price;
  final quantity;
  final name;
  final description;

  static const id = "/cartScreen";

  @override
  _DonationCartScreenState createState() => _DonationCartScreenState();
}

class _DonationCartScreenState extends State<DonationCartScreen> {
  String? _refText;
  String? userEmail;

  void getUserEmail() async {
    var email = await SecureStorage.storage.read(key: "userName");
    setState(() {
      userEmail = email;
    });
  }

  Future addDonation() async {
    try {
      await _donationRepository.donate(
        endpoint: endpoints["donate"],
        email: userEmail,
        image: widget.image,
        price: widget.price,
        description: widget.description,
        name: widget.name,
        quantity: widget.quantity.toString(),
        spotsleft: widget.quantity.toString(),
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

  void setRef() {
    var randomNum = Random().nextInt(112300);
    if (Platform.isAndroid) {
      setState(() {
        _refText = "AndroidRef294$randomNum+393";
      });
    } else {
      setState(() {
        _refText = "IosRef283$randomNum+278";
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
      body: _buildCartBar(),
    );
  }

  _buildCartBar() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      height: 150,
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: 50),
              child: CachedNetworkImage(
                imageUrl: "${API.baseUrl}/uploads/${widget.image}",
                imageBuilder: (context, imageProvider) => Container(
                  height: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: kDarkOrange.withOpacity(.08),
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                placeholder: (context, url) => Center(
                  child: CircularProgressIndicator(),
                ),
                errorWidget: (context, url, error) => Center(
                  child: Icon(Icons.error, color: Colors.red),
                ),
              ),
            ),
          ),
          Text(
            "\$${widget.price} X ${widget.quantity}",
            style: kAppBarTextStyle,
          )
        ],
      ),
    );
  }

  _buildBottomAppBar() {
    var totalPrice = double.parse(widget.price) * widget.quantity;

    return BottomAppBar(
      elevation: 0,
      child: Container(
        height: 180,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Total",
                    style: kProductNameStyle,
                  ),
                  Text(
                    "\$${totalPrice.floor()}",
                    style: kProductNameStyle.copyWith(
                      color: kDarkOrange,
                    ),
                  )
                ],
              ),
              CustomButton(
                onTap: () {
                  _handleProductPayment(price: totalPrice);
                },
                buttonName: "Pay now",
                buttonColor: kDarkBlue,
              )
            ],
          ),
        ),
      ),
    );
  }

  _handleProductPayment({required price}) async {
    try {
      final style = FlutterwaveStyle(
        appBarText: "Secured by Flutterwave",
        buttonColor: kDarkOrange,
        appBarTitleTextStyle: kAppBarTextStyle.copyWith(color: Colors.white),
        appBarIcon: Icon(Icons.message, color: kDarkBlue),
        buttonTextStyle:
            kAppBarTextStyle.copyWith(fontSize: 18, color: kDarkBlue),
        appBarColor: kDarkBlue,
        dialogCancelTextStyle: TextStyle(
          color: kDarkOrange,
          fontSize: 18,
        ),
        dialogContinueTextStyle: TextStyle(
          color: kDarkBlue,
          fontSize: 18,
        ),
      );
      final Customer customer = Customer(
        name: userEmail!,
        phoneNumber: "1234566677777",
        email: userEmail!,
      );

      final Flutterwave flutterwave = Flutterwave(
        context: context,
        style: style,
        publicKey: PUBLIC_KEY,
        currency: "USD",
        txRef: _refText!,
        amount: price.toString(),
        customer: customer,
        paymentOptions: "ussd, card, barter, payattitude",
        customization: Customization(title: "Test Payment"),
        isTestMode: true,
      );

      final ChargeResponse response = await flutterwave.charge();
      if (response != null) {
        if (response.success!) {
          _showSnackBar(
            message: "Transaction successful",
            iconData: Icons.verified_rounded,
          );

          //add to donation screen
          addDonation().whenComplete(
            () {
              Navigator.pushNamedAndRemoveUntil(
                  context, HomeScreen.id, (route) => false);
            },
          );
        } else {
          // Transaction not successful
          _showSnackBar(message: "Transaction Failed!");
        }
      } else {
        // User cancelled
        print("Transaction CANCELED BY USER!!!");
        _showSnackBar(message: "Transaction Failed!");
      }
    } catch (_) {
      _showSnackBar(message: "Transaction Failed!");
    }
  }

  void _showSnackBar({required String message, IconData? iconData}) {
    var _snackBar = SnackBar(
      content: Row(
        children: [
          Icon(iconData ?? Icons.error, color: kDarkOrange),
          SizedBox(width: 5),
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
        icon: Icon(Icons.arrow_back_ios),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      title: Text(
        "Donation Cart ",
        style: kAppBarTextStyle,
      ),
    );
  }
}
