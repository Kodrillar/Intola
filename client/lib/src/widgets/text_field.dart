import 'package:flutter/material.dart';
import 'package:intola/src/utils/constant.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    Key? key,
    required this.controller,
    required this.hintText,
    this.onChanged,
    this.errorText,
    this.labelText,
    this.visibilityIcon,
    this.obscureText,
    this.validator,
  }) : super(key: key);

  final TextEditingController controller;
  final String hintText;
  final String? errorText;
  final String? labelText;
  final Widget? visibilityIcon;
  final bool? obscureText;
  final void Function(String value)? onChanged;
  final String? Function(String? value)? validator;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextFormField(
        validator: validator,
        onChanged: onChanged,
        controller: controller,
        obscureText: obscureText ?? false,
        decoration: InputDecoration(
          hintStyle: TextStyle(
            color: kDarkBlue.withOpacity(.5),
          ),
          hintText: hintText,
          suffixIcon: visibilityIcon,
          labelText: labelText,
          errorText: errorText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}
