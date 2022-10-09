import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intola/src/features/user_onboarding/domain/model/onboarding_screen_model.dart';
import 'package:intola/src/features/user_onboarding/presentation/onboarding_screen_controller.dart';
import 'package:intola/src/features/user_onboarding/presentation/onboarding_view.dart';
import 'package:intola/src/utils/constant.dart';
import 'package:intola/src/widgets/annotated_region.dart';

class OnboardingScreen extends ConsumerWidget {
  OnboardingScreen({Key? key}) : super(key: key);
  final PageController _pageController = PageController();

  final Duration _duration = const Duration(milliseconds: 400);

  void goToPage(int pageIndex) {
    _pageController.animateToPage(
      pageIndex,
      duration: _duration,
      curve: Curves.linearToEaseOut,
    );

    // void changePageColor() {
    //   switch (pageIndex) {
    //     case 0:
    //   }
    // }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: kDarkBlue,
      body: SystemUIOverlayAnnotatedRegion(
        systemUiOverlayStyle: SystemUiOverlayStyle.light,
        child: PageView.builder(
          onPageChanged: ref
              .read(onboardingScreenControllerProvider.notifier)
              .onPageChange,
          controller: _pageController,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: OnboardingScreenModel.svgPicture.length,
          itemBuilder: (context, index) => OnboardingView(
            goToPage: goToPage,
            svgName: OnboardingScreenModel.svgPicture[index],
            onboardingText: OnboardingScreenModel.onboardingText[index],
          ),
        ),
      ),
    );
  }
}
