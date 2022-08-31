import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intola/src/models/purchase_history_model.dart';
import 'package:intola/src/repositories/purchase/purchase_repository.dart';
import 'package:intola/src/utils/network/api.dart';
import 'package:intola/src/widgets/bottom_navigation_bar.dart';

import '../utils/constant.dart';
import '../widgets/alert_dialog.dart';

PurchaseRepository _purchaseRepository = PurchaseRepository();

class PurchaseHistoryScreen extends StatefulWidget {
  static const id = "/purchaseHistoryScreen";
  const PurchaseHistoryScreen({Key? key}
      // {this.email, this.image, this.name}
      )
      : super(key: key);

  // final email;
  // final image;
  // final name;

  @override
  _PurchaseHistoryScreenState createState() => _PurchaseHistoryScreenState();
}

class _PurchaseHistoryScreenState extends State<PurchaseHistoryScreen> {
  var purchaseData;

  Future<List<PurchaseHistoryModel>> getPurchase() async {
    try {
      purchaseData = await _purchaseRepository.getPurchaseHistory(
        endpoint: endpoints["getPurchase"],
      );
    } on SocketException {
      alertDialog(
        context: context,
        title: "Network Error",
        content: "Unable to connect to the internet!",
      );
    } catch (ex) {
      // alertDialog(
      //   context: context,
      //   title: "An Error occured!",
      //   content: "Contact support team",
      // );
    }

    return purchaseData;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      bottomNavigationBar: const CustomBottomNavigationBar(),
      body: RefreshIndicator(
        onRefresh: getPurchase,
        child: FutureBuilder<List<PurchaseHistoryModel>>(
          future: getPurchase(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var data = snapshot.data;
              return _buildPurchases(data!);
            }
            if (snapshot.hasError) {
              return _buildErrorWidget();
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }

  _buildErrorWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            child: Icon(
              Icons.error,
              color: kDarkBlue.withOpacity(.35),
              size: 100,
            ),
            height: 150,
          ),
          const Text(
            "No purchase(s)! ",
            style: kAppBarTextStyle,
          ),
          const SizedBox(height: 5),
          const Text(
            "Shop items and track \ndelivery status here.",
            style: kAppBarTextStyle,
          ),
        ],
      ),
    );
  }

  _buildPurchases(List<PurchaseHistoryModel> data) {
    return ListView.builder(
      itemCount: data.length,
      itemBuilder: (context, index) => _buildPurchaseBar(
        productName: data[index].name,
        productImage: data[index].image,
        productStatus: data[index].status,
        date: data[index].date,
      ),
    );
  }

  _getDateInTimeAgo(String date) {
    var productDate = DateTime.parse(date);
    DateTime currentDate = DateTime.now();
    var dateDifference = currentDate.difference(productDate);

    int dayAgo = dateDifference.inDays;
    int hourAgo = dateDifference.inHours;
    int minuteAgo = dateDifference.inMinutes;
    int secondAgo = dateDifference.inSeconds;

    if (dayAgo >= 1) {
      return "$dayAgo day(s) ago";
    } else if (hourAgo >= 1) {
      return "$hourAgo hour(s) ago";
    } else if (minuteAgo >= 1) {
      return "$minuteAgo minute(s) ago";
    } else if (secondAgo >= 1) {
      return "$secondAgo second(s) ago";
    } else {
      return "just now";
    }
  }

  _buildPurchaseBar(
      {required String productName,
      required String productStatus,
      required String productImage,
      required String date}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      height: 150,
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: CachedNetworkImage(
                imageUrl: "${API.baseUrl}/uploads/$productImage",
                imageBuilder: (context, imageProvider) => Container(
                  height: 90,
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
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(productName, style: kAppBarTextStyle),
                const SizedBox(height: 10),
                Text(
                  _getDateInTimeAgo(date),
                  style: kAppBarTextStyle.copyWith(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: kDarkOrange),
                ),
              ],
            ),
          ),
          Text(
            productStatus,
            style: kAppBarTextStyle.copyWith(
              color: kDarkOrange,
              fontSize: 15.5,
            ),
          )
        ],
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      title: const Text(
        "Purchases",
        style: kAppBarTextStyle,
      ),
    );
  }
}
