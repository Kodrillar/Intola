import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intola/src/features/home/data/home_repository.dart';
import 'package:intola/src/features/home/presentation/home_app_bar.dart';
import 'package:intola/src/features/home/presentation/main_product_grid.dart';
import 'package:intola/src/features/home/presentation/product_filter.dart';
import 'package:intola/src/features/home/presentation/top_deal_carousel.dart';
import 'package:intola/src/widgets/bottom_navigation_bar.dart';
import 'package:intola/src/widgets/category_text.dart';
import 'package:intola/src/widgets/loading_indicator.dart';

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
        bottomNavigationBar: const CustomBottomNavigationBar(),
      ),

      //TODO: change error widget
      error: (error, stackTrace) => ErrorWidget(error),
      loading: () => const Center(
        child: LoadingIndicator(),
      ),
    );
  }
}
