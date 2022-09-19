import 'package:flutter/material.dart';
import 'package:intola/src/utils/constant.dart';
import 'package:intola/src/widgets/buttons/custom_round_button.dart';

class ShippingInfoBottomAppBar extends StatelessWidget {
  const ShippingInfoBottomAppBar({Key? key, required this.onTap})
      : super(key: key);
  final void Function() onTap;
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      elevation: 0,
      child: SizedBox(
        height: 120,
        child: Center(
          child: CustomRoundButton(
            onTap: onTap,
            buttonText: "Pay now",
            buttonColor: kDarkBlue,
          ),
        ),
      ),
    );
  }
}
