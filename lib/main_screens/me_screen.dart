import 'dart:math';

import 'package:flutter/material.dart';
import 'package:inzone/constants.dart';
import 'package:inzone/main_screens/me_screen/followers_following_screen.dart';
import 'package:inzone/main_screens/me_screen/liked_screen.dart';
import 'package:inzone/main_screens/me_screen/personal_feed_screen.dart';
import 'package:inzone/main_screens/settings_screen.dart';
import 'package:random_avatar/random_avatar.dart';

class MeScreen extends StatefulWidget {
  const MeScreen({super.key});

  @override
  State<MeScreen> createState() => _MeScreenState();
}

class _MeScreenState extends State<MeScreen>
    with SingleTickerProviderStateMixin {
  int currentPage = 0;

  Widget getScreen() {
    if (currentPage == 0) {
      return const PersonalFeedScreen();
    } else if (currentPage == 1) {
      return const LikedScreen();
    } else {
      return const FollowersFollowingScreen();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // const Text(
          //   "Profile",
          //   style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
          // ),
          Container(
            height: 80,
//width: screenWidth!,
            child: Row(
              children: [
                // CircleAvatar(
                //   radius: 30,
                //   child:
                //       RandomAvatar("Renny Williams", height: 100, width: 100),
                // ),

                Padding(
                  padding: const EdgeInsets.only(left: 10.0, right: 10),
                  child: RandomAvatar("Renny Williams", height: 80, width: 30),
                ),
                Expanded(
                  // height: 80,
                  // width: 100,
                  child: ListTile(
                    // leading: Image.asset(
                    //   "images/sample_avatar_2.png",
                    //   scale: 0.5,
                    // ),

                    title: const Text(
                      "Renny Williams",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: const Text("Embrace the moment, share the joy!"),
                    trailing: IconButton(
                        onPressed: () {
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: ((context) {
                            return const SettingsScreen();
                          })));
                        },
                        icon: const Icon(
                          Icons.settings,
                          color: Colors.black,
                        )),
                  ),
                )
              ],
            ),
          ),
          //const Divider(),
          const SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            mainAxisSize: MainAxisSize.max,
            children: [
              TextButton(
                onPressed: () {
                  setState(() {
                    currentPage = 0;
                  });
                },
                child: Text("Feed",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: currentPage == 0
                            ? FontWeight.bold
                            : FontWeight.normal)),
              ),
              // const Text(" | ",
              //     style: TextStyle(color: Colors.black54, fontSize: 20)),
              TextButton(
                onPressed: () {
                  setState(() {
                    currentPage = 1;
                  });
                },
                child: Text("Likes",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: currentPage == 1
                            ? FontWeight.bold
                            : FontWeight.normal)),
              ),
              // const Text(" | ",
              //     style: TextStyle(color: Colors.black, fontSize: 20)),
              TextButton(
                onPressed: () {
                  setState(() {
                    currentPage = 2;
                  });
                },
                child: Text("Community",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: currentPage == 2
                            ? FontWeight.bold
                            : FontWeight.normal)),
              )
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          getScreen()
        ],
      ),
    ));
  }
}
