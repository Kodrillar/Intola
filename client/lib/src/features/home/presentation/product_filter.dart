import 'package:flutter/material.dart';
import 'package:intola/src/features/home/data/repository/home_repository.dart';
import 'package:intola/src/utils/constant.dart';

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
