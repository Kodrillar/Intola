import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intola/src/features/cart/presentation/screen/donation_cart_screen.dart';
import 'package:intola/src/features/cart/presentation/screen/cart_screen.dart';
import 'package:intola/src/features/product/presentation/product_app_bar.dart';
import 'package:intola/src/features/product/presentation/product_details.dart';
import 'package:intola/src/utils/network/api.dart';
import 'package:intola/src/utils/constant.dart';
import 'package:intola/src/widgets/buttons/custom_round_button.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({
    Key? key,
    required this.productImage,
    required this.productName,
    required this.productPrice,
    required this.productDescription,
  }) : super(key: key);

  final String productImage;
  final String productPrice;
  final String productName;
  final String productDescription;

  static const id = "/productScreen";

  @override
  _ProductScreenState createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  int productQuantity = 1;
  @override
  Widget build(BuildContext context) {
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
                        '$productQuantity',
                        style: kAppBarTextStyle.copyWith(color: kDarkOrange),
                      ),
                      Row(
                        children: [
                          Container(
                            child: IconButton(
                              onPressed: () {
                                setState(() {
                                  if (productQuantity > 1) {
                                    productQuantity--;
                                  }
                                });
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
                                setState(() {
                                  productQuantity++;
                                });
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
          ProductButton(
            addProductToCart: addProductToCart,
            addProductToDonationCart: addProductToDonationCart,
          )
        ],
      ),
    );
  }

  void addProductToCart() {
    _showSnackBar();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return CartScreen(
            image: widget.productImage,
            quantity: productQuantity,
            price: widget.productPrice,
            name: widget.productName,
          );
        },
      ),
    );
  }

  void addProductToDonationCart() {
    _showSnackBar("Donation");
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return DonationCartScreen(
            image: widget.productImage,
            quantity: productQuantity,
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

class ProductImage extends StatelessWidget {
  const ProductImage({
    Key? key,
    required this.productImage,
  }) : super(key: key);

  final String productImage;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: "${API.baseUrl}/uploads/$productImage",
      imageBuilder: (context, imageProvider) => Container(
        margin: const EdgeInsets.all(16),
        height: 200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: kDarkOrange.withOpacity(.075),
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
    );
  }
}

class ProductButton extends StatelessWidget {
  const ProductButton({
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
