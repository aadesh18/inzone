
import 'package:flutter/material.dart';
import 'package:inzone/constants.dart';
import 'package:inzone/welcome_screens/content_selection_pages/custom_page.dart';
import 'package:inzone/welcome_screens/content_selection_pages/fallback_page.dart';
import 'package:inzone/welcome_screens/content_selection_pages/focus_page.dart';

class ContentSelectionSignupScreen extends StatefulWidget {
  bool newUser = false;
   ContentSelectionSignupScreen({super.key, required this.newUser});

  static const int numPages = 3;

  @override
  State<ContentSelectionSignupScreen> createState() =>
      _ContentSelectionSignupScreenState();
}

class _ContentSelectionSignupScreenState
    extends State<ContentSelectionSignupScreen> {
  final PageController _controller = PageController();

  bool success = false;

  bool onLastPage = false;

  int currentPage = 1;

  double _value = (1 / ContentSelectionSignupScreen.numPages);

  List<String> appBarNames = [
    "Details",
    "Choose Your Username",
    "Content Selection"
  ];

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 100),
          child: Container(
            margin: const EdgeInsets.only(bottom: 10),
            height: screenHeight! / 1.4,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                    "Select the content for each mood.",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                const SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: PageView(
                    controller: _controller,
                    onPageChanged: (index) {
                      setState(() {
                        currentPage = index + 1;
                        onLastPage = (currentPage ==
                            ContentSelectionSignupScreen.numPages);
                        _value =
                            ((index + 1) / ContentSelectionSignupScreen.numPages);
                      });
                    },
                    children:  [FocusPage(newUser: widget.newUser), FallBackPage(newUser: widget.newUser), CustomPage(newUser: widget.newUser)],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
