import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intola/src/features/cart/presentation/cart_screen_controller.dart';
import 'package:intola/src/utils/constant.dart';

class CartScreenAppBar extends ConsumerWidget with PreferredSizeWidget {
  const CartScreenAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(cartScreenControllerProvider);
    return AppBar(
      leading: state.isLoading
          ? null
          : IconButton(
              color: kDarkBlue,
              icon: const Icon(Icons.arrow_back_ios),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      title: const Text(
        "Cart",
        style: kAppBarTextStyle,
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}
