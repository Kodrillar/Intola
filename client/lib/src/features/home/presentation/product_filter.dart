import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intola/src/features/home/home_controller.dart';
import 'package:intola/src/utils/constant.dart';

class ProductsFilter extends ConsumerStatefulWidget {
  const ProductsFilter({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<ProductsFilter> createState() => _ProductsFilterState();
}

class _ProductsFilterState extends ConsumerState<ProductsFilter> {
  final List<String> dropdownItems = [
    "Phones and Tablets",
    "Computing",
    "Gaming",
    "Supermarket",
  ];
  @override
  Widget build(BuildContext context) {
    final productCategoryTextValue = ref.watch(homeScreenControllerProvider);
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
                (item) => DropdownMenuItem<String>(
                  value: item,
                  child: Text(item),
                ),
              )
              .toList(),
          onChanged: (newValue) {
            ref
                .read(homeScreenControllerProvider.notifier)
                .changeDropdownMenuItem(newValue!);
          },
          value: productCategoryTextValue,
        ),
      ),
    );
  }
}
