import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intola/src/features/home/presentation/home_screen_state.dart';
import 'package:intola/src/features/product/data/repository/product_repository.dart';
import 'package:intola/src/utils/network/api.dart';
import 'package:intola/src/utils/product_filter_options.dart';

class HomeScreenController extends StateNotifier<HomeScreenState> {
  HomeScreenController({
    required this.productRepository,
    required AsyncValue productGridAsyncValue,
    required AsyncValue productCarouselAsyncValue,
  }) : super(
          HomeScreenState(
            productGridAsyncValue: productGridAsyncValue,
            productCarouselAsyncValue: productCarouselAsyncValue,
          ),
        );

  final ProductRepository productRepository;

  Future<void> updateProductGridOnReload() async {
    state = state.copyWith(productGridAsyncValue: const AsyncLoading());
    final String endpointParam = _getProductEndpointParam(state.dropdownValue);
    final AsyncValue asyncResult = await AsyncValue.guard(
        () => productRepository.getProducts(endpointParam: endpointParam));
    if (mounted) {
      state = state.copyWith(productGridAsyncValue: asyncResult);
    }
  }

  Future<void> updateProductCarouselOnReload() async {
    state = state.copyWith(productCarouselAsyncValue: const AsyncLoading());
    final String endpointParam =
        (EndpointParam.products.param as ProductEndpointParams).top;
    final AsyncValue asyncResult = await AsyncValue.guard(
        () => productRepository.getProducts(endpointParam: endpointParam));
    if (mounted) {
      state = state.copyWith(productCarouselAsyncValue: asyncResult);
    }
  }

  void changeDropdownMenuItem(String newValue) {
    state = state.copyWith(dropdownValue: newValue);
    updateProductGridOnReload();
  }

  String _getProductEndpointParam(String dropdownValue) =>
      ProductFilterOptions.getCategoryFilter(dropdownValue);
}

final homeScreenControllerProvider =
    StateNotifierProvider.autoDispose<HomeScreenController, HomeScreenState>(
  (ref) {
    final ProductRepository productRepository =
        ref.read(productRepositoryProvider);
    final productEndpointParam =
        (EndpointParam.products.param as ProductEndpointParams);
    final String initialEndpointParam = productEndpointParam.supermarket;
    final String topDealEndpointParam = productEndpointParam.top;
    final productGridAsyncValue =
        ref.watch(getProductsProvider(initialEndpointParam));
    final productCarouselAsyncValue =
        ref.watch(getProductsProvider(topDealEndpointParam));
    return HomeScreenController(
      productRepository: productRepository,
      productGridAsyncValue: productGridAsyncValue,
      productCarouselAsyncValue: productCarouselAsyncValue,
    );
  },
);
