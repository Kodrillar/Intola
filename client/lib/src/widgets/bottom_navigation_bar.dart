import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intola/src/features/home/data/home_repository.dart';
import 'package:intola/src/utils/constant.dart';

class CustomBottomNavigationBar extends ConsumerWidget {
  const CustomBottomNavigationBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return BottomNavigationBar(
      onTap: (newIndex) {
        ref.read(bottomNavigationBarIndexProvider.notifier).state = newIndex;
      },
      currentIndex: ref.watch(bottomNavigationBarIndexProvider),
      unselectedIconTheme: const IconThemeData(color: kDarkBlue),
      selectedIconTheme: const IconThemeData(color: kDarkOrange),
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_outlined),
          label: 'home',
        ),
        BottomNavigationBarItem(
            icon: Icon(Icons.clean_hands_outlined), label: ''),
        BottomNavigationBarItem(
            icon: Icon(Icons.local_shipping_outlined), label: ''),
        BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart_checkout_sharp), label: ''),
      ],
    );
  }
}
