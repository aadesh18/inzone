import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:inzone/constants.dart';
import 'package:inzone/main_screens/root_app.dart';
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
        preferredSize: const Size.fromHeight(50),
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
            children:  [
              UserSignUpScreen(name: currentUser.getUserName(),),
              ChooseAvatarScreen(),
              //AvatarCustomisePage(),
              ContentSelectionSignupScreen(),
            ],
          ),
          MediaQuery.of(context).viewInsets.bottom == 0
              ? Container(
                  alignment: const Alignment(0, 1),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
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
                                    Shadow(
                                        color: Colors.black,
                                        offset: Offset(0, -4))
                                  ],
                                  decoration: TextDecoration.underline,
                                  decorationColor: Colors.black,
                                ),
                              ),
                              onTap: () async {
                                if (continueSignUp) {
                                  print(continueSignUp);
                                  if (currentUser.getFirstName() == null ||
                                      currentUser.getUserName() == null ||
                                      currentUser.getPassword() == null ||
                                      currentUser.getFocusTopics() == null ||
                                      currentUser.getFallbackTopics() == null) {
                                    final snackBar = SnackBar(
                                      content: Text(
                                          "Error: Please fill all fields !"),
                                      backgroundColor: (Colors.red),
                                    );
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(snackBar);
                                  } else {

                                    try {

                                      final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
                                          email: currentUser.getEmail()!,
                                          password: currentUser.getPassword()!
                                      );

                                      // Assuming you have a Firestore instance initialized
                                      final userCollection = FirebaseFirestore.instance.collection('users');

                                      // Add user data to Firestore
                                      String? email = currentUser.getEmail();

                                      FirebaseAuth.instance.currentUser!.updateDisplayName(currentUser.getUserName()) ;
                                      await userCollection.doc(email!).set({
                                        "age":currentUser.getAge(),
                                        "bio":"",
                                        "categories":{
                                          "focus": currentUser.getFocusTopics(),
                                          "fallback" : currentUser.getFallbackTopics(),
                                          "custom":currentUser.getFallbackTopics()
                                        },
                                        "chats":[],
                                        "email":currentUser.getEmail(),
                                        "family":"",
                                        "firstName": currentUser.getFirstName(),
                                        "lastName": currentUser.getLastName(),
                                        "followers":[],
                                        "following": [],
                                        "gender": currentUser.getGender(),
                                        "parent": false,
                                        "user_name": currentUser.getUserName(),
                                        "ai":false,
                                        "uid":FirebaseAuth.instance.currentUser!.uid.toString()
                                      });

                                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                                        return RootApp();
                                      }));
                                    } on FirebaseAuthException catch (e) {
                                      final snackBar = SnackBar(
                                        content: Text("Error: ${e.message}"),
                                        backgroundColor: Colors.red,
                                      );
                                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                    }

                                  }
                                }
                                else {
                                  final snackBar = const SnackBar(
                                    content: Text(
                                        "Error: Please agree with our Terms of Service!"),
                                    backgroundColor: (Colors.red),
                                  );
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar);
                                }
                              })
                          : GestureDetector(
                              child: const Text(
                                "Next",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Colors.transparent,
                                  shadows: [
                                    Shadow(
                                        color: Colors.black,
                                        offset: Offset(0, -4))
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
              : SizedBox()
        ],
      ),
    );
  }
}
