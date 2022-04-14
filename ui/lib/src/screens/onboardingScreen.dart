import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intola/src/models/unboardingScreen/onboardingScreenModel.dart';
import 'package:intola/src/screens/auth/signUpScreen.dart';
import 'package:intola/src/utils/constant.dart';
import 'package:intola/src/widgets/buttons/customButton.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);
  static const id = "/onboardingScreen";

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  PageController _pageController = PageController();
  int pageIndex = 0;
  Duration _duration = Duration(milliseconds: 200);

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
      body: PageView.builder(
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
            margin: EdgeInsets.symmetric(horizontal: 25),
            height: 350,
            child: SvgPicture.asset(
              "assets/onboardingSvg/" + svg,
            ),
          ),
          SizedBox(height: 50),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Text(
              onboardingText,
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w800,
                color: kDarkOrange,
              ),
            ),
          ),
          SizedBox(height: 110),
          pageIndex == OnboardingScreenModel.svgPicture.length - 5
              ? CustomButton(
                  onTap: () {
                    goToPage(++pageIndex);
                  },
                  buttonName: "Next",
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomButton(
                      onTap: () {
                        goToPage(--pageIndex);
                      },
                      buttonName: "Previous",
                    ),
                    CustomButton(
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
