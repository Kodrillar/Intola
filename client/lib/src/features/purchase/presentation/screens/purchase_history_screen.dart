import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intola/src/features/purchase/data/repository/purchase_repository.dart';
import 'package:intola/src/features/purchase/domain/model/purchase_history_model.dart';
import 'package:intola/src/features/purchase/presentation/purchase_history_app_bar.dart';
import 'package:intola/src/features/purchase/presentation/purchase_history_screen_bar.dart';
import 'package:intola/src/widgets/error_display.dart';

class PurchaseHistoryScreen extends ConsumerWidget {
  const PurchaseHistoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final purchaseHistoryProvider = ref.watch(fetchPurchaseHistoryProvider);
    return Scaffold(
      appBar: const PurchaseHistoryAppBar(),
      body: purchaseHistoryProvider.when(
        data: (data) => PurchaseHistory(data: data),
        error: (error, stackTrace) => ErrorDisplayWidget(
          errorMessage: error.toString(),
        ),
        loading: () =>
            const Center(child: CircularProgressIndicator.adaptive()),
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
