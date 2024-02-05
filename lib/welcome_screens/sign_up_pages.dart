import 'package:flutter/material.dart';
import 'package:inzone/constants.dart';
import 'package:inzone/main_screens/root_app.dart';
import 'package:inzone/main_screens/settings_screens/content_selection_screen.dart';
import 'package:inzone/welcome_screens/choose_avatar.dart';
import 'package:inzone/welcome_screens/content_selection_signup_screen.dart';
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

  List<String> appBarNames = [
    "Details",
    "Choose Your Username",
    "Content Selection"
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: AppBar(
          elevation: 0,
          automaticallyImplyLeading: false,
          backgroundColor: backgroundColor,
          title: Text(appBarNames[currentPage - 1],
              style:
                  const TextStyle(fontSize: 26, fontWeight: FontWeight.w700)),
        ),
      ),
      body: Stack(
        children: [
          PageView(
            controller: _controller,
            onPageChanged: (index) {
              setState(() {
                currentPage = index + 1;
                onLastPage = (currentPage == numPages);
                _value = ((index + 1) / numPages);
              });
            },
            children: const [
              UserSignUpScreen(),
              ChooseAvatarScreen(),
              //AvatarCustomisePage(),
              ContentSelectionSignupScreen(),
            ],
          ),
          Container(
            alignment: const Alignment(0, 1),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
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
                    if (currentPage == 1) {
                      Navigator.pop(context);
                    }
                    setState(() {
                      _controller.previousPage(
                          duration: const Duration(seconds: 1),
                          curve: Curves.decelerate);
                    });
                  },
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
                        ? const Icon(
                            Icons.done,
                            color: Colors.green,
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
