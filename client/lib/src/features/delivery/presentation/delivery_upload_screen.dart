import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intola/src/features/delivery/presentation/delivery_upload_screen_controller.dart';
import 'package:intola/src/features/home/data/home_repository.dart';
import 'package:intola/src/utils/constant.dart';
import 'package:intola/src/utils/validation_error_text.dart';
import 'package:intola/src/widgets/alert_dialog.dart';
import 'package:intola/src/widgets/app_bar_with_back_arrow.dart';
import 'package:intola/src/widgets/async_value_display.dart';
import 'package:intola/src/widgets/buttons/custom_round_button.dart';
import 'package:intola/src/widgets/text_field.dart';

class DeliveryUploadScreen extends ConsumerStatefulWidget {
  const DeliveryUploadScreen({Key? key}) : super(key: key);

  @override
  _DeliveryUploadScreenState createState() => _DeliveryUploadScreenState();
}

class _DeliveryUploadScreenState extends ConsumerState<DeliveryUploadScreen> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController descriptionController = TextEditingController();
  TextEditingController pickUpController = TextEditingController();
  TextEditingController contactController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController weightController = TextEditingController();

  String get weight => weightController.text.trim();
  String get contact => contactController.text.trim();
  String get location => pickUpController.text.trim();
  String get price => priceController.text.trim();
  String get description => descriptionController.text.trim();

  Future<void> updateImagePath(ImageSource source) async {
    final pickedImage =
        await ImagePicker().pickImage(source: source).whenComplete(
              () => Navigator.pop(context),
            );
    if (pickedImage != null) {
      ref.read(deliveryUploadScreenControllerProvider.notifier).updateImagePath(
            imagePath: pickedImage.path,
          );
    }
  }

  Future<void> addDelivery() async {
    if (_formKey.currentState!.validate()) {
      final navigator = Navigator.of(context);
      final bool uploadIsSuccessful = await ref
          .read(deliveryUploadScreenControllerProvider.notifier)
          .addDelivery(
            weight: weight,
            price: price,
            description: description,
            location: location,
            contact: contact,
          );

      if (uploadIsSuccessful) {
        CustomAlertDialog.showAlertDialog(
                context: context,
                title: 'Delivery Upload',
                content: 'Delivery uploaded successfully!')
            .whenComplete(() {
          ref.read(bottomNavigationBarIndexProvider.notifier).state = 0;
          navigator.pop();
        });
      }
    }
  }

  @override
  void dispose() {
    weightController.dispose();
    priceController.dispose();
    pickUpController.dispose();
    contactController.dispose();
    descriptionController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<AsyncValue<void>>(
      deliveryUploadScreenControllerProvider
          .select((value) => value.asyncValue),
      (previousState, newState) => newState.showErrorAlertDialog(context),
    );
    return Scaffold(
      appBar: const AppBarWithBackArrow(title: "Upload goods"),
      bottomNavigationBar: DeliveryUploadBottomAppBar(
          onPressedOfBottomAppBarButton: () => addDelivery()),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              DeliveryUploadImageSection(
                onPressedOfCameraIcon: () =>
                    updateImagePath(ImageSource.camera),
                onPressedOfGalleryIcon: () =>
                    updateImagePath(ImageSource.gallery),
              ),
              CustomTextField(
                controller: descriptionController,
                hintText: "description",
                labelText: "description",
                validator: (value) {
                  if (value!.trim().isEmpty) {
                    return ValidationErrorMessage.descriptionError.message;
                  }
                  return null;
                },
              ),
              CustomTextField(
                controller: pickUpController,
                hintText: "pick up location",
                labelText: "pick up location",
                validator: (value) {
                  if (value!.trim().isEmpty) {
                    return ValidationErrorMessage.pickupError.message;
                  }
                  return null;
                },
              ),
              CustomTextField(
                controller: contactController,
                hintText: "contact",
                labelText: "contact",
                validator: (value) {
                  if (value!.trim().isEmpty) {
                    return ValidationErrorMessage.contactError.message;
                  }
                  return null;
                },
              ),
              CustomTextField(
                controller: priceController,
                hintText: "price",
                labelText: "price",
                validator: (value) {
                  if (value!.trim().isEmpty) {
                    return ValidationErrorMessage.priceError.message;
                  } else if (value.length > 8) {
                    return "Max price exceeded";
                  }

                  return null;
                },
              ),
              CustomTextField(
                controller: weightController,
                hintText: "weight",
                labelText: "weight",
                validator: (value) {
                  if (value!.trim().isEmpty) {
                    return ValidationErrorMessage.weightError.message;
                  } else if (value.length > 8) {
                    return "Max weight exceeded";
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

class DeliveryUploadBottomAppBar extends ConsumerWidget {
  const DeliveryUploadBottomAppBar(
      {Key? key, required this.onPressedOfBottomAppBarButton})
      : super(key: key);

  final void Function() onPressedOfBottomAppBarButton;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(deliveryUploadScreenControllerProvider);
    return BottomAppBar(
      elevation: 0,
      child: SizedBox(
        height: 90,
        child: Center(
          child: state.asyncValue.isLoading
              ? const CircularProgressIndicator.adaptive()
              : CustomRoundButton(
                  onTap: onPressedOfBottomAppBarButton,
                  buttonText: "Upload",
                  buttonColor: kDarkBlue,
                ),
        ),
      ),
    );
  }
}

class DeliveryUploadImageSection extends ConsumerWidget {
  const DeliveryUploadImageSection({
    Key? key,
    required this.onPressedOfCameraIcon,
    required this.onPressedOfGalleryIcon,
  }) : super(key: key);
  final void Function() onPressedOfGalleryIcon;
  final void Function() onPressedOfCameraIcon;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(deliveryUploadScreenControllerProvider);
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          context: context,
          builder: (context) => DeliveryUploadImageBottomSheet(
            onPressedOfCameraIcon: onPressedOfCameraIcon,
            onPressedOfGalleryIcon: onPressedOfGalleryIcon,
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.all(16),
        height: 200,
        child: Center(
          child: Text(
            "Tap to upload Image",
            style: kAppBarTextStyle.copyWith(
              color: kDarkBlue.withOpacity(
                .4,
              ),
            ),
          ),
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: kDarkOrange.withOpacity(.17),
          border: Border.all(color: kDarkOrange),
          image: DecorationImage(
            image: state.imagePath == null
                ? const AssetImage('assets/images/whitebg.png')
                : FileImage(File(state.imagePath!)) as ImageProvider,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}

class DeliveryUploadImageBottomSheet extends StatelessWidget {
  const DeliveryUploadImageBottomSheet(
      {Key? key,
      required this.onPressedOfCameraIcon,
      required this.onPressedOfGalleryIcon})
      : super(key: key);

  final void Function() onPressedOfGalleryIcon;
  final void Function() onPressedOfCameraIcon;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      color: kLightColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          InkWell(
            highlightColor: kDarkBlue,
            onTap: onPressedOfGalleryIcon,
            child: Row(
              children: [
                const Icon(
                  Icons.image,
                  color: kDarkOrange,
                ),
                Text(
                  "Gallery",
                  style: kAppBarTextStyle.copyWith(
                      fontSize: 15, fontWeight: FontWeight.normal),
                )
              ],
            ),
          ),
          InkWell(
            onTap: onPressedOfCameraIcon,
            child: Row(
              children: [
                const Icon(
                  Icons.camera,
                  color: kDarkOrange,
                ),
                Text(
                  "Camera",
                  style: kAppBarTextStyle.copyWith(
                      fontSize: 15, fontWeight: FontWeight.normal),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
