import 'package:flutter/material.dart';
import 'package:intola/src/utils/constant.dart';

class CustomButton extends StatelessWidget {
  CustomButton({
    required this.onTap,
    required this.buttonName,
    this.buttonColor = kDarkOrange,
    this.width = 120,
  });

  final void Function() onTap;
  final String buttonName;
  final double? width;
  final Color? buttonColor;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: width,
          height: 50,
          child: Center(
            child: Text(
              buttonName,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: kLightColor,
              ),
            ),
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: buttonColor,
          ),
        ),
      ),
    );
  }
}
