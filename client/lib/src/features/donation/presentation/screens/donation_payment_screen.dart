import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intola/src/features/cart/domain/model/product_item_model.dart';
import 'package:intola/src/features/donation/presentation/donation_payment_screen_controller.dart';
import 'package:intola/src/routing/route.dart';
import 'package:intola/src/utils/constant.dart';
import 'package:intola/src/utils/network/api.dart';
import 'package:intola/src/widgets/app_bar_with_back_arrow.dart';
import 'package:intola/src/widgets/async_value_display.dart';
import 'package:intola/src/widgets/buttons/custom_round_button.dart';
import 'package:intola/src/widgets/loading_indicator.dart';

class DonationPaymentScreen extends ConsumerWidget {
  const DonationPaymentScreen({Key? key, required this.productItem})
      : super(key: key);

  final ProductItem productItem;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(donationPaymentScreenControllerProvider);
    return state.isLoading
        ? const LoadingIndicator()
        : Scaffold(
            appBar: const AppBarWithBackArrow(title: "Donation Payment "),
            bottomNavigationBar: DonationPaymentScreenBottomAppBar(
              processProductPayment: () {
                ref
                    .read(donationPaymentScreenControllerProvider.notifier)
                    .processDonationPayment(
                      context: context,
                      amount: productItem.productPrice,
                      productItem: productItem,
                      onDonationComplete: () => Navigator.of(context)
                          .pushNamedAndRemoveUntil(
                              RouteName.homeScreen.name, (route) => false),
                    );
              },
              productItem: productItem,
            ),
            body: DonationProductBar(productItem: productItem),
          );
  }
}

class DonationPaymentScreenBottomAppBar extends ConsumerWidget {
  const DonationPaymentScreenBottomAppBar(
      {Key? key,
      required this.productItem,
      required this.processProductPayment})
      : super(key: key);

  final ProductItem productItem;

  final void Function() processProductPayment;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<AsyncValue>(donationPaymentScreenControllerProvider,
        (previousState, newState) => newState.showErrorAlertDialog(context));

    return BottomAppBar(
      elevation: 0,
      child: SizedBox(
        height: 180,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Total",
                    style: kProductNameStyle,
                  ),
                  Text(
                    "\$${productItem.productPrice}",
                    style: kProductNameStyle.copyWith(
                      color: kDarkOrange,
                    ),
                  )
                ],
              ),
              CustomRoundButton(
                onTap: processProductPayment,
                buttonText: "Pay now",
                buttonColor: kDarkBlue,
              )
            ],
          ),
        ),
      ),
    );
  }
}

class DonationProductBar extends StatelessWidget {
  const DonationProductBar({Key? key, required this.productItem})
      : super(key: key);

  final ProductItem productItem;

  @override
  Widget build(BuildContext context) {
    final product = productItem.productModel;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      height: 150,
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: 50),
              child: CachedNetworkImage(
                imageUrl: "${API.baseUrl}/uploads/${product.image}",
                imageBuilder: (context, imageProvider) => Container(
                  height: 100,
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
          Text(
            "\$${product.price} X ${productItem.cartProductQuantity}",
            style: kAppBarTextStyle,
          )
        ],
      ),
    );
  }
}
