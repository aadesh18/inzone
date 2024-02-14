import 'package:flutter/material.dart';
import 'package:inzone/constants.dart';
import 'package:inzone/main_screens/components/inzone_search_bar.dart';

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
            flex: 5,
            child: ListView(
              children: [
                ListTile(
                  leading: Image.asset("images/sample_avatar_2.png"),
                  title: const Text("_.david_"),
                  subtitle: const Text("David Morel"),
                  trailing: TextButton(
                    style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.circular(100.0),
                                    side: const BorderSide(color: Colors.blue)))),
                    onPressed: () {},
                    child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.0),
                      child: Text("Following"),
                    ),
                  ),
                ),
                ListTile(
                  leading: Image.asset("images/sample_avatar_2.png"),
                  title: const Text("_.david_"),
                  subtitle: const Text("David Morel"),
                  trailing: TextButton(
                    style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.circular(100.0),
                                    side: const BorderSide(color: Colors.blue)))),
                    onPressed: () {},
                    child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.0),
                      child: Text("Following"),
                    ),
                  ),
                ),
                ListTile(
                  leading: Image.asset("images/sample_avatar_2.png"),
                  title: const Text("_.david_"),
                  subtitle: const Text("David Morel"),
                  trailing: TextButton(
                    style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.circular(100.0),
                                    side: const BorderSide(color: Colors.blue)))),
                    onPressed: () {},
                    child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.0),
                      child: Text("Following"),
                    ),
                  ),
                ),
                ListTile(
                  leading: Image.asset("images/sample_avatar_2.png"),
                  title: const Text("_.david_"),
                  subtitle: const Text("David Morel"),
                  trailing: TextButton(
                    style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.circular(100.0),
                                    side: const BorderSide(color: Colors.blue)))),
                    onPressed: () {},
                    child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.0),
                      child: Text("Following"),
                    ),
                  ),
                ),
                ListTile(
                  leading: Image.asset("images/sample_avatar_2.png"),
                  title: const Text("_.david_"),
                  subtitle: const Text("David Morel"),
                  trailing: TextButton(
                    style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.circular(100.0),
                                    side: const BorderSide(color: Colors.blue)))),
                    onPressed: () {},
                    child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.0),
                      child: Text("Following"),
                    ),
                  ),
                ),
                ListTile(
                  leading: Image.asset("images/sample_avatar_2.png"),
                  title: const Text("_.david_"),
                  subtitle: const Text("David Morel"),
                  trailing: TextButton(
                    style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.circular(100.0),
                                    side: const BorderSide(color: Colors.blue)))),
                    onPressed: () {},
                    child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.0),
                      child: Text("Following"),
                    ),
                  ),
                ),
                ListTile(
                  leading: Image.asset("images/sample_avatar_2.png"),
                  title: const Text("_.david_"),
                  subtitle: const Text("David Morel"),
                  trailing: TextButton(
                    style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.circular(100.0),
                                    side: const BorderSide(color: Colors.blue)))),
                    onPressed: () {},
                    child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.0),
                      child: Text("Following"),
                    ),
                  ),
                ),
                ListTile(
                  leading: Image.asset("images/sample_avatar_2.png"),
                  title: const Text("_.david_"),
                  subtitle: const Text("David Morel"),
                  trailing: TextButton(
                    style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.circular(100.0),
                                    side: const BorderSide(color: Colors.blue)))),
                    onPressed: () {},
                    child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.0),
                      child: Text("Following"),
                    ),
                  ),
                ),
                ListTile(
                  leading: Image.asset("images/sample_avatar_2.png"),
                  title: const Text("_.david_"),
                  subtitle: const Text("David Morel"),
                  trailing: TextButton(
                    style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.circular(100.0),
                                    side: const BorderSide(color: Colors.blue)))),
                    onPressed: () {},
                    child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.0),
                      child: Text("Following"),
                    ),
                  ),
                )
              ],
            ),
          ),
          Flexible(
            flex: 1,
            child: Container(
              height: 120,
              width: screenWidth!,
              decoration: const BoxDecoration(
                color: backgroundColor,
                boxShadow: [
                  BoxShadow(
                    color: backgroundColor,
                    spreadRadius: 30,
                    blurRadius: 80,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: const Row(
                crossAxisAlignment: CrossAxisAlignment.start,
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
