import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intola/src/features/user_onboarding/domain/model/onboarding_screen_model.dart';

class OnboardingScreenController extends StateNotifier<int> {
  OnboardingScreenController() : super(0);

  void onPageChange(int pageIndex) {
    state = pageIndex;
  }

  bool showNextButton() {
    if (state == 0) return true;
    return false;
  }

  int goToNextPage() {
    state = ++state;
    return state;
  }

  int goToPreviousPage() {
    state = --state;
    return state;
  }

  bool changeButtonText() {
    if (state == OnboardingScreenModel.svgPicture.length - 1) return true;
    return false;
  }

  bool navigateToAuthScreen() {
    return changeButtonText();
  }
}

final onboardingScreenControllerProvider =
    StateNotifierProvider<OnboardingScreenController, int>(
        (ref) => OnboardingScreenController());
