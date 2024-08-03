import 'package:flutter/material.dart';
import 'package:inzone/backend/database.dart';
import 'package:inzone/backend/phone_auth_backend.dart';
import 'package:inzone/constants.dart';
import 'package:inzone/welcome_screens/idea_explanation_page.dart';
import 'package:inzone/welcome_screens/phone_number_page.dart';
import 'package:inzone/welcome_screens/sign_up_pages.dart';
import 'package:lottie/lottie.dart';

import '../data/user_model.dart';

class IntroductionPage extends StatelessWidget {

   // IntroductionPage({});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: commonAppBar("", 0.0),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
        Container(
        padding: const EdgeInsets.all(20),
            height: 400,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),

              gradient: RadialGradient(
                colors: [
                  Colors.white.withOpacity(0.5),
                  backgroundColor
                ],
                radius: 0.5,
                center: Alignment(0.0, 0.0),
                stops: [0.0, 1.0],
              ),
            ),
            child: Lottie.asset('animations/animation_intro.json', height: 250, width: 250),
          ),
           const SizedBox(height: 20,),
           // const  Text(
           //    "The Social Media of Tomorrow",
           //    textAlign: TextAlign.center,
           //
           //    style: TextStyle(
           //    fontSize: 25,
           //    fontWeight: FontWeight.bold
           //  ),),
           const SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
              child: Text("Integrate AI avatars. Customize content. Schedule your social media.",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 19,
                    color: Colors.black.withOpacity(0.7),
                    fontWeight: FontWeight.bold
                ),
              ),
            ),

            const SizedBox(height: 80,),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 30,
              ),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.07,
                width:  MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: backgroundColor.withOpacity(0.9),
                  border: Border.all(
                    color: Colors.white,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12.withOpacity(0.05),
                      spreadRadius: 1,
                      blurRadius: 7,
                      offset: const Offset(0, -1),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.only(right: 5),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: (){
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: ((context) =>  IdeaExplanationPage())));
                        },
                        child: Container(
                          height:  MediaQuery.of(context).size.height * 0.08,
                          width:  MediaQuery.of(context).size.width / 2.2,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: const Center(
                            child: Text(
                              "Register",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 17,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const Spacer(),
                      GestureDetector(
                        onTap: () {
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (context) => const SignIn(),
                          //   ),
                          // );
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => PhoneAuthBackEnd()));
                        },
                        child: Text(
                          "Sign In",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                            color: Colors.black.withOpacity(0.8),
                          ),
                        ),
                      ),


                      const Spacer(),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 20,),
            TextButton(
              onPressed: () async {
                await InZoneDatabase.signUpAnonymouslyAndCreateDocument(context);
              },
              child: Text("Skip for now",
              style: TextStyle(color: Colors.blue, decoration: TextDecoration.underline)),
            ),
          ]
        ),
      )),
    );
  }
}

class MessageWithTitleSubtitleImage extends StatelessWidget {
  final String title;
  final String subTitleFirstLine;
  final String subTitleSecondLine;
  final String imagePath;
  const MessageWithTitleSubtitleImage({
    super.key,
    required this.title,
    required this.subTitleFirstLine,
    required this.subTitleSecondLine,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 500,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          imagePath.isNotEmpty
              ? ScreenshotPlaceHolder(
                  half: false,
                  path: imagePath,
                )
              : const SizedBox(height: 0),
          title.isNotEmpty
              ? Text(
                  title,
                  style: const TextStyle(
                      fontSize: 23, fontWeight: FontWeight.bold),
                )
              : const SizedBox(height: 0),
          const SizedBox(
            height: 10,
          ),
          Text(
            subTitleFirstLine,
            style: const TextStyle(fontSize: 16),
          ),
          Text(
            subTitleSecondLine,
            style: const TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}

class ScreenshotPlaceHolder extends StatelessWidget {
  final String path;
  final bool half;
  const ScreenshotPlaceHolder(
      {super.key, required this.half, required this.path});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      width: MediaQuery.sizeOf(context).width ,
      child: Image.asset(
        path,
        fit: BoxFit.fitHeight,
      ),
    );
    // return Container(
    //   //  height: half ? 300 : 500,
    //   decoration: BoxDecoration(
    //       borderRadius: BorderRadius.circular(20), color: Colors.white),
    //   //padding: const EdgeInsets.all(10),
    //   child: Image.asset(path),
    // );
  }
}



/*
 [
            const Text(
              "Social Media made",
              style: TextStyle(
                fontSize: 34,
              ),
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "fun ",
                  style: TextStyle(
                    fontSize: 34,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "and ",
                  style: TextStyle(
                    fontSize: 34,
                  ),
                ),
                Text(
                  "healthy",
                  style: TextStyle(fontSize: 34, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(
              height: 40,
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
                        horizontal: 80,
                        vertical: 20) //content padding inside button
                    ),
                child: const Text(
                  "Join now for free",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                )),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PhoneAuthBackEnd()));
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
                        horizontal: 120,
                        vertical: 20) //content padding inside button
                    ),
                child: const Text(
                  "Log in",
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                )),
            // const SizedBox(height: 50),
            // const ScreenshotPlaceHolder(
            //   half: false,
            //   path: "assets/home.png",
            // ),
            const SizedBox(
              height: 50,
            ),
            const Text(
              "InZone enhances your ",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
            ),
            const Text(
              "social media experience by: ",
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
            const MessageWithTitleSubtitleImage(
                title: "InZone AI",
                subTitleFirstLine: "Interact with the best AI Powered",
                subTitleSecondLine: "avatars online",
                imagePath: "assets/intro_img_2.png"),
            const SizedBox(
              height: 100,
            ),
            const MessageWithTitleSubtitleImage(
                title: "ToneShield",
                subTitleFirstLine: "Shields users from distubing content",
                subTitleSecondLine: "before it gets posted",
                imagePath: "assets/intro_img_3.png"),
            const SizedBox(
              height: 100,
            ),
            const MessageWithTitleSubtitleImage(
                title: "InZone Scheduling",
                subTitleFirstLine: "Become the 'algorithm' and choose what",
                subTitleSecondLine: " works for you",
                imagePath: "assets/intro_img_4.png"),
            const SizedBox(
              height: 100,
            ),

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
 */





