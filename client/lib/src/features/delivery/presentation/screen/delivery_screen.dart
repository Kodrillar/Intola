import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intola/src/features/delivery/data/repository/delivery_repository.dart';
import 'package:intola/src/features/delivery/domain/model/delivery_model.dart';
import 'package:intola/src/features/delivery/presentation/delivery_screen_app_bar.dart';
import 'package:intola/src/features/delivery/presentation/delivery_card.dart';
import 'package:intola/src/widgets/error_display.dart';

class DeliveryScreen extends ConsumerWidget {
  const DeliveryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final deliveryData = ref.watch(deliveryDataProvider);
    return Scaffold(
      appBar: const DeliveryScreenAppBar(),
      body: deliveryData.when(
        data: (data) => DeliveryScreenCardList(data: data),
        error: (error, stackTrace) => ErrorDisplayWidget(
          error: error,
          //TODO: implement retry
          onRetry: () => '',
        ),
        loading: () => const Center(
          child: CircularProgressIndicator.adaptive(),
        ),
      ),
    );
  }
}

class DeliveryScreenCardList extends StatelessWidget {
  const DeliveryScreenCardList({Key? key, required this.data})
      : super(key: key);
  final List<DeliveryModel> data;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: data.length,
      itemBuilder: (context, index) => DeliveryCard(
        delivery: data[index],
      ),
    );
  }
}
