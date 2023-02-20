import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreenState {
  HomeScreenState({
    required this.productGridAsyncValue,
    required this.productCarouselAsyncValue,
    this.dropdownValue = "Supermarket",
  });

  final AsyncValue productGridAsyncValue;
  final AsyncValue productCarouselAsyncValue;
  final String dropdownValue;

  HomeScreenState copyWith({
    AsyncValue? productGridAsyncValue,
    AsyncValue? productCarouselAsyncValue,
    String? dropdownValue,
  }) =>
      HomeScreenState(
        productGridAsyncValue:
            productGridAsyncValue ?? this.productGridAsyncValue,
        dropdownValue: dropdownValue ?? this.dropdownValue,
        productCarouselAsyncValue:
            productCarouselAsyncValue ?? this.productCarouselAsyncValue,
      );

  @override
  String toString() {
    return "HomeScreenState(asyncValue: $productGridAsyncValue, dropdownValue: $dropdownValue, topDealAsyncValue:$productCarouselAsyncValue)";
  }

  @override
  bool operator ==(covariant HomeScreenState other) {
    if (identical(this, other)) return true;

    return (other.productGridAsyncValue == productGridAsyncValue &&
        other.dropdownValue == dropdownValue &&
        other.productCarouselAsyncValue == productCarouselAsyncValue);
  }

  @override
  int get hashCode =>
      dropdownValue.hashCode ^
      productGridAsyncValue.hashCode ^
      productCarouselAsyncValue.hashCode;
}
