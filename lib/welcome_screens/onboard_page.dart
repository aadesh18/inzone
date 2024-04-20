import 'package:flutter/material.dart';
import 'package:inzone/constants.dart';
import 'package:lottie/lottie.dart';

class OnBoardingPage extends StatelessWidget {
  final String title;
  final String subtitle;
  final String assetPath;

  const OnBoardingPage(
      {super.key,
      required this.title,
      required this.subtitle,
      required this.assetPath});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 1,
            child: Text(title,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 28)),
          ),
          Expanded(
            flex: 2,
            child: Lottie.asset(assetPath,
                height: screenHeight! / 6, width: screenWidth! - 10),
          ),
          const SizedBox(
            height: 20,
          ),
          Expanded(
              flex: 2,
              child: Text(subtitle,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontWeight: FontWeight.normal, fontSize: 20))),
        ],
      ),
    ));
  }
}
