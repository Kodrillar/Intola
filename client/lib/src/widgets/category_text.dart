import 'package:flutter/material.dart';
import 'package:intola/src/utils/constant.dart';

class CategoryText extends StatelessWidget {
  const CategoryText({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      child: Text(
        title,
        style: const TextStyle(
          color: kDarkOrange,
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      ),
    );
  }
}
