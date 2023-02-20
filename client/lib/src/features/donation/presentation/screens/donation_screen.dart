import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intola/src/features/donation/domain/model/donation_model.dart';
import 'package:intola/src/features/donation/presentation/donation_screen_app_bar.dart';
import 'package:intola/src/features/donation/presentation/donation_card.dart';
import 'package:intola/src/features/donation/presentation/donation_screen_controller.dart';
import 'package:intola/src/widgets/error_display.dart';

class DonationScreen extends ConsumerWidget {
  const DonationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(donationScreenControllerProvider);
    return Scaffold(
      appBar: const DonationScreenAppBar(),
      body: state.when(
        data: (data) => DonationDisplayCards(data: data),
        error: (error, stack) => ErrorDisplayWidget(
          error: error,
          onRetry: () => ref
              .read(donationScreenControllerProvider.notifier)
              .updateOnReload(),
        ),
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
        donation: data[index],
      ),
    );
  }
}
