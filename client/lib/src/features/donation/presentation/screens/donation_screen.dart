import 'dart:io';
import 'package:flutter/material.dart';
import 'package:intola/src/features/donation/data/repository/donation_repository.dart';
import 'package:intola/src/features/donation/domain/model/donation_model.dart';
import 'package:intola/src/utils/constant.dart';
import 'package:intola/src/utils/network/api.dart';
import 'package:intola/src/widgets/alert_dialog.dart';
import 'package:intola/src/widgets/bottom_navigation_bar.dart';
import 'package:intola/src/features/donation/presentation/donation_card.dart';

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
      appBar: _buildAppBar(),
      bottomNavigationBar: const CustomBottomNavigationBar(),
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
            return const Center(
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
      title: const Text(
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
          SizedBox(
            child: Icon(
              Icons.error,
              color: kDarkBlue.withOpacity(.35),
              size: 100,
            ),
            height: 150,
          ),
          const Center(
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
