import 'package:flutter/material.dart';
import 'package:intola/src/routing/route.dart';
import 'package:intola/src/utils/constant.dart';
import 'package:intola/src/widgets/alert_dialog.dart';
import 'package:intola/src/widgets/buttons/custom_round_button.dart';

class ProfileBottomAppBar extends StatelessWidget {
  const ProfileBottomAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      elevation: 0,
      child: SizedBox(
        height: 120,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: CustomRoundButton(
                onTap: () {
                  alertDialog(
                      context: context,
                      title: "Not available!",
                      content: "coming soon...");
                },
                buttonText: "Update",
                buttonColor: kDarkBlue,
              ),
            ),
            Center(
              child: CustomRoundButton(
                onTap: () {
                  Navigator.pushNamedAndRemoveUntil(
                      context, RouteName.loginScreen.name, (route) => false);
                },
                buttonText: "Log out",
                buttonColor: kDarkBlue,
              ),
            ),
          ],
        ),
      ),
    );
  }
}