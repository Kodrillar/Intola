import 'package:flutter/material.dart';
import 'package:intola/src/features/donation/domain/model/donation_model.dart';
import 'package:intola/src/utils/constant.dart';
import 'package:intola/src/utils/validation_error_text.dart';
import 'package:intola/src/widgets/alert_dialog.dart';
import 'package:intola/src/widgets/app_bar_with_back_arrow.dart';
import 'package:intola/src/widgets/buttons/custom_round_button.dart';
import 'package:intola/src/widgets/text_field.dart';

class DonationShippingInfoScreen extends StatefulWidget {
  const DonationShippingInfoScreen({Key? key, required this.donation})
      : super(key: key);

  final DonationModel donation;

  @override
  _DonationShippingInfoScreenState createState() =>
      _DonationShippingInfoScreenState();
}

class _DonationShippingInfoScreenState
    extends State<DonationShippingInfoScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController addressController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController zipCodeController = TextEditingController();

  Future<void> _addPurchaseHistory() async {
    if (_formKey.currentState!.validate()) {
      CustomAlertDialog.showAlertDialog(
        context: context,
        title: 'Not implemented yet',
        content: 'coming soon...',
      );

      //add to purchase history then show alert dialog on success
      // CustomAlertDialog.showAlertDialog(
      //         title: "Your order is on the way",
      //         content: "Shipping address added successfully!",
      //         context: context)
      //     .whenComplete(
      //   () => Navigator.pushNamedAndRemoveUntil(
      //       context, RouteName.homeScreen.name, (route) => false),
      // );
    }
  }

  //Future<void> _updateDonationSpots() async {}

  @override
  void dispose() {
    addressController.dispose();
    countryController.dispose();
    cityController.dispose();
    phoneController.dispose();
    zipCodeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWithBackArrow(title: "Shipping Infomation"),
      bottomNavigationBar: DonationShippingInfoScreenBottomAppBar(
          addPurchaseHistory: _addPurchaseHistory),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              CustomTextField(
                controller: addressController,
                hintText: "Address",
                labelText: "Address",
                validator: (value) {
                  if (value!.trim().isEmpty) {
                    return ValidationErrorMessage.addressError.message;
                  }
                  return null;
                },
              ),
              CustomTextField(
                controller: cityController,
                hintText: "City",
                labelText: "City",
                validator: (value) {
                  if (value!.trim().isEmpty) {
                    return ValidationErrorMessage.cityError.message;
                  }
                  return null;
                },
              ),
              CustomTextField(
                controller: countryController,
                hintText: "Country",
                labelText: "Country",
                validator: (value) {
                  if (value!.trim().isEmpty) {
                    return ValidationErrorMessage.countryError.message;
                  }
                  return null;
                },
              ),
              CustomTextField(
                controller: phoneController,
                hintText: "Phone",
                labelText: "Phone",
                validator: (value) {
                  if (value!.trim().isEmpty) {
                    return ValidationErrorMessage.phoneError.message;
                  }
                  return null;
                },
              ),
              CustomTextField(
                controller: zipCodeController,
                hintText: "Zip code",
                labelText: "Zip code",
                validator: (value) {
                  if (value!.trim().isEmpty) {
                    return ValidationErrorMessage.zipcodeError.message;
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DonationShippingInfoScreenBottomAppBar extends StatelessWidget {
  const DonationShippingInfoScreenBottomAppBar(
      {Key? key, required this.addPurchaseHistory})
      : super(key: key);
  final Future<void> Function() addPurchaseHistory;

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      elevation: 0,
      child: SizedBox(
        height: 120,
        child: Center(
          child: CustomRoundButton(
            onTap: addPurchaseHistory,
            buttonText: "Done",
            buttonColor: kDarkBlue,
          ),
        ),
      ),
    );
  }
}
