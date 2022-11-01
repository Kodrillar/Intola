import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intola/src/features/delivery/presentation/screen/delivery_screen.dart';
import 'package:intola/src/features/donation/presentation/screens/donation_screen.dart';
import 'package:intola/src/features/home/data/home_repository.dart';
import 'package:intola/src/features/home/presentation/home_app_bar.dart';
import 'package:intola/src/features/home/presentation/main_product_grid.dart';
import 'package:intola/src/features/home/presentation/product_filter.dart';
import 'package:intola/src/features/home/presentation/top_deal_carousel.dart';
import 'package:intola/src/features/purchase/presentation/screens/purchase_history_screen.dart';
import 'package:intola/src/widgets/bottom_navigation_bar.dart';
import 'package:intola/src/widgets/category_text.dart';
import 'package:intola/src/widgets/loading_indicator.dart';

class Home extends ConsumerWidget {
  Home({Key? key}) : super(key: key);

  final List<Widget> screens = [
    const HomeScreen(),
    const DonationScreen(),
    const DeliveryScreen(),
    const PurchaseHistoryScreen()
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenIndex = ref.watch(bottomNavigationBarIndexProvider);
    return Scaffold(
      bottomNavigationBar: const CustomBottomNavigationBar(),
      body: screens[screenIndex],
    );
  }
}

class HomeScreen extends ConsumerWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userNameProvider = ref.watch(fetchUserNameProvider);
    return userNameProvider.when(
      data: (userName) => Scaffold(
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
      ),

      //TODO: change error widget
      error: (error, stackTrace) => ErrorWidget(error),
      loading: () => const Center(
        child: LoadingIndicator(),
      ),
    );
  }
}
