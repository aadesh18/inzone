import 'package:flutter/material.dart';
import 'package:inzone/constants.dart';
import 'package:inzone/welcome_screens/onboard_page.dart';
import 'package:inzone/welcome_screens/phone_number_page.dart';
import 'package:inzone/welcome_screens/sign_up_pages.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class InformationPages extends StatefulWidget {
  const InformationPages({super.key});

  @override
  State<InformationPages> createState() => _InformationPagesState();
}

class _InformationPagesState extends State<InformationPages> {
  List<String> onBoardingPageAnimations = [
    "assets/animations/anonymous.json",
    "assets/animations/ask_questions_animation.json",
    "assets/animations/share_experience_animation.json",
    "assets/animations/chat_animation2.json",
    "assets/animations/join_animation.json",
  ];

  String lineWithCirclesPath = "assets/line_with_circles.png";

  final PageController _controller = PageController();
  bool success = false;

  bool onLastPage = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Stack(
        children: [
          PageView(
            controller: _controller,
            onPageChanged: (index) {
              setState(() {
                onLastPage = (index == 3);
              });
            },
            children: [
              OnBoardingPage(
                  title: "Four steps to InZone",
                  subtitle:
                      "Set your 'moods' to the define your preferred content",
                  assetPath: onBoardingPageAnimations.elementAt(0)),
              OnBoardingPage(
                  title: "InZone TimeTune",
                  subtitle:
                      "Select your 'schedule' to match your preferred content with different parts of your day",
                  assetPath: onBoardingPageAnimations.elementAt(1)),
              OnBoardingPage(
                  title: "InZone BlockOut",
                  subtitle:
                      "Choose the types of content you want to completely block from your feed.",
                  assetPath: onBoardingPageAnimations.elementAt(2)),
              OnBoardingPage(
                  title: "InZone Avatar",
                  subtitle:
                      "Create your InZone persona with our handpicked Avatars",
                  assetPath: onBoardingPageAnimations.elementAt(3)),
            ],
          ),
          Container(
            alignment: const Alignment(0, 0.75),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  child: const Text(
                    "Skip",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.transparent,
                      shadows: [
                        Shadow(color: Colors.black, offset: Offset(0, -4))
                      ],
                      decoration: TextDecoration.underline,
                      decorationColor: Colors.black,
                    ),
                  ),
                  onTap: () {
                    setState(() {
                      _controller.animateToPage(3,
                          duration: const Duration(seconds: 1),
                          curve: Curves.decelerate);
                    });
                  },
                ),
                SmoothPageIndicator(
                  controller: _controller,
                  count: 4,
                  effect:
                      const ExpandingDotsEffect(dotHeight: 12, dotWidth: 12),
                ),
                onLastPage
                    ? GestureDetector(
                        child: const Text(
                          "Let's start ",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.transparent,
                            shadows: [
                              Shadow(color: Colors.black, offset: Offset(0, -4))
                            ],
                            decoration: TextDecoration.underline,
                            decorationColor: Colors.black,
                          ),
                        ),
                        onTap: () async {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: ((context) => const SignUpPages())));
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: ((context) =>
                          //             const PhoneNumberPage())));
                        },
                      )
                    : GestureDetector(
                        child: const Text(
                          "Next",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.transparent,
                            shadows: [
                              Shadow(color: Colors.black, offset: Offset(0, -4))
                            ],
                            decoration: TextDecoration.underline,
                            decorationColor: Colors.black,
                          ),
                        ),
                        onTap: () {
                          _controller.nextPage(
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.easeIn);
                        },
                      )
              ],
            ),
          )
        ],
      ),
    );
  }
}
