import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intola/src/features/cart/data/repository/cart_repository.dart';
import 'package:intola/src/features/cart/presentation/screen/donation_cart_screen.dart';
import 'package:intola/src/features/product/domain/model/product_model.dart';
import 'package:intola/src/features/product/presentation/product_app_bar.dart';
import 'package:intola/src/widgets/product_details.dart';
import 'package:intola/src/utils/constant.dart';
import 'package:intola/src/widgets/buttons/custom_round_button.dart';
import 'package:intola/src/widgets/product_image.dart';

final productQuantityProvider = StateProvider.autoDispose<int>((ref) => 1);

class ProductScreen extends ConsumerStatefulWidget {
  const ProductScreen({
    Key? key,
    required this.productId,
    required this.productImage,
    required this.productName,
    required this.productPrice,
    required this.productDescription,
  }) : super(key: key);

  final String productImage;
  final String productPrice;
  final String productName;
  final String productDescription;
  final String productId;

  @override
  _ProductScreenState createState() => _ProductScreenState();
}

class _ProductScreenState extends ConsumerState<ProductScreen> {
  @override
  Widget build(BuildContext context) {
    final productQuan = ref.watch(productQuantityProvider);
    return Scaffold(
      appBar: const ProductAppBar(),
      body: ListView(
        children: [
          ProductImage(
            productImage: widget.productImage,
          ),
          ProductDetails(
            productDescription: widget.productDescription,
            productName: widget.productName,
            productPrice: widget.productPrice,
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
                        '$productQuan',
                        style: kAppBarTextStyle.copyWith(color: kDarkOrange),
                      ),
                      Row(
                        children: [
                          Container(
                            child: IconButton(
                              onPressed: () {
                                // setState(() {
                                //   if (productQuantity > 1) {
                                //     productQuantity--;
                                //   }
                                // });
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
                                    .read(productQuantityProvider.notifier)
                                    .state = 4;
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
            addProductToCart: addProductToCart(productQuantity: productQuan),
            addProductToDonationCart: addProductToDonationCart,
          )
        ],
      ),
    );
  }

  void Function() addProductToCart({required int productQuantity}) {
    return () {
      _showSnackBar();
      ref.read(cartRepositoryProvider).addToCart(
            product: ProductModel(
              id: widget.productId,
              name: widget.productName,
              image: widget.productImage,
              price: widget.productPrice,
              slashprice: '',
              description: widget.productDescription,
              quantity: '',
            ),
            productQuantity: productQuantity,
          );
    };
  }

  void addProductToDonationCart() {
    _showSnackBar("Donation");
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return DonationCartScreen(
            image: widget.productImage,
            quantity: productQuantityProvider,
            price: widget.productPrice,
            name: widget.productName,
            description: widget.productDescription,
          );
        },
      ),
    );
  }

  _showSnackBar([String? additionalMessage]) {
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
            "${widget.productName} added to ${additionalMessage ?? ''} cart!",
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
