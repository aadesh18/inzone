import 'package:flutter/material.dart';
import 'package:inzone/constants.dart';
import 'package:inzone/main_screens/components/inzone_search_bar.dart';
import 'package:random_avatar/random_avatar.dart';

class FollowersFollowingScreen extends StatefulWidget {

  const FollowersFollowingScreen({super.key});

  @override
  State<FollowersFollowingScreen> createState() =>
      _FollowersFollowingScreenState();
}

class _FollowersFollowingScreenState extends State<FollowersFollowingScreen> {
  bool followersSelected = true;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Flexible(
            flex: 1,
            child: Container(
              width: screenWidth! - 10,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(100)),
              child: Row(children: [
                Expanded(
                  child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          followersSelected = true;
                        });
                      },
                      style: ButtonStyle(
                          elevation: MaterialStateProperty.all(0),
                          backgroundColor: followersSelected
                              ? MaterialStateProperty.all(Colors.blue)
                              : MaterialStateProperty.all(Colors.white),
                          foregroundColor:
                              MaterialStateProperty.all(Colors.black),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100.0),
                          ))),
                      child: const Text("Followers")),
                ),
                Expanded(
                  child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          followersSelected = false;
                        });
                      },
                      style: ButtonStyle(
                          elevation: MaterialStateProperty.all(0),
                          backgroundColor: followersSelected
                              ? MaterialStateProperty.all(Colors.white)
                              : MaterialStateProperty.all(Colors.blue),
                          foregroundColor:
                              MaterialStateProperty.all(Colors.black),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100.0),
                          ))),
                      child: const Text("Followers")),
                ),
              ]),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          const Flexible(
            flex: 1,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: InZoneSearchBar(
                backgroundColor: Color(0xffA8D7E9),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Flexible(
            flex: 7,
            child: ListView(
              children: [
                ListTile(
                  leading: RandomAvatar("Renny Dedws", height: 50, width: 30),
                  title: const Text("_.david_"),
                  subtitle: const Text("David Morel"),
                  trailing: FollowButton()
                ),
                ListTile(
                    leading: RandomAvatar("Renny Dedws", height: 50, width: 30),
                    title: const Text("_.david_"),
                    subtitle: const Text("David Morel"),
                    trailing: FollowButton()
                ),
                ListTile(
                    leading: RandomAvatar("Renny Dedws", height: 50, width: 30),
                    title: const Text("_.david_"),
                    subtitle: const Text("David Morel"),
                    trailing: FollowButton()
                ),
                ListTile(
                    leading: RandomAvatar("Renny Dedws", height: 50, width: 30),
                    title: const Text("_.david_"),
                    subtitle: const Text("David Morel"),
                    trailing: FollowButton()
                ),                ListTile(
                    leading: RandomAvatar("Renny Dedws", height: 50, width: 30),
                    title: const Text("_.david_"),
                    subtitle: const Text("David Morel"),
                    trailing: FollowButton()
                ),
                ListTile(
                    leading: RandomAvatar("Renny Dedws", height: 50, width: 30),
                    title: const Text("_.david_"),
                    subtitle: const Text("David Morel"),
                    trailing: FollowButton()
                ),
                ListTile(
                    leading: RandomAvatar("Renny Dedws", height: 50, width: 30),
                    title: const Text("_.david_"),
                    subtitle: const Text("David Morel"),
                    trailing: FollowButton()
                ),
                ListTile(
                    leading: RandomAvatar("Renny Dedws", height: 50, width: 30),
                    title: const Text("_.david_"),
                    subtitle: const Text("David Morel"),
                    trailing: FollowButton()
                ),
              ],
            ),
          ),
          Flexible(
            flex: 1,
            child: Container(
              height: 90,
              width: screenWidth!,
              decoration: const BoxDecoration(
                color: backgroundColor,
                boxShadow: [
                  BoxShadow(
                    color: backgroundColor,
                    spreadRadius: 40,
                    blurRadius: 40,
                    offset: Offset(0,6), // changes position of shadow
                  ),
                ],
              ),
              child: const Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "121",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    " Following ",
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "250",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    " Followers",
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}


class FollowButton extends StatefulWidget {
  @override
  _FollowButtonState createState() => _FollowButtonState();
}

class _FollowButtonState extends State<FollowButton> {
  bool isFollowing = true; // Initial state is "Following"

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(
          isFollowing ? Colors.blue : Colors.transparent, // Filled when following, transparent when not
        ),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100.0),
            side: const BorderSide(color: Colors.blue), // Always outlined with blue
          ),
        ),
      ),
      onPressed: () {
        setState(() {
          isFollowing = !isFollowing; // Toggle between following and not following
        });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Text(
          isFollowing ? "Following" : "Follow", // Change text based on state
          style: TextStyle(
            color: isFollowing ? Colors.white : Colors.blue, // White text for filled, blue for outlined
          ),
        ),
      ),
    );
  }
}


