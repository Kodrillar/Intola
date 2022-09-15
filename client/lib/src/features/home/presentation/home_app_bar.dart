import 'package:flutter/material.dart';
import 'package:intola/src/features/profile/presentation/screens/profile_screen.dart';
import 'package:intola/src/utils/constant.dart';

class HomeAppBar extends StatelessWidget with PreferredSizeWidget {
  const HomeAppBar({Key? key, required this.userName}) : super(key: key);

  final String? userName;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(30),
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  "Hi, $userName",
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: kHeadingTextStyle,
                ),
              ),
            ),
          ],
        ),
      ),
      actions: [
        IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ProfileScreen(),
              ),
            );
          },
          icon: const Icon(
            Icons.account_circle,
            color: kDarkBlue,
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(110);
}
