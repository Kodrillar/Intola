import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intola/src/features/donation/presentation/screens/donation_payment_screen.dart';
import 'package:intola/src/features/product/data/repository/product_repository.dart';
import 'package:intola/src/features/product/domain/model/product_model.dart';
import 'package:intola/src/features/product/presentation/product_app_bar.dart';
import 'package:intola/src/features/product/presentation/product_screen_controller.dart';
import 'package:intola/src/widgets/async_value_display.dart';
import 'package:intola/src/widgets/product_details.dart';
import 'package:intola/src/utils/constant.dart';
import 'package:intola/src/widgets/buttons/custom_round_button.dart';
import 'package:intola/src/widgets/product_image.dart';
import 'package:intola/src/widgets/snack_bar.dart';

class ProductScreen extends ConsumerWidget {
  const ProductScreen({required this.product, Key? key}) : super(key: key);

  final ProductModel product;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<AsyncValue>(productScreenControllerProvider,
        (previousState, newState) {
      newState.showErrorAlertDialog(context);
    });
    final cartProductQuantity = ref.watch(cartProductQuantityProvider);
    // final controller = ref.watch(productScreenControllerProvider);

    _showSnackBar() {
      ScaffoldMessenger.of(context).showSnackBar(
        CustomSnackBar(
          snackBarMessage: "${product.name} added to cart!",
          iconData: Icons.shopping_cart_outlined,
        ),
      );
    }

    void _addProductToCart() {
      _showSnackBar();
      ref.read(productScreenControllerProvider.notifier).addProductToCart(
            product: product,
            cartProductQuantity: cartProductQuantity,
          );
    }

    void _donateProduct() {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DonationPaymentScreen(
            product: product,
            productQuantity: cartProductQuantity,
          ),
        ),
      );
    }

    return Scaffold(
      appBar: const ProductAppBar(),
      bottomNavigationBar: ProductCtaButton(
        addProductToCart: _addProductToCart,
        addProductToDonationCart: _donateProduct,
      ),
      body: Scrollbar(
        thumbVisibility: true,
        child: ListView(
          children: [
            ProductImage(
              productImage: product.image,
            ),
            ProductDetails(
              productDescription: product.description,
              productName: product.name,
              productPrice: product.price,
            ),
            Container(
              height: 120,
              margin: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Quantity", style: kAppBarTextStyle),
                  Padding(
                    padding: const EdgeInsets.only(left: 16, top: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex: 2,
                          child: Text(
                            '$cartProductQuantity',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style:
                                kAppBarTextStyle.copyWith(color: kDarkOrange),
                          ),
                        ),
                        Row(
                          children: [
                            Container(
                              child: IconButton(
                                onPressed: () {
                                  if (cartProductQuantity > 1) {
                                    ref
                                        .read(cartProductQuantityProvider
                                            .notifier)
                                        .state--;
                                  }
                                },
                                icon: const Icon(Icons.remove),
                                color: kLightColor,
                              ),
                              decoration: BoxDecoration(
                                color: kDarkOrange,
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            Container(
                              child: IconButton(
                                onPressed: () {
                                  ref
                                      .read(
                                          cartProductQuantityProvider.notifier)
                                      .state++;
                                },
                                icon: const Icon(Icons.add),
                                color: kLightColor,
                              ),
                              decoration: BoxDecoration(
                                color: kDarkOrange,
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProductCtaButton extends StatelessWidget {
  const ProductCtaButton({
    Key? key,
    required this.addProductToCart,
    required this.addProductToDonationCart,
  }) : super(key: key);

  final void Function() addProductToCart;
  final void Function() addProductToDonationCart;

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: Colors.transparent,
      elevation: 0,
      child: SizedBox(
        height: 120,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomRoundButton(
              onTap: () {
                addProductToCart();
              },
              buttonText: "Add to cart",
              buttonColor: kDarkBlue,
            ),
            CustomRoundButton(
              onTap: () {
                addProductToDonationCart();
              },
              buttonText: "Donate",
            )
          ],
        ),
      ),
    );
  }
}
