import 'dart:io';
import 'dart:math';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:intola/src/features/cart/domain/model/product_item_model.dart';
import 'package:intola/src/features/donation/data/network/donation_network_helper.dart';
import 'package:intola/src/features/donation/data/repository/donation_repository.dart';
import 'package:intola/src/routing/route.dart';
import 'package:intola/src/utils/cache/secure_storage.dart';
import 'package:intola/src/utils/constant.dart';
import 'package:intola/src/utils/network/api.dart';
import 'package:intola/src/widgets/alert_dialog.dart';
import 'package:intola/src/widgets/buttons/custom_round_button.dart';
import 'package:flutterwave_standard/flutterwave.dart';
import 'package:intola/src/widgets/snack_bar.dart';

final publicKey = dotenv.env['PUBLIC_KEY'];

DonationRepository _donationRepository = DonationRepository(
    donationNetworkHelper: DonationNetworkHelper(
  secureStorage: SecureStorage(),
));

class DonationPaymentScreen extends StatefulWidget {
  const DonationPaymentScreen({
    required this.productItem,
    Key? key,
  }) : super(key: key);

  final ProductItem productItem;
  @override
  _DonationPaymentScreenState createState() => _DonationPaymentScreenState();
}

class _DonationPaymentScreenState extends State<DonationPaymentScreen> {
  String? _refText;
  String? userEmail;

  void getUserEmail() async {
    var email = await SecureStorage().read(key: "userName");
    setState(() {
      userEmail = email;
    });
  }

  Future addDonation() async {
    final productItem = widget.productItem;

    try {
      await _donationRepository.donateProduct(productItem: productItem);
    } on SocketException {
      CustomAlertDialog.showAlertDialog(
        context: context,
        title: "Network Error",
        content: "Unable to connect to the internet!",
      );
    } catch (_) {
      CustomAlertDialog.showAlertDialog(
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
    final productItem = widget.productItem;
    final product = productItem.productModel;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      height: 150,
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: 50),
              child: CachedNetworkImage(
                imageUrl: "${API.baseUrl}/uploads/${product.image}",
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
                placeholder: (context, url) => const Center(
                  child: CircularProgressIndicator(),
                ),
                errorWidget: (context, url, error) => const Center(
                  child: Icon(Icons.error, color: Colors.red),
                ),
              ),
            ),
          ),
          Text(
            "\$${product.price} X ${productItem.cartProductQuantity}",
            style: kAppBarTextStyle,
          )
        ],
      ),
    );
  }

  _buildBottomAppBar() {
    final productItem = widget.productItem;

    return BottomAppBar(
      elevation: 0,
      child: SizedBox(
        height: 180,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Total",
                    style: kProductNameStyle,
                  ),
                  Text(
                    "\$${productItem.productPrice.floor()}",
                    style: kProductNameStyle.copyWith(
                      color: kDarkOrange,
                    ),
                  )
                ],
              ),
              CustomRoundButton(
                onTap: () {
                  _handleProductPayment();
                },
                buttonText: "Pay now",
                buttonColor: kDarkBlue,
              )
            ],
          ),
        ),
      ),
    );
  }

  _handleProductPayment() async {
    final productItem = widget.productItem;

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
        publicKey: publicKey!,
        currency: "USD",
        txRef: _refText!,
        amount: productItem.productPrice.toString(),
        customer: customer,
        paymentOptions: "ussd, card, barter, payattitude",
        customization: Customization(title: "Test Payment"),
        redirectUrl: 'https://github.com/Kodrillar',
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
                  context, RouteName.homeScreen.name, (route) => false);
            },
          );
        } else {
          // Transaction not successful
          _showSnackBar(message: "Transaction Failed!");
        }
      } else {
        // User cancelled Transaction
        debugPrint("Transaction CANCELED BY USER!!!");
        _showSnackBar(message: "Transaction Failed!");
      }
    } catch (_) {
      _showSnackBar(message: "Transaction Failed!");
    }
  }

  void _showSnackBar({required String message, IconData? iconData}) {
    ScaffoldMessenger.of(context).showSnackBar(
      CustomSnackBar(
        snackBarMessage: message,
        iconData: iconData,
      ),
    );
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
        "Donation Payment ",
        style: kAppBarTextStyle,
      ),
    );
  }
}
