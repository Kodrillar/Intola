import 'package:flutter/material.dart';
import 'package:intola/src/utils/constant.dart';

class AuthOptionText extends StatelessWidget {
  const AuthOptionText({
    Key? key,
    required this.optionTextStyle,
    this.onTap,
    required this.title,
    required this.optionText,
  }) : super(key: key);

  final TextStyle optionTextStyle;
  final String title;
  final String optionText;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: GestureDetector(
        onTap: onTap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: kAuthOptionTextStyle,
            ),
            const SizedBox(
              width: 5,
            ),
            Text(
              optionText,
              style: onTap == null
                  ? optionTextStyle.copyWith(color: kGreyColor)
                  : optionTextStyle,
            )
          ],
        ),
      ),
    );
  }
}
