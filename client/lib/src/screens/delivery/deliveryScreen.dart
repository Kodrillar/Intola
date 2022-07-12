import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intola/src/models/deliveryModel.dart';
import 'package:intola/src/repositories/delivery/delivery_repository.dart';
import 'package:intola/src/screens/delivery/uploadDeliveryScreen.dart';
import 'package:intola/src/utils/constant.dart';
import 'package:intola/src/widgets/bottomNavigationBar.dart';
import 'package:intola/src/widgets/deliveryCard.dart';

import '../../services/api.dart';
import '../../widgets/alertDialog.dart';

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

    return deliveryData;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      bottomNavigationBar: CustomBottomNavigationBar(),
      body: FutureBuilder<List<DeliveryModel>>(
        future: getDelivery(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return _buildDeliveryCard(snapshot.data!);
          }

          if (snapshot.hasError) {
            return _buildErrorWidget();
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  _buildDeliveryCard(List<DeliveryModel> data) {
    return ListView.builder(
      itemCount: data.length,
      itemBuilder: (context, index) => DeliveryCard(
          email: data[index].email,
          contact: data[index].contact,
          deliveryImage: data[index].image,
          deliveryWeight: data[index].weight,
          deliveryPrice: data[index].price,
          description: data[index].description,
          location: data[index].location),
    );
  }

  _buildErrorWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            child: Icon(
              Icons.error,
              color: kDarkBlue.withOpacity(.35),
              size: 100,
            ),
            height: 150,
          ),
          Center(
            child: Text(
              "Oops! Kindly check your \ninternet connection",
              style: kAppBarTextStyle,
            ),
          )
        ],
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      leading: IconButton(
        color: kDarkBlue,
        icon: Icon(Icons.add),
        onPressed: () {
          Navigator.pushNamed(context, UploadDeliveryScreen.id);
        },
      ),
      actions: [
        Center(
          child: Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Text(
              "\$0",
              style: kAppBarTextStyle,
            ),
          ),
        ),
      ],
      elevation: 0,
      backgroundColor: Colors.transparent,
      title: Text(
        "Delivery",
        style: kAppBarTextStyle,
      ),
    );
  }
}
