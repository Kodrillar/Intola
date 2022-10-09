import 'dart:io';
import 'package:flutter/material.dart';
import 'package:intola/src/features/delivery/domain/model/delivery_model.dart';
import 'package:intola/src/features/delivery/data/repository/delivery_repository.dart';
import 'package:intola/src/features/delivery/presentation/delivery_app_bar.dart';
import 'package:intola/src/utils/network/api.dart';
import 'package:intola/src/widgets/alert_dialog.dart';
import 'package:intola/src/widgets/bottom_navigation_bar.dart';
import 'package:intola/src/features/delivery/presentation/delivery_card.dart';
import 'package:intola/src/widgets/error_display.dart';

DeliveryRepository _deliveryRepository = DeliveryRepository();

class DeliveryScreen extends StatefulWidget {
  static const id = "/deliveryScreen";
  const DeliveryScreen({Key? key}) : super(key: key);

  @override
  _DeliveryScreenState createState() => _DeliveryScreenState();
}

class _DeliveryScreenState extends State<DeliveryScreen> {
  var deliveryData;
  Future<List<DeliveryModel>> getDelivery() async {
    try {
      deliveryData = await _deliveryRepository.getDelivery(
          endpoint: endpoints["getDelivery"]);
    } on SocketException {
      CustomAlertDialog.showAlertDialog(
        context: context,
        title: "Network Error",
        content: "Unable to connect to the internet!",
      );
    } catch (ex) {
      CustomAlertDialog.showAlertDialog(
        context: context,
        title: "Oops! something went wrong.",
        content: "Contact support team",
      );
    }

    return deliveryData;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const DeliveryScreenAppBar(),
      bottomNavigationBar: const CustomBottomNavigationBar(),
      body: FutureBuilder<List<DeliveryModel>>(
        future: getDelivery(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return DeliveryScreenCards(
              data: snapshot.data!,
            );
          }

          if (snapshot.hasError) {
            return ErrorDisplayWidget(
              errorMessage: snapshot.error.toString(),
            );
          }
          return const Center(
            child: CircularProgressIndicator.adaptive(),
          );
        },
      ),
    );
  }
}

class DeliveryScreenCards extends StatelessWidget {
  const DeliveryScreenCards({Key? key, required this.data}) : super(key: key);
  final List<DeliveryModel> data;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: data.length,
      itemBuilder: (context, index) => DeliveryCard(
        email: data[index].email,
        contact: data[index].contact,
        deliveryImage: data[index].image,
        deliveryWeight: data[index].weight,
        deliveryPrice: data[index].price,
        description: data[index].description,
        location: data[index].location,
      ),
    );
  }
}
