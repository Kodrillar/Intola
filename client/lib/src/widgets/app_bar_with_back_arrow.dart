import 'package:flutter/material.dart';
import 'package:intola/src/utils/constant.dart';

class AppBarWithBackArrow extends StatelessWidget
    implements PreferredSizeWidget {
  const AppBarWithBackArrow({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        color: kDarkBlue,
        icon: const Icon(Icons.arrow_back_ios),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      title: Text(
        title,
        style: kAppBarTextStyle,
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}
