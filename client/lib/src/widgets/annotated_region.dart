import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SystemUIOverlayAnnotatedRegion extends StatelessWidget {
  const SystemUIOverlayAnnotatedRegion({
    Key? key,
    required this.child,
    required this.systemUiOverlayStyle,
  }) : super(key: key);

  final Widget child;
  final SystemUiOverlayStyle systemUiOverlayStyle;

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      child: child,
      value: systemUiOverlayStyle,
    );
  }
}
