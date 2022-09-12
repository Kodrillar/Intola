import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intola/src/features/auth/presentation/screen/sign_up/sign_up_screen.dart';
import 'package:intola/src/features/user_onboarding/domain/model/onboarding_screen_model.dart';
import 'package:intola/src/utils/constant.dart';
import 'package:intola/src/widgets/buttons/custom_round_button.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);
  static const id = "/onboardingScreen";

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int pageIndex = 0;
  final Duration _duration = const Duration(milliseconds: 200);

  void goToPage(int requiredPageIndex) {
    _pageController.animateToPage(
      requiredPageIndex,
      duration: _duration,
      curve: Curves.easeIn,
    );

    // void changePageColor() {
    //   switch (pageIndex) {
    //     case 0:
    //   }
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kDarkBlue,
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: PageView.builder(
          onPageChanged: (newValue) {
            setState(() {
              pageIndex = newValue;
            });
          },
          controller: _pageController,
          itemCount: OnboardingScreenModel.svgPicture.length,
          itemBuilder: (context, index) => _buildOnboardingScreen(
            OnboardingScreenModel.svgPicture[index],
            OnboardingScreenModel.onboardingText[index],
          ),
        ),
      ),
    );
  }

  Widget _buildOnboardingScreen(svg, onboardingText) {
    return Container(
      color: kDarkBlue,
      width: MediaQuery.of(context).size.width,
      child: ListView(
        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(
              horizontal: 25,
              vertical: 25,
            ),
            height: 350,
            child: SvgPicture.asset(
              "assets/onboardingSvg/" + svg,
            ),
          ),
          const SizedBox(height: 20),
          Container(
            height: 120,
            //  color: Colors.red,
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
          pageIndex == OnboardingScreenModel.svgPicture.length - 5
              ? CustomRoundButton(
                  onTap: () {
                    goToPage(++pageIndex);
                  },
                  buttonName: "Next",
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomRoundButton(
                      onTap: () {
                        goToPage(--pageIndex);
                      },
                      buttonName: "Previous",
                    ),
                    CustomRoundButton(
                      onTap: pageIndex ==
                              OnboardingScreenModel.svgPicture.length - 1
                          ? () {
                              Navigator.pushNamed(context, SignUpScreen.id);
                            }
                          : () {
                              goToPage(++pageIndex);
                            },
                      buttonName: pageIndex ==
                              OnboardingScreenModel.svgPicture.length - 1
                          ? "Get started"
                          : "Next",
                    ),
                  ],
                ),
        ],
      ),
    );
  }
}
