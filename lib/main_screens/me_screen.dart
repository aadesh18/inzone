import 'package:flutter/material.dart';
import 'package:inzone/constants.dart';
import 'package:inzone/main_screens/components/post_card.dart';
import 'package:inzone/main_screens/me_screen/followers_following_screen.dart';
import 'package:inzone/main_screens/me_screen/liked_screen.dart';
import 'package:inzone/main_screens/me_screen/personal_feed_screen.dart';
import 'package:inzone/main_screens/settings_screen.dart';
import 'package:random_avatar/random_avatar.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class MeScreen extends StatefulWidget {

  List<PostCard> posts;
  String userName;

  MeScreen({super.key, required this.posts, required this.userName});

  @override
  State<MeScreen> createState() => _MeScreenState();
}

class _MeScreenState extends State<MeScreen>
    with SingleTickerProviderStateMixin {

  int currentPage = 0;
  List<dynamic> postsList = [];

  Widget getScreen() {
    if (currentPage == 0) {
      // getUserPosts(currentUser.getUserName().toString()).then((value){
      //   return PersonalFeedScreen(postsList: value,);
      // });
      return PersonalFeedScreen(postsList: widget.posts);

    } else if (currentPage == 1) {
      return const LikedScreen();
    } else {
      return const FollowersFollowingScreen();
    }
  }
  @override
  void initState() {
    super.initState();
  }

  Future<List<Map<String, dynamic>>> getUserPosts(String userId) async {
    final url = Uri.parse('https://us-central1-inzonebackend.cloudfunctions.net/api/get_user_posts');

    try {
      // Prepare the POST request body with the currentUser's ID
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({'id': userId}),
      );

      // Check if the response is successful (status code 200)
      if (response.statusCode == 200) {
        // Parse the JSON response
        final Map<String, dynamic> parsedJson = jsonDecode(response.body);

        // Extract the "posts" list and cast it to List<Map<String, dynamic>>
        List<Map<String, dynamic>> postsList = List<Map<String, dynamic>>.from(parsedJson['posts']);

        // Print each post to verify
        postsList.forEach((post) {
          print('Post ID: ${post['id']}');
          print('Text Content: ${post['data']['post']['textContent']}');
          print('Likes: ${post['data']['likes']}');
          print('Image URL: ${post['data']['post']['image_content'].isNotEmpty ? post['data']['post']['image_content'].first : 'No Image'}');
          print('---');
        });
        // Return the list of parsed posts
        setState(() {
          postsList.reversed;
        });
        return postsList;
      } else {
        // Handle non-200 status codes, could be an error
        throw Exception('Failed to load posts');
      }
    } catch (e) {
      // Handle any exceptions or errors during the request
      throw Exception('Error getting posts: $e');
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
   appBar: AppBar(
     scrolledUnderElevation: 0,
     backgroundColor: backgroundColor, title: Text(
     widget.userName,


     style: TextStyle(fontWeight: FontWeight.bold),
   ), ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.only(top: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // const Text(
            //   "Profile",
            //   style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            // ),
            SizedBox(
              height: 80,
      //width: screenWidth!,
              child: Row(
                children: [
                  // CircleAvatar(
                  //   radius: 30,
                  //   child:
                  //       RandomAvatar("Renny Dedws", height: 100, width: 100),
                  // ),

                  Padding(
                    padding: const EdgeInsets.only(left: 10.0, right: 10),
                    child: RandomAvatar("Renny aadesh", height: 60, width: 30),
                  ),
                  Expanded(
                    // height: 80,
                    // width: 100,
                    child: ListTile(
                      // leading: Image.asset(
                      //   "images/sample_avatar_2.png",
                      //   scale: 0.5,
                      // ),


                      title: const Text("Embrace the moment, share the joy!"),
                      // trailing: IconButton(
                      //     onPressed: () {
                      //       // Navigator.of(context)
                      //       //     .push(MaterialPageRoute(builder: ((context) {
                      //       //   return const SettingsScreen();
                      //       // })));
                      //     },
                      //     icon: const Icon(
                      //       Icons.settings,
                      //       color: Colors.black,
                      //     )),
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
                          fontSize: 16,
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
                          fontSize: 16,
                          fontWeight: currentPage == 1
                              ? FontWeight.bold
                              : FontWeight.normal)),
                ),
                // const Text(" | ",
                //     style: TextStyle(color: Colors.black, fontSize: 20)),
                // TextButton(
                //   onPressed: () {
                //     setState(() {
                //       currentPage = 2;
                //     });
                //   },
                //   child: Text("Community",
                //       style: TextStyle(
                //           color: Colors.black,
                //           fontSize: 16,
                //           fontWeight: currentPage == 2
                //               ? FontWeight.bold
                //               : FontWeight.normal)),
                // )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            getScreen()
          ],
        ),
      )),
    );
  }
}
