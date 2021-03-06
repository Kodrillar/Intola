import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intola/src/screens/cartScreen.dart';
import 'package:intola/src/services/api.dart';
import 'package:intola/src/utils/constant.dart';
import 'package:intola/src/widgets/buttons/customButton.dart';

import 'donation/donationCartScreen.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({
    required this.productImage,
    required this.productName,
    required this.productPrice,
    required this.productDescription,
  });

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
      appBar: CustomAppBar(),
      body: ListView(
        children: [
          CachedNetworkImage(
            imageUrl: "${API.baseUrl}/uploads/${widget.productImage}",
            imageBuilder: (context, imageProvider) => Container(
              margin: EdgeInsets.all(16),
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
            placeholder: (context, url) => Center(
              child: CircularProgressIndicator(),
            ),
            errorWidget: (context, url, error) => Center(
              child: Icon(Icons.error, color: Colors.red),
            ),
          ),
          // _buildProductImage(),
          // _buildProductDetails(),
          ProductDetails(
              productDescription: widget.productDescription,
              productName: widget.productName,
              productPrice: widget.productPrice),
          //  _buildProductQuantity(),
          Container(
            margin: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Quantity", style: kAppBarTextStyle),
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
                              icon: Icon(Icons.remove),
                              color: kLightColor,
                            ),
                            decoration: BoxDecoration(
                              color: kDarkOrange,
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Container(
                            child: IconButton(
                              onPressed: () {
                                setState(() {
                                  productQuantity++;
                                });
                              },
                              icon: Icon(Icons.add),
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
          Icon(
            Icons.add_shopping_cart_sharp,
            color: kDarkOrange,
          ),
          SizedBox(width: 5),
          Text(
            "${widget.productName} added to ${additionalMessage != null ? additionalMessage : ''} cart!",
            style: kSnackBarTextStyle,
          ),
        ],
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}

//abstract reusable widgets to widgets module
class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  const CustomAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        color: kDarkBlue,
        icon: Icon(Icons.arrow_back_ios),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      // actions: [
      //   IconButton(
      //     onPressed: () {
      //       Navigator.pushNamed(context, CartScreen.id);
      //     },
      //     icon: Icon(Icons.shopping_cart_outlined),
      //     color: kDarkBlue,
      //   )
      // ],
      elevation: 0,
      backgroundColor: Colors.transparent,
      title: Text(
        "Shop",
        style: kAppBarTextStyle,
      ),
    );
  }

  Size get preferredSize => Size.fromHeight(35);
}

class ProductDetails extends StatelessWidget {
  const ProductDetails({
    Key? key,
    required this.productDescription,
    required this.productName,
    required this.productPrice,
  }) : super(key: key);
  final String productName;
  final String productPrice;
  final String productDescription;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      height: 250,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "$productName",
                style: kProductNameStyle,
              ),
              Text(
                "\$$productPrice",
                style: kProductNameStyle,
              ),
            ],
          ),
          SizedBox(height: 20),
          Text(
            "$productDescription",
            textAlign: TextAlign.justify,
            style: kProductDetailStyle,
          )
        ],
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
    return Container(
      height: 100,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomButton(
            onTap: () {
              addProductToCart();
            },
            buttonName: "Add to cart",
            buttonColor: kDarkBlue,
          ),
          CustomButton(
            onTap: () {
              addProductToDonationCart();
            },
            buttonName: "Donate",
          )
        ],
      ),
    );
  }
}
