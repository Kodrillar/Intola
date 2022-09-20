import 'dart:io';
import 'package:flutter/material.dart';
import 'package:intola/src/features/donation/data/repository/donation_repository.dart';
import 'package:intola/src/features/donation/domain/model/donation_model.dart';
import 'package:intola/src/features/donation/presentation/donation_screen_app_bar.dart';
import 'package:intola/src/utils/network/api.dart';
import 'package:intola/src/widgets/alert_dialog.dart';
import 'package:intola/src/widgets/bottom_navigation_bar.dart';
import 'package:intola/src/features/donation/presentation/donation_card.dart';
import 'package:intola/src/widgets/error_display.dart';

DonationRepository _donationRepository = DonationRepository();

class DonationScreen extends StatefulWidget {
  static const id = "/donationScreen";
  const DonationScreen({Key? key}) : super(key: key);

  @override
  _DonationScreenState createState() => _DonationScreenState();
}

class _DonationScreenState extends State<DonationScreen> {
  var donationData;
  Future<List<DonationModel>> getDonations() async {
    try {
      donationData = await _donationRepository.getDonations(
          endpoint: endpoints["getDonations"]);
    } on SocketException {
      showAlertDialog(
        context: context,
        title: "Network Error",
        content: "Unable to connect to the internet!",
      );
    } catch (ex) {
      showAlertDialog(
        context: context,
        title: "Oops! something went wrong.",
        content: "Contact support team",
      );
    }

    return donationData;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const DonationScreenAppBar(),
      bottomNavigationBar: const CustomBottomNavigationBar(),
      body: FutureBuilder<List<DonationModel>>(
        future: getDonations(),
        builder: (context, snaphsot) {
          if (snaphsot.hasData) {
            var data = snaphsot.data;
            return DonationDisplayCards(data: data!);
          }
          if (snaphsot.hasError) {
            return const Center(
              child: ErrorDisplayWidget(
                errorMessage: "Oops! Kindly check your \ninternet connection",
              ),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}

class DonationDisplayCards extends StatelessWidget {
  const DonationDisplayCards({Key? key, required this.data}) : super(key: key);

  final List<DonationModel> data;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: data.length,
      itemBuilder: (context, index) => DonationCard(
        id: data[index].id,
        productImage: data[index].image,
        productPrice: data[index].price.toString(),
        productDescription: data[index].description,
        productName: data[index].name,
        productQuantity: data[index].quantity,
        email: data[index].email,
        spotsleft: data[index].spotsleft,
      ),
    );
  }
}
