import 'package:flutter/material.dart';
import 'package:intola/src/utils/constant.dart';

class AuthOptionText extends StatefulWidget {
  const AuthOptionText({
    Key? key,
    this.optionTextStyle,
    this.onTap,
    required this.title,
    required this.optionText,
  }) : super(key: key);

  final optionTextStyle;
  final String title;
  final String optionText;
  final void Function()? onTap;

  @override
  _AuthOptionTextState createState() => _AuthOptionTextState();
}

class _AuthOptionTextState extends State<AuthOptionText> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            widget.title,
            style: kAuthOptionTextStyle,
          ),
          SizedBox(
            width: 5,
          ),
          Text(
            widget.optionText,
            style: widget.optionTextStyle,
          )
        ],
      ),
    );
  }
}
