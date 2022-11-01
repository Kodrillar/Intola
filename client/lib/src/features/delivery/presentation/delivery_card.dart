import 'package:flutter/material.dart';
import 'package:intola/src/features/delivery/domain/model/delivery_model.dart';
import 'package:intola/src/features/delivery/presentation/screen/delivery_detail_screen.dart';
import 'package:intola/src/widgets/feed_card.dart';

class DeliveryCard extends StatelessWidget {
  const DeliveryCard({Key? key, required this.delivery}) : super(key: key);

  final DeliveryModel delivery;

  @override
  Widget build(BuildContext context) {
    return FeedCard(
      feedCardType: FeedCardType.delivery,
      userName: delivery.email!,
      leadingDetailValue: delivery.price,
      trailingDetailValue: delivery.weight,
      feedImage: delivery.image!,
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DeliveryDetailScreen(delivery: delivery),
          ),
        );
      },
    );
  }
}
