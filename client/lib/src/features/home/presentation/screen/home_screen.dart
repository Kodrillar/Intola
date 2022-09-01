import 'package:flutter/material.dart';
import 'package:intola/src/features/home/presentation/home_app_bar.dart';
import 'package:intola/src/features/home/presentation/main_product_grid.dart';
import 'package:intola/src/features/home/presentation/product_filter.dart';
import 'package:intola/src/features/home/presentation/top_deal_carousel.dart';
import 'package:intola/src/utils/cache/secure_storage.dart';
import 'package:intola/src/widgets/bottom_navigation_bar.dart';
import 'package:intola/src/widgets/category_text.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  static const id = "/homeScreen";

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? userName;

  Future<void> _getUserName() async {
    var name = await SecureStorage.storage.read(key: "userName");
    setState(() {
      userName = name;
    });
  }

  @override
  void initState() {
    _getUserName();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HomeAppBar(userName: userName),
      body: ListView(
        children: const [
          CategoryText(title: "Top deals"),
          TopDealsCarousel(),
          ProductsFilter(),
          MainProductGrid(),
          // const CategoryText(title: "Exiciting offers"),
          //  ExcitingOfferProductGrid(getProductsData: getData)
        ],
      ),
      bottomNavigationBar: const CustomBottomNavigationBar(),
    );
  }
}
