import 'package:flutter/material.dart';
import 'package:inzone/constants.dart';
import 'package:inzone/main_screens/root_app.dart';
import 'package:inzone/main_screens/settings_screens/content_selection_screen.dart';
import 'package:inzone/main_screens/settings_screens/inzone_blockout_screen.dart';
import 'package:inzone/main_screens/settings_screens/inzone_schedule.dart';
import 'package:inzone/main_screens/settings_screens/user_details_screen.dart';
import 'package:inzone/welcome_screens/avatar_customise_page.dart';
import 'package:inzone/welcome_screens/user_signup_screen.dart';

class SignUpPages extends StatefulWidget {
  const SignUpPages({super.key});

  @override
  State<SignUpPages> createState() => _SignUpPagesState();
}

class _SignUpPagesState extends State<SignUpPages> {
  final PageController _controller = PageController();
  bool success = false;
  bool onLastPage = false;

  static const int numPages = 3;
  int currentPage = 1;
  double _value = (1 / numPages);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: screenHeight! * 0.97,
            child: PageView(
              controller: _controller,
              onPageChanged: (index) {
                setState(() {
                  currentPage = index + 1;
                  onLastPage = (currentPage == numPages);
                  _value = ((index + 1) / numPages);
                });
              },
              children: [
                UserSignUpScreen(),
                AvatarCustomisePage(),
                ContentSelectionScreen(),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            alignment: const Alignment(0, 1),
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                currentPage != 1
                    ? GestureDetector(
                        child: const Text(
                          "Back",
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
                            _controller.previousPage(
                                duration: const Duration(seconds: 1),
                                curve: Curves.decelerate);
                          });
                        },
                      )
                    : const Text(
                        "Back",
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
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Text(
                      onLastPage ? "" : currentPage.toString(),
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    CircularProgressIndicator(
                      value: _value,
                      backgroundColor: Colors.grey,
                    ),
                    onLastPage
                        ? const Center(
                            child: Icon(
                              Icons.done,
                              color: Colors.green,
                            ),
                          )
                        : const SizedBox()
                  ],
                ),
                onLastPage
                    ? GestureDetector(
                        child: const Text(
                          "Done",
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
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: ((context) => RootApp())));
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
