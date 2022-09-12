import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intola/src/features/auth/presentation/screen/sign_up/sign_up_screen.dart';
import 'package:intola/src/features/user_onboarding/presentation/onboarding_screen_controller.dart';
import 'package:intola/src/utils/constant.dart';
import 'package:intola/src/widgets/buttons/custom_round_button.dart';

class OnboardingView extends ConsumerWidget {
  const OnboardingView({
    Key? key,
    required this.onboardingText,
    required this.svgName,
    required this.goToPage,
  }) : super(key: key);

  final String svgName;
  final String onboardingText;
  final void Function(int) goToPage;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(onboardingScreenControllerProvider.notifier);
    return Container(
      color: kDarkBlue,
      width: MediaQuery.of(context).size.width,
      child: ListView(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(
              horizontal: 25,
              vertical: 25,
            ),
            height: 350,
            child: SvgPicture.asset(
              "assets/onboardingSvg/" + svgName,
            ),
          ),
          const SizedBox(height: 20),
          Container(
            height: 120,
            margin: const EdgeInsets.symmetric(horizontal: 30),
            child: Text(
              onboardingText,
              style: const TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w800,
                color: kDarkOrange,
              ),
            ),
          ),
          const SizedBox(height: 50),
          state.showNextButton()
              ? CustomRoundButton(
                  onTap: () {
                    goToPage(
                      ref
                          .read(onboardingScreenControllerProvider.notifier)
                          .goToNextPage(),
                    );
                  },
                  buttonText: "Next",
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomRoundButton(
                      onTap: () {
                        goToPage(
                          ref
                              .read(onboardingScreenControllerProvider.notifier)
                              .goToPreviousPage(),
                        );
                      },
                      buttonText: "Previous",
                    ),
                    CustomRoundButton(
                      onTap: ref
                              .read(onboardingScreenControllerProvider.notifier)
                              .navigateToAuthScreen()
                          ? () {
                              Navigator.pushNamed(context, SignUpScreen.id);
                            }
                          : () {
                              goToPage(
                                ref
                                    .read(onboardingScreenControllerProvider
                                        .notifier)
                                    .goToNextPage(),
                              );
                            },
                      buttonText:
                          state.changeButtonText() ? "Get started" : "Next",
                    ),
                  ],
                ),
        ],
      ),
    );
  }
}
