import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intola/src/features/delivery/data/repository/delivery_repository.dart';
import 'package:intola/src/features/home/presentation/screen/home_screen.dart';
import 'package:intola/src/utils/network/api.dart';
import 'package:intola/src/utils/constant.dart';
import 'package:intola/src/widgets/alert_dialog.dart';
import 'package:intola/src/widgets/buttons/custom_round_button.dart';
import 'package:intola/src/widgets/text_field.dart';
import 'package:image_picker/image_picker.dart';

DeliveryRepository _deliveryRepository = DeliveryRepository();

class UploadDeliveryScreen extends StatefulWidget {
  const UploadDeliveryScreen({Key? key}) : super(key: key);

  static const id = "/uploadDeliveryScreen";

  @override
  _UploadDeliveryScreenState createState() => _UploadDeliveryScreenState();
}

class _UploadDeliveryScreenState extends State<UploadDeliveryScreen> {
  var _imageFile;
  final ImagePicker _imagePicker = ImagePicker();

  bool processingRequest = false;

  TextEditingController descriptionController = TextEditingController();
  TextEditingController pickUpController = TextEditingController();
  TextEditingController contactController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController weightController = TextEditingController();

  Future addDelivery() async {
    try {
      await _deliveryRepository.addDelivery(
        endpoint: endpoints["addDelivery"],
        weight: weightController.text.trim(),
        price: priceController.text.trim(),
        description: descriptionController.text.trim(),
        location: pickUpController.text.trim(),
        contact: contactController.text.trim(),
      );
    } on SocketException {
      setState(() {
        processingRequest = false;
      });
      alertDialog(
        context: context,
        title: "Network Error",
        content: "Unable to connect to the internet!",
      );
    } catch (ex) {
      setState(() {
        processingRequest = false;
      });

      alertDialog(
        context: context,
        title: "Oops! something went wrong.",
        content: "Contact support team",
      );
    }
  }

  Future updateProductImage() async {
    try {
      await _deliveryRepository.updateProductImage(
        endpoint: endpoints["updateDeliveryImage"],
        imagePath: _imageFile.path,
      );
    } on SocketException {
      alertDialog(
        context: context,
        title: "Network Error",
        content: "Unable to connect to the internet!",
      );
    } catch (ex) {
      alertDialog(
        context: context,
        title: "Oops! something went wrong.",
        content: "Contact support team",
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      bottomNavigationBar: _buildBottomAppBar(),
      body: ListView(
        children: [
          _buildDeliveryImage(),
          CustomTextField(
            controller: descriptionController,
            hintText: "description",
            labelText: "description",
          ),
          CustomTextField(
            controller: pickUpController,
            hintText: "pick up location",
            labelText: "pick up location",
          ),
          CustomTextField(
              controller: contactController,
              hintText: "contact",
              labelText: "contact"),
          CustomTextField(
            controller: priceController,
            hintText: "price",
            labelText: "price",
          ),
          CustomTextField(
            controller: weightController,
            hintText: "weight",
            labelText: "weight",
          ),
        ],
      ),
    );
  }

  _buildBottomAppBar() {
    return BottomAppBar(
      elevation: 0,
      child: SizedBox(
        height: 90,
        child: Center(
          child: processingRequest
              ? const CircularProgressIndicator()
              : CustomRoundButton(
                  onTap: () {
                    setState(() {
                      processingRequest = true;
                    });

                    if (descriptionController.text.trim().isEmpty ||
                        pickUpController.text.trim().isEmpty ||
                        contactController.text.trim().isEmpty ||
                        priceController.text.trim().isEmpty ||
                        weightController.text.trim().isEmpty) {
                      setState(() {
                        processingRequest = false;
                      });
                      return _showSnackBar(
                          message: "Kindly fill in all fields");
                    } else {
                      addDelivery().whenComplete(() {
                        if (_imageFile != null) {
                          updateProductImage().whenComplete(
                            () => Navigator.pushNamedAndRemoveUntil(
                                context, HomeScreen.id, (route) => false),
                          );
                        } //Later, add a default image if imagePath is null
                      });
                    }
                  },
                  buttonText: "Upload",
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
          const SizedBox(width: 5),
          Text(message, style: kSnackBarTextStyle),
        ],
      ),
      backgroundColor: kDarkBlue,
    );

    ScaffoldMessenger.of(context).showSnackBar(_snackBar);
  }

  _buildDeliveryImage() {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
            context: context, builder: (context) => showBottomSheet());
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
            image: _imageProvider(),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  ImageProvider _imageProvider() {
    if (_imageFile != null) {
      return FileImage(
        File(_imageFile.path),
      );
    } else {
      return const AssetImage("assets/images/whitebg.png");
    }
  }

  showBottomSheet() {
    return Container(
      height: 120,
      color: kLightColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          InkWell(
            highlightColor: kDarkBlue,
            onTap: () {
              getImage(ImageSource.gallery);
            },
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
            onTap: () {
              getImage(ImageSource.camera);
            },
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

  void getImage(ImageSource source) async {
    final pickedImage =
        await _imagePicker.pickImage(source: source).whenComplete(
              () => Navigator.pop(context),
            );

    setState(() {
      _imageFile = pickedImage;
    });
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
        "Upload goods",
        style: kAppBarTextStyle,
      ),
    );
  }
}
