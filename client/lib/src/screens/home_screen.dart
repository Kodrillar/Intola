import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intola/src/models/product_model.dart';
import 'package:intola/src/repositories/product/product_repository.dart';
import 'package:intola/src/screens/profile_screen.dart';
import 'package:intola/src/services/api.dart';

import 'package:intola/src/utils/constant.dart';
import 'package:intola/src/utils/secure_storage.dart';
import 'package:intola/src/widgets/alert_dialog.dart';
import 'package:intola/src/widgets/bottom_navigation_bar.dart';
import 'package:intola/src/widgets/carousel_slider.dart';
import 'package:intola/src/widgets/category_text.dart';

import 'package:intola/src/widgets/product_card.dart';

ProductRepository _productRepository = ProductRepository();

class HomeScreen extends StatefulWidget {
  const HomeScreen({this.user});
  static const id = "/homeScreen";
  final user;
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? userName;
  String dropdownValue = "Phones and Tablets";

  List<String> dropdownItems = [
    "Phones and Tablets",
    "Computing",
    "Gaming",
    "Supermarket",
  ];
  var productData;

  Future<List<ProductModel>> getData(category) async {
    try {
      productData = await _productRepository.getProducts(
          endpoint: endpoints["getProducts"]! + category);
    } on SocketException {
      alertDialog(
        context: context,
        title: "Network Error",
        content: "Unable to connect to the internet!",
      );
    }
    //Excluding 'catch' because I want future builder(snapshot.hasError) to handle error
    // catch (_) {
    //   alertDialog(
    //     context: context,
    //     title: "Oops! something went wrong.",
    //     content: "Contact support team",
    //   );
    // }
    return productData;
  }

  getUserName() async {
    var name = await SecureStorage.storage.read(key: "userName");
    setState(() {
      userName = name;
    });
  }

  @override
  void initState() {
    getUserName();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: ListView(
        children: [
          CategoryText(title: "Top deals"),
          FutureBuilder<List<ProductModel>>(
            future: getData("/top"),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                var data = snapshot.data;
                return CustomCarouselSlider.getCarouselSlider(
                  carouselItems: data!,
                );
              }

              return const Center(child: CircularProgressIndicator());
            },
          ),
          _buildFilter(),
          SizedBox(
            height: 450,
            child: FutureBuilder<List<ProductModel>>(
              future: getData(
                _categoryFilter(dropdownValue),
              ),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  var data = snapshot.data;
                  return _buildProducts(data!);
                }
                if (snapshot.hasError) {
                  return _buildErrorWidget();
                }

                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          ),
          CategoryText(title: "Exiciting offers"),
          SizedBox(
            height: 450,
            child: FutureBuilder<List<ProductModel>>(
              future: getData("/exciting_offers"),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  var data = snapshot.data;
                  return _buildProducts(data!);
                }
                if (snapshot.hasError) {
                  return _buildErrorWidget();
                }

                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  //Abstract '_buildErrorWidget' to a single widget later
  _buildErrorWidget() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          child: Icon(
            Icons.error,
            color: kDarkBlue.withOpacity(.35),
            size: 100,
          ),
          height: 150,
        ),
        const Text(
          "Oops! No products found \nfor this category.",
          style: kAppBarTextStyle,
        )
      ],
    );
  }

  _categoryFilter(filter) {
    if (filter == dropdownItems[0]) {
      return "/phones_and_tablets";
    } else if (filter == dropdownItems[1]) {
      return "/computing";
    } else if (filter == dropdownItems[2]) {
      return "/gaming";
    } else {
      return "/supermarket";
    }
  }

  _buildProducts(List<ProductModel> data) {
    return SizedBox(
      width: double.infinity,
      child: GridView.builder(
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        itemCount: data.length,
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: MediaQuery.of(context).size.width / 2,
          mainAxisExtent: 215,
          mainAxisSpacing: 15.0,
          crossAxisSpacing: 0.0,
        ),
        itemBuilder: (context, index) => ProductCard(
          productName: data[index].name,
          productImage: data[index].image,
          productDescription: data[index].description,
          productPrice: data[index].price,
          productSlashprice: data[index].slashprice,
        ),
      ),
    );
  }

  _buildFilter() {
    return Container(
      margin: const EdgeInsets.only(
        top: 50,
        right: 30,
        left: 30,
        bottom: 20,
      ),
      height: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: kDarkOrange,
          width: 2,
        ),
      ),
      child: Center(
        child: DropdownButton<String>(
          focusColor: Colors.transparent,
          borderRadius: BorderRadius.circular(10),
          items: dropdownItems
              .map(
                (item) => DropdownMenuItem(
                  value: item,
                  child: Text(item),
                ),
              )
              .toList(),
          onChanged: (String? newValue) {
            setState(() {
              dropdownValue = newValue!;
            });
          },
          value: dropdownValue,
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  "Hi, $userName",
                  style: kHeadingTextStyle,
                ),
              ),
            ),
          ],
        ),
      ),
      actions: [
        IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProfileScreen(
                  userEmail: userName,
                ),
              ),
            );
          },
          icon: const Icon(
            Icons.account_circle,
            color: kDarkBlue,
          ),
        ),
      ],
    );
  }

  CustomBottomNavigationBar _buildBottomNavigationBar() {
    return const CustomBottomNavigationBar();
  }
}
