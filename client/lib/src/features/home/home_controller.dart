import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreenController extends StateNotifier<String> {
  HomeScreenController() : super('Supermarket');

  void changeDropdownMenuItem(String newValue) {
    state = newValue;
  }
}

final homeScreenControllerProvider =
    StateNotifierProvider.autoDispose<HomeScreenController, String>(
        (ref) => HomeScreenController());
