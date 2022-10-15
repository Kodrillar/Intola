import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intola/src/features/payment/application/payment_service.dart';
import 'package:intola/src/features/shipping/presentation/shipping_info_app_bar.dart';
import 'package:intola/src/features/shipping/presentation/shipping_info_bottom_app_bar.dart';
import 'package:intola/src/utils/validation_error_text.dart';
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
    final state = ref.watch(paymentServiceProvider);
    ref.listen<AsyncValue>(
      paymentServiceProvider,
      (previouState, newState) => newState.showErrorAlertDialog(context),
    );

    void _showSnackBar({required String message}) {
      ScaffoldMessenger.of(context).showSnackBar(
        CustomSnackBar(snackBarMessage: message),
      );
    }

    void processPayment() {
      if (_formKey.currentState!.validate()) {
        ref
            .read(paymentServiceProvider.notifier)
            .processProductPayment(context);
      } else {
        _showSnackBar(
          message: "Fields not marked \nas 'optional' can't be empty!",
        );
      }
    }

    return state.isLoading
        ? const LoadingIndicator()
        : Scaffold(
            appBar: const ShippingInfoAppBar(),
            bottomNavigationBar:
                ShippingInfoBottomAppBar(onTap: processPayment),
            body: Form(
              key: _formKey,
              child: Scrollbar(
                thumbVisibility: true,
                child: SingleChildScrollView(
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
                        controller: apartmentController,
                        hintText: "Apartment suite(optional)",
                        labelText: "Apartment suite",
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
            ),
          );
  }
}
