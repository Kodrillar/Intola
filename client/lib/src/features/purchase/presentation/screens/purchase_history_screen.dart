import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intola/src/features/purchase/domain/model/purchase_history_model.dart';
import 'package:intola/src/features/purchase/data/repository/purchase_repository.dart';
import 'package:intola/src/features/purchase/presentation/purchase_history_app_bar.dart';
import 'package:intola/src/features/purchase/presentation/purchase_history_screen_bar.dart';
import 'package:intola/src/utils/network/api.dart';
import 'package:intola/src/widgets/alert_dialog.dart';
import 'package:intola/src/widgets/bottom_navigation_bar.dart';
import 'package:intola/src/widgets/error_display.dart';

PurchaseRepository _purchaseRepository = PurchaseRepository();

class PurchaseHistoryScreen extends StatefulWidget {
  const PurchaseHistoryScreen({Key? key}) : super(key: key);

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
      showAlertDialog(
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
      appBar: const PurchaseHistoryAppBar(),
      bottomNavigationBar: const CustomBottomNavigationBar(),
      body: RefreshIndicator(
        onRefresh: getPurchase,
        child: FutureBuilder<List<PurchaseHistoryModel>>(
          future: getPurchase(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var data = snapshot.data;
              return PurchaseHistory(data: data!);
            }
            if (snapshot.hasError) {
              debugPrint(snapshot.error.toString());
              return ErrorDisplayWidget(
                errorMessage: snapshot.error.toString(),
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}

class PurchaseHistory extends StatelessWidget {
  const PurchaseHistory({
    Key? key,
    required this.data,
  }) : super(key: key);
  final List<PurchaseHistoryModel> data;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: data.length,
      itemBuilder: (context, index) => PurchaseHistoryScreenBar(
        productName: data[index].name,
        productImage: data[index].image,
        productStatus: data[index].status!,
        date: data[index].date!,
      ),
    );
  }
}
