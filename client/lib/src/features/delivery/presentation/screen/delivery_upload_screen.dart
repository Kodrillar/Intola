import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intola/src/features/delivery/presentation/delivery_upload_screen_controller.dart';
import 'package:intola/src/features/home/data/home_repository.dart';
import 'package:intola/src/features/home/presentation/bottom_navigation_bar.dart';
import 'package:intola/src/utils/constant.dart';
import 'package:intola/src/utils/text_field_validator.dart';
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
          ref.read(bottomNavigationBarIndexProvider.notifier).state =
              NavigationBarIndex.homeScreen.index;
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
          //TODO: abstract form
          autovalidateMode: AutovalidateMode.onUserInteraction,
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
                validator: TextFieldValidator.validatePickUpLocationField,
              ),
              CustomTextField(
                controller: contactController,
                hintText: "Phone",
                labelText: "Phone",
                validator: TextFieldValidator.validatePhoneField,
                keyboardType: TextInputType.number,
              ),
              CustomTextField(
                controller: priceController,
                hintText: "price",
                labelText: "price",
                validator: TextFieldValidator.validatePriceField,
              ),
              CustomTextField(
                controller: weightController,
                hintText: "e.g. 78",
                labelText: "weight",
                validator: TextFieldValidator.validateWeightField,
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
          BottomSheetActionButton(
            icon: Icons.image,
            title: 'Gallery',
            onPressedOfCameraIcon: onPressedOfCameraIcon,
          ),
          BottomSheetActionButton(
            title: 'Take photo',
            onPressedOfCameraIcon: onPressedOfCameraIcon,
            icon: Icons.camera,
          )
        ],
      ),
    );
  }
}

class BottomSheetActionButton extends StatelessWidget {
  const BottomSheetActionButton({
    super.key,
    required this.icon,
    required this.title,
    required this.onPressedOfCameraIcon,
  });

  final void Function() onPressedOfCameraIcon;

  final IconData icon;
  final String title;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressedOfCameraIcon,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: kDarkOrange,
          ),
          Text(
            title,
            style: kAppBarTextStyle.copyWith(
              fontSize: 12,
              fontWeight: FontWeight.normal,
            ),
          )
        ],
      ),
    );
  }
}
