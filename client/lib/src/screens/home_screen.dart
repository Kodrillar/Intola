import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intola/src/models/product_model.dart';
import 'package:intola/src/repositories/product/product_repository.dart';
import 'package:intola/src/screens/profile_screen.dart';
import 'package:intola/src/services/api.dart';

import 'package:intola/src/utils/constant.dart';
import 'package:intola/src/utils/product_filter_options.dart';
import 'package:intola/src/utils/cache/secure_storage.dart';
import 'package:intola/src/widgets/alert_dialog.dart';
import 'package:intola/src/widgets/bottom_navigation_bar.dart';
import 'package:intola/src/widgets/carousel_slider.dart';
import 'package:intola/src/widgets/category_text.dart';
import 'package:intola/src/widgets/error_display.dart';

import 'package:intola/src/widgets/product_card.dart';

ProductRepository _productRepository = ProductRepository();

ValueNotifier dropdownValueNotifier =
    ValueNotifier<String>("Phones and Tablets");

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    Key? key,
  }) : super(key: key);
  static const id = "/homeScreen";

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? userName;

  var productData;

  Future<List<ProductModel>> getData(String category) async {
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

  Future<void> getUserName() async {
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
      appBar: HomeAppBar(userName: userName),
      body: ListView(
        children: [
          const CategoryText(title: "Top deals"),
          //  TopDealsCarousel(getProductsData: getData),
          // const ProductsFilter(),
          MainProductsGrid(getProductsData: getData),
          // const CategoryText(title: "Exiciting offers"),
          ExcitingOffersProductGrid(getProductsData: getData)
        ],
      ),
      bottomNavigationBar: const CustomBottomNavigationBar(),
    );
  }
}

class HomeAppBar extends StatelessWidget with PreferredSizeWidget {
  const HomeAppBar({Key? key, required this.userName}) : super(key: key);

  final String? userName;

  @override
  Widget build(BuildContext context) {
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

  @override
  Size get preferredSize => const Size.fromHeight(140);
}

class TopDealsCarousel extends StatelessWidget {
  const TopDealsCarousel({Key? key, required this.getProductsData})
      : super(key: key);

  final Future<List<ProductModel>> Function(String category) getProductsData;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<ProductModel>>(
      future: getProductsData("/top"),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          var data = snapshot.data;
          return CustomCarouselSlider.getCarouselSlider(
            carouselItems: data!,
          );
        }

        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}

class ProductsFilter extends StatefulWidget {
  const ProductsFilter({
    Key? key,
  }) : super(key: key);

  @override
  State<ProductsFilter> createState() => _ProductsFilterState();
}

class _ProductsFilterState extends State<ProductsFilter> {
  final List<String> dropdownItems = [
    "Phones and Tablets",
    "Computing",
    "Gaming",
    "Supermarket",
  ];
  @override
  Widget build(BuildContext context) {
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
              dropdownValueNotifier.value = newValue!;
            });
          },
          value: dropdownValueNotifier.value,
        ),
      ),
    );
  }
}

class MainProductsGrid extends StatelessWidget {
  const MainProductsGrid({Key? key, required this.getProductsData})
      : super(key: key);

  final Future<List<ProductModel>>? Function(String category) getProductsData;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: dropdownValueNotifier,
      builder: ((_, value, child) => SizedBox(
            height: 450,
            child: FutureBuilder<List<ProductModel>>(
              future: getProductsData(
                ProductFilterOptions.categoryFilter(value.toString()),
              ),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  var data = snapshot.data;
                  return ProductsGrid(data: data!);
                }
                if (snapshot.hasError) {
                  return const ErrorDisplayWidget();
                }

                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          )),
    );
  }
}

class ExcitingOffersProductGrid extends StatelessWidget {
  const ExcitingOffersProductGrid({Key? key, required this.getProductsData})
      : super(key: key);

  final Future<List<ProductModel>>? Function(String category) getProductsData;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 450,
      child: FutureBuilder<List<ProductModel>>(
        future: getProductsData("/exciting_offers"),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var data = snapshot.data;
            return ProductsGrid(data: data!);
          }
          if (snapshot.hasError) {
            return const ErrorDisplayWidget();
          }

          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}

class ProductsGrid extends StatelessWidget {
  const ProductsGrid({Key? key, required this.data}) : super(key: key);

  final List<ProductModel> data;

  @override
  Widget build(BuildContext context) {
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
}
