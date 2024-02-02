import 'package:flutter/material.dart';
import 'package:inzone/constants.dart';
import 'package:inzone/welcome_screens/information_pages.dart';
import 'package:inzone/welcome_screens/phone_number_page.dart';

class IntroductionPage extends StatelessWidget {
  const IntroductionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      // appBar: AppBar(
      //   elevation: 0,
      //   foregroundColor: backgroundColor,
      //   backgroundColor: backgroundColor,
      // ),
      body: SafeArea(
        child: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Social Media made",
                style: TextStyle(
                  fontSize: 34,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
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
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const InformationPages()));
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
                            builder: (context) => const PhoneNumberPage()));
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

              const MessageWithTitleSubtitleImage(
                  title: "InZone Avatars",
                  subTitleFirstLine:
                      "Design fun avatars to interact with friends,",
                  subTitleSecondLine: "family and community",
                  imagePath: "assets/intro_img_1.png"),
              const SizedBox(
                height: 100,
              ),
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
                  imagePath: "assets/intro_img_2.png"),
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
          ),
        )),
      ),
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
    return Container(
      height: 800,
      child: Column(
        children: [
          imagePath.isNotEmpty
              ? ScreenshotPlaceHolder(
                  half: false,
                  path: imagePath,
                )
              : const SizedBox(height: 0),
          const SizedBox(
            height: 20,
          ),
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
    return Expanded(
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
