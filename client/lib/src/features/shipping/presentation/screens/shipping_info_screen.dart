import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intola/src/features/shipping/presentation/shipping_info_app_bar.dart';
import 'package:intola/src/features/shipping/presentation/shipping_info_bottom_app_bar.dart';
import 'package:intola/src/features/shipping/presentation/shipping_info_screen_controller.dart';
import 'package:intola/src/routing/route.dart';
import 'package:intola/src/utils/text_field_validator.dart';
import 'package:intola/src/widgets/loading_indicator.dart';
import 'package:intola/src/widgets/snack_bar.dart';
import 'package:intola/src/widgets/text_field.dart';
import 'package:intola/src/widgets/async_value_display.dart';

class ShippingInfoScreen extends ConsumerStatefulWidget {
  const ShippingInfoScreen({Key? key}) : super(key: key);

  @override
  _ShippingInfoScreenState createState() => _ShippingInfoScreenState();
}

class _ShippingInfoScreenState extends ConsumerState<ShippingInfoScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController addressController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController apartmentController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController zipCodeController = TextEditingController();

  void _showSnackBar({required String message}) {
    ScaffoldMessenger.of(context).showSnackBar(
      CustomSnackBar(snackBarMessage: message),
    );
  }

  void processPayment() {
    if (_formKey.currentState!.validate()) {
      ref
          .read(shippingInfoScreenControllerProvider.notifier)
          .processProductPayment(
            context: context,
            onPurchaseComplete: () => Navigator.of(context)
                .pushNamedAndRemoveUntil(
                    RouteName.homeScreen.name, (route) => false),
          );
    } else {
      _showSnackBar(
        message: "Fields not marked \nas 'optional' can't be empty!",
      );
    }
  }

  @override
  void dispose() {
    addressController.dispose();
    countryController.dispose();
    cityController.dispose();
    phoneController.dispose();
    zipCodeController.dispose();
    apartmentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(shippingInfoScreenControllerProvider);
    ref.listen<AsyncValue>(
      shippingInfoScreenControllerProvider,
      (previouState, newState) => newState.showErrorAlertDialog(context),
    );

    return state.isLoading
        ? const LoadingIndicator()
        : Scaffold(
            appBar: const ShippingInfoAppBar(),
            bottomNavigationBar:
                ShippingInfoBottomAppBar(onTap: processPayment),
            body: Form(
              //TODO: abstract form
              autovalidateMode: AutovalidateMode.onUserInteraction,
              key: _formKey,
              child: Scrollbar(
                thumbVisibility: true,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      CustomTextField(
                        controller: addressController,
                        hintText: "e.g. No. 3 jacob street, Nashville, U.S.",
                        labelText: "Address",
                        //TODO: Improve textfield validations
                        validator: TextFieldValidator.validateAddressField,
                      ),
                      CustomTextField(
                        controller: apartmentController,
                        hintText: "Apartment suite (optional)",
                        labelText: "Apartment suite",
                      ),
                      CustomTextField(
                        controller: cityController,
                        hintText: "e.g. Mumbai",
                        labelText: "City",
                        validator: TextFieldValidator.validateCityField,
                      ),
                      CustomTextField(
                        controller: countryController,
                        hintText: "e.g. Uganda",
                        labelText: "Country",
                        validator: TextFieldValidator.validateCountryField,
                      ),
                      CustomTextField(
                        controller: phoneController,
                        hintText: "Phone",
                        labelText: "Phone",
                        validator: TextFieldValidator.validatePhoneField,
                        keyboardType: TextInputType.number,
                      ),
                      CustomTextField(
                        controller: zipCodeController,
                        hintText: "Zip code",
                        labelText: "Zip code",
                        validator: TextFieldValidator.validateZipCodeField,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}
