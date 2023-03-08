import 'package:flutter/material.dart';
import 'package:intola/src/utils/constant.dart';

class CustomRoundButton extends StatelessWidget {
  const CustomRoundButton({
    Key? key,
    required this.onTap,
    required this.buttonText,
    this.buttonColor = kDarkOrange,
    this.width = 120,
  }) : super(key: key);

  final void Function() onTap;
  final String buttonText;
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
          height: 40,
          child: Center(
            child: Text(
              buttonText,
              style: const TextStyle(
                fontSize: 14,
                // fontWeight: FontWeight.w700,
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
