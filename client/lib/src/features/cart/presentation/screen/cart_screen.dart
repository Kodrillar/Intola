import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intola/src/features/cart/data/repository/cart_repository.dart';
import 'package:intola/src/features/cart/presentation/cart_screen_app_bar.dart';
import 'package:intola/src/features/product/domain/model/product_model.dart';
import 'package:intola/src/features/shipping/presentation/screens/shipping_info_screen.dart';
import 'package:intola/src/utils/network/api.dart';
import 'package:intola/src/widgets/alert_dialog.dart';
import 'package:intola/src/widgets/buttons/custom_round_button.dart';

import '../../../../utils/constant.dart';

class CartScreen extends ConsumerWidget {
  const CartScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final fetchCart = ref.watch(fetchCartProvider);
    return Scaffold(
      appBar: const CartScreenAppBar(),
      bottomNavigationBar: fetchCart.asData?.value == null
          ? null
          : const CartScreenBottomAppBar(),
      body: fetchCart.when(
        data: (data) => data == null
            ? Center(
                child: Text(
                  'cart is empty!',
                  style: kAppBarTextStyle.copyWith(color: kDarkOrange),
                ),
              )
            : ListView.builder(
                itemCount: data.values.length,
                itemBuilder: (context, index) => CartProductBar(
                  productModel: data.values.toList()[index].productModel,
                  productQuantity: data.values.toList()[index].productQuantity,
                ),
              ),
        error: (error, stackTrace) => Center(
          child: Text(error.toString()),
        ),
        loading: () => const Center(
          child: CircularProgressIndicator.adaptive(),
        ),
      ),
    );
  }
}

/// Implement a stream-based cart system and controller
///  to handle immediate state changes

class CartProductBar extends ConsumerWidget {
  const CartProductBar({
    Key? key,
    required this.productQuantity,
    required this.productModel,
  }) : super(key: key);

  final int productQuantity;
  final ProductModel productModel;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Dismissible(
      confirmDismiss: (direction) =>
          CustomAlertDialog.showConfirmationAlertDialog(
        context: context,
        title: 'Remove from cart!',
        content: 'Are you sure you want to remove this product?',
      ),
      background: Center(
        child: Text(
          'swipe to remove...',
          style:
              kAuthOptionTextStyle.copyWith(color: kDarkBlue.withOpacity(.6)),
        ),
      ),
      key: UniqueKey(),
      onDismissed: (direction) =>
          ref.read(cartRepositoryProvider).deleteCartItem(productModel.id),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        height: 120,
        width: double.infinity,
        child: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          child: Padding(
            padding: const EdgeInsets.only(right: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 15),
                    child: CachedNetworkImage(
                      imageUrl: "${API.baseUrl}/uploads/${productModel.image}",
                      imageBuilder: (context, imageProvider) => Container(
                        height: 120,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
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
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: Text(
                      productModel.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: kAppBarTextStyle.copyWith(fontSize: 13),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      '\$${productModel.price} X $productQuantity', // "\$${widget.price} X ${widget.quantity}",
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                      style: kAppBarTextStyle.copyWith(
                        fontSize: 14,
                        color: kDarkOrange,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CartScreenBottomAppBar extends StatelessWidget {
  const CartScreenBottomAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      elevation: 10,
      child: SizedBox(
        height: 150,
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
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      'Get total', // "\$${totalPrice.floor()}",
                      style: kProductNameStyle.copyWith(
                        color: kDarkOrange,
                      ),
                    ),
                  )
                ],
              ),
              CustomRoundButton(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ShippingInfoScreen(
                        image: 'image',
                        price: 4.3, //totalPrice,
                        name: 'name',
                      ),
                    ),
                  );
                },
                buttonText: "Checkout",
                buttonColor: kDarkBlue,
              )
            ],
          ),
        ),
      ),
    );
  }
}
