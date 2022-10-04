import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intola/src/features/product/domain/model/product_model.dart';
import 'package:intola/src/features/product/presentation/product_app_bar.dart';
import 'package:intola/src/features/product/presentation/product_screen_controller.dart';
import 'package:intola/src/widgets/product_details.dart';
import 'package:intola/src/utils/constant.dart';
import 'package:intola/src/widgets/buttons/custom_round_button.dart';
import 'package:intola/src/widgets/product_image.dart';

class ProductScreen extends ConsumerWidget {
  const ProductScreen({required this.product, Key? key}) : super(key: key);

  final ProductModel product;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartProductQuantity = ref.watch(productScreenControllerProvider);
    return Scaffold(
      appBar: const ProductAppBar(),
      body: ListView(
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
                      Text(
                        '$cartProductQuantity',
                        style: kAppBarTextStyle.copyWith(color: kDarkOrange),
                      ),
                      Row(
                        children: [
                          Container(
                            child: IconButton(
                              onPressed: () {
                                ref
                                    .read(productScreenControllerProvider
                                        .notifier)
                                    .decreaseCartProductQuantity();
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
                                    .read(productScreenControllerProvider
                                        .notifier)
                                    .incrementCartProductQuantity();
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
          ProductCtaButton(
            addProductToCart:
                addProductToCart(cartProductQuantity: cartProductQuantity),
            addProductToDonationCart: addProductToDonationCart(context),
          )
        ],
      ),
    );
  }

  void Function() addProductToCart({required int cartProductQuantity}) {
    return () {
      // _showSnackBar();
      // ref.read(cartRepositoryProvider).addToCart(
      //       product: ProductModel(
      //         id: productId,
      //         name: productName,
      //         image: productImage,
      //         price: productPrice,
      //         slashprice: '',
      //         description: productDescription,
      //         quantity: '',
      //       ),
      //       productQuantity: productQuantity,
      //     );
    };
  }

  void Function() addProductToDonationCart(BuildContext context) {
    return () {
      _showSnackBar(context, "Donation");
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(
      //     builder: (context) {
      //       return DonationCartScreen(
      //         image: widget.productImage,
      //         quantity: ,
      //         price: widget.productPrice,
      //         name: widget.productName,
      //         description: widget.productDescription,
      //       );
      //     },
      //   ),
      // );
    };
  }

  _showSnackBar(BuildContext context, [String? additionalMessage]) {
    SnackBar snackBar = SnackBar(
      backgroundColor: kDarkBlue,
      content: Row(
        children: [
          const Icon(
            Icons.add_shopping_cart_sharp,
            color: kDarkOrange,
          ),
          const SizedBox(width: 5),
          Text(
            "${product.name} added to ${additionalMessage ?? ''} cart!",
            style: kSnackBarTextStyle,
          ),
        ],
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
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
    return SizedBox(
      height: 100,
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
    );
  }
}
