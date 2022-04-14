import "package:flutter/material.dart";
import 'package:intola/src/utils/constant.dart';

class AuthButton extends StatefulWidget {
  const AuthButton({
    Key? key,
    required this.onTap,
    required this.buttonName,
  }) : super(key: key);

  final void Function() onTap;
  final String buttonName;

  @override
  _AuthButtonState createState() => _AuthButtonState();
}

class _AuthButtonState extends State<AuthButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        height: 50,
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: kDarkBlue),
        child: Center(
          child: Text(
            widget.buttonName,
            style: TextStyle(
              color: kDarkOrange,
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }
}
