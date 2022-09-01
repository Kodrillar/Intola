import 'dart:io';
import 'package:flutter/material.dart';
import 'package:intola/src/features/home/presentation/exciting_offer_product_grid.dart';
import 'package:intola/src/features/home/presentation/home_app_bar.dart';
import 'package:intola/src/features/home/presentation/main_product_grid.dart';
import 'package:intola/src/features/home/presentation/product_filter.dart';
import 'package:intola/src/features/home/presentation/top_deal_carousel.dart';
import 'package:intola/src/features/product/domain/model/product_model.dart';
import 'package:intola/src/features/product/data/repository/product_repository.dart';
import 'package:intola/src/utils/network/api.dart';
import 'package:intola/src/utils/cache/secure_storage.dart';
import 'package:intola/src/widgets/alert_dialog.dart';
import 'package:intola/src/widgets/bottom_navigation_bar.dart';
import 'package:intola/src/widgets/category_text.dart';

ProductRepository _productRepository = ProductRepository();

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
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
          TopDealsCarousel(getProductsData: getData),
          const ProductsFilter(),
          MainProductGrid(getProductsData: getData),
          const CategoryText(title: "Exiciting offers"),
          ExcitingOfferProductGrid(getProductsData: getData)
        ],
      ),
      bottomNavigationBar: const CustomBottomNavigationBar(),
    );
  }
}
