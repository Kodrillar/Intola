import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intola/src/repositories/donation/donation_repository.dart';
import 'package:intola/src/screens/homeScreen.dart';
import 'package:intola/src/services/api.dart';
import 'package:intola/src/utils/secureStorage.dart';
import 'package:intola/src/widgets/textField.dart';

import '../../repositories/purchase/purchase_repository.dart';
import '../../utils/constant.dart';
import '../../widgets/alertDialog.dart';
import '../../widgets/buttons/customButton.dart';

PurchaseRepository _purchaseRepository = PurchaseRepository();
DonationRepository _donationRepository = DonationRepository();

class DonationShippingInfoScreen extends StatefulWidget {
  const DonationShippingInfoScreen(
      {this.image, this.name, this.productId, this.spotsleft, this.donorEmail});

  final productId;
  final spotsleft;
  final image;
  final name;
  final donorEmail;

  static const id = "/shippingInfo";

  @override
  _DonationShippingInfoScreenState createState() =>
      _DonationShippingInfoScreenState();
}

class _DonationShippingInfoScreenState
    extends State<DonationShippingInfoScreen> {
  String? userEmail;
  var productSpotsleft;

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

  Future updateDonationSpots() async {
    productSpotsleft = int.parse(widget.spotsleft) - 1;
    try {
      await _donationRepository.updateDonationSpot(
        endpoint: endpoints["updateDonation"],
        id: widget.productId,
        email: widget.donorEmail,
        spotsleft: productSpotsleft,
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

  @override
  void initState() {
    getUserEmail();
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

  _buildBottomAppBar() {
    return BottomAppBar(
      elevation: 0,
      child: Container(
        height: 120,
        child: Center(
          child: CustomButton(
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
                addPurchaseHistory();
                updateDonationSpots();
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Row(
                        children: [
                          Icon(
                            Icons.local_shipping_rounded,
                            color: kDarkOrange,
                          ),
                          SizedBox(width: 3),
                          Text(
                            "Your order is on the way",
                            style: kAppBarTextStyle.copyWith(fontSize: 13),
                          ),
                        ],
                      ),
                      content: Text(
                        "Shipping address added successfully!",
                        style: kAppBarTextStyle.copyWith(
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      actions: [
                        IconButton(
                          onPressed: () {
                            Navigator.pushNamedAndRemoveUntil(
                                context, HomeScreen.id, (route) => false);
                          },
                          icon: Icon(Icons.done),
                        ),
                      ],
                    );
                  },
                ).whenComplete(
                  () => Navigator.pushNamedAndRemoveUntil(
                      context, HomeScreen.id, (route) => false),
                );
              }
            },
            buttonName: "Done",
            buttonColor: kDarkBlue,
          ),
        ),
      ),
    );
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
        "Shipping Infomation",
        style: kAppBarTextStyle,
      ),
    );
  }
}
