import 'package:flutter/material.dart';
import 'package:intola/src/utils/constant.dart';

class CategoryText extends StatelessWidget {
  CategoryText({required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(16),
      child: Text(
        title,
        style: TextStyle(
          color: kDarkOrange,
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      ),
    );
  }
}
