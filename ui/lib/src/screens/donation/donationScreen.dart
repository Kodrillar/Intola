import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intola/src/models/donationModel.dart';
import 'package:intola/src/repositories/donation/donation_repository.dart';
import 'package:intola/src/services/api.dart';
import 'package:intola/src/widgets/bottomNavigationBar.dart';
import 'package:intola/src/widgets/donationCard.dart';

import '../../utils/constant.dart';
import '../../widgets/alertDialog.dart';

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

    return donationData;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      bottomNavigationBar: CustomBottomNavigationBar(),
      body: RefreshIndicator(
        onRefresh: getDonations,
        child: FutureBuilder<List<DonationModel>>(
          future: getDonations(),
          builder: (context, snaphsot) {
            if (snaphsot.hasData) {
              var data = snaphsot.data;
              return _buildDonationCard(data!);
            }
            if (snaphsot.hasError) {
              return Center(
                child: _buildErrorWidget(),
              );
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }

  _buildDonationCard(List<DonationModel> data) {
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

  AppBar _buildAppBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      title: Text(
        "Donations",
        style: kAppBarTextStyle,
      ),
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
}
