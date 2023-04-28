import "package:flutter/material.dart";
import 'package:intola/src/utils/constant.dart';

class AuthButton extends StatelessWidget {
  const AuthButton({
    Key? key,
    this.onTap,
    required this.child,
  }) : super(key: key);

  final void Function()? onTap;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 50,
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: onTap == null ? kGreyColor : kDarkBlue,
        ),
        child: Center(
          child: child,
        ),
      ),
    );
  }
}
