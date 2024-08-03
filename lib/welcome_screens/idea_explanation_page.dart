import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:inzone/backend/database.dart';
import 'package:inzone/backend/phone_auth_backend.dart';
import 'package:inzone/welcome_screens/introduction_page.dart';
import 'package:inzone/welcome_screens/sign_up_pages.dart';
import 'package:lottie/lottie.dart';

import '../constants.dart';

class IdeaExplanationPage extends StatefulWidget {
  const IdeaExplanationPage({super.key});

  @override
  State<IdeaExplanationPage> createState() => _IdeaExplanationPageState();
}

class _IdeaExplanationPageState extends State<IdeaExplanationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Icon(
                Icons.arrow_back_ios_rounded,
                size: 25,
                color: Colors.black,
              ),
            ),
            const Text(
              "Welcome to InZone",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            const SizedBox(
              width: 20,
            )
          ],
        ),
        backgroundColor: backgroundColor,
        elevation: 0,
      ),
      body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                      onPressed: () {
// Navigator.push(
//     context,
//     MaterialPageRoute(
//         builder: (context) => const InformationPages()));
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: ((context) =>  SignUpPages())));
                      },
                      style: ElevatedButton.styleFrom(
                          elevation: 10,
                          backgroundColor: Colors.blue,
//elevation of button
                          shape: RoundedRectangleBorder(
//to set border radius to button
                              borderRadius: BorderRadius.circular(30)),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 120,
                              vertical: 20)
                      ),
                      child: const Text(
                        "Register",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      )),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                      onPressed: () async {
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => SignUpPages()));
                        await InZoneDatabase.signUpAnonymouslyAndCreateDocument(context);
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.white,
                          surfaceTintColor: Colors.white,
                          elevation: 10,
//elevation of button
                          shape: RoundedRectangleBorder(
//to set border radius to button
                              side: const BorderSide(width: 1, color: Colors.white),
                              borderRadius: BorderRadius.circular(30)),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 80,
                              vertical: 20) //content padding inside button
                      ),
                      child: const Text(
                        "Skip for now",
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      )),
                  const SizedBox(
                    height: 60,
                  ),
                  // const Text(
                  //   "Social Media made",
                  //   style: TextStyle(
                  //     fontSize: 34,
                  //   ),
                  // ),
                  // const Row(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   crossAxisAlignment: CrossAxisAlignment.center,
                  //   children: [
                  //     Text(
                  //       "fun ",
                  //       style: TextStyle(
                  //         fontSize: 34,
                  //         fontWeight: FontWeight.bold,
                  //       ),
                  //     ),
                  //     Text(
                  //       "and ",
                  //       style: TextStyle(
                  //         fontSize: 34,
                  //       ),
                  //     ),
                  //     Text(
                  //       "healthy",
                  //       style: TextStyle(fontSize: 34, fontWeight: FontWeight.bold),
                  //     ),
                  //   ],
                  // ),
                  // const SizedBox(
                  //   height: 40,
                  // ),

// const SizedBox(height: 50),
// const ScreenshotPlaceHolder(
//   half: false,
//   path: "assets/home.png",
// ),
//                   const SizedBox(
//                     height: 50,
//                   ),
                  Container(height: 40,child: const Divider(),),
                  const Text(
                    "Key Features",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
                  ),


//
// const MessageWithTitleSubtitleImage(
//     title: "InZone Avatars",
//     subTitleFirstLine:
//         "Design fun avatars to interact with friends,",
//     subTitleSecondLine: "family and community",
//     imagePath: "assets/intro_img_1.png"),
// const SizedBox(
//   height: 100,
// ),
//                   const MessageWithTitleSubtitleImage(
//                       title: "InZone AI",
//                       subTitleFirstLine: "Interact with the best AI Powered",
//                       subTitleSecondLine: "avatars online",
//                       imagePath: "assets/intro_img_2.svg"),
//                   const SizedBox(
//                     height: 50,
//                   ),
                  const MessageWithTitleSubtitleImage(
                      title: "InZone Avatars",
                      subTitleFirstLine: "Pick fun and random avatars",
                      subTitleSecondLine: 'unique to you',
                      imagePath: "assets/intro_img_4.png"),
                  Divider(),
                  const MessageWithTitleSubtitleImage(
                      title: "InZone Scheduling",
                      subTitleFirstLine: "Become the 'algorithm' and choose what",
                      subTitleSecondLine: " works for you",
                      imagePath: "assets/intro_img_1.png"),
                  Divider(),
                  const MessageWithTitleSubtitleImage(
                      title: "ToneShield",
                      subTitleFirstLine: "Shields users from disturbing content",
                      subTitleSecondLine: "before it gets posted",
                      imagePath: "assets/intro_img_3.png"),





// TODO - Finish this part

// const Text(
//   "All your social media in",
//   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
// ),
// const Text(
//   "one app",
//   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
// ),
// const MessageWithTitleSubtitleImage(
//     title: "",
//     subTitleFirstLine: " Srgeojrepo ger gieroi nlgreglin eroi g ",
//     subTitleSecondLine: "plrgiejrgoi ejrgr ejo.",
//     imageWord: ""),
// Row(
//   mainAxisAlignment: MainAxisAlignment.start,
//   crossAxisAlignment: CrossAxisAlignment.start,
//   children: const [
//     SizedBox(
//       width: 15,
//     ),
//     Icon(
//       Icons.check_box_outlined,
//     ),
//     Spacer(),
//     Icon(Icons.access_alarm, size: 40),
//     Text("Feeds, Comments, Inboxes")
//   ],
// )


                ],
            ),
          )),
    );
  }
}
