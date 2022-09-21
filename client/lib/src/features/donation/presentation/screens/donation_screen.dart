import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intola/src/features/donation/data/repository/donation_repository.dart';
import 'package:intola/src/features/donation/domain/model/donation_model.dart';
import 'package:intola/src/features/donation/presentation/donation_screen_app_bar.dart';
import 'package:intola/src/widgets/bottom_navigation_bar.dart';
import 'package:intola/src/features/donation/presentation/donation_card.dart';
import 'package:intola/src/widgets/error_display.dart';

class DonationScreen extends ConsumerWidget {
  const DonationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final donationsData = ref.watch(getDonationsProvider);
    return Scaffold(
      appBar: const DonationScreenAppBar(),
      bottomNavigationBar: const CustomBottomNavigationBar(),
      body: donationsData.when(
        data: (data) => DonationDisplayCards(data: data),
        error: (error, stack) =>
            const ErrorDisplayWidget(errorMessage: 'errorMessage'),
        loading: () => const Center(
          child: CircularProgressIndicator.adaptive(),
        ),
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
