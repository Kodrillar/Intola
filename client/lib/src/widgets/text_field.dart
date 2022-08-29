import 'package:flutter/material.dart';
import 'package:intola/src/utils/constant.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    Key? key,
    required this.controller,
    required this.hintText,
    this.onChanged,
    this.errorText,
    this.labelText,
    this.visibilityIcon,
    this.obscureText,
  }) : super(key: key);

  final TextEditingController controller;
  final String hintText;
  final String? errorText;
  final String? labelText;
  final Widget? visibilityIcon;
  final bool? obscureText;
  final void Function(String value)? onChanged;

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextFormField(
        onChanged: widget.onChanged,
        controller: widget.controller,
        obscureText: widget.obscureText ?? false,
        decoration: InputDecoration(
          hintStyle: TextStyle(
            color: kDarkBlue.withOpacity(.5),
          ),
          hintText: widget.hintText,
          suffixIcon: widget.visibilityIcon,
          labelText: widget.labelText,
          errorText: widget.errorText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}
