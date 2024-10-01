import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:inzone/data/inzone_current_user.dart';
import 'package:inzone/data/inzone_post.dart';
import 'package:inzone/main_screens/comment_screen/comment_class.dart';
import 'package:inzone/main_screens/components/post_card.dart';

class PersonalFeedScreen extends StatelessWidget {
  List<PostCard> postsList;
  PersonalFeedScreen({super.key, required this.postsList});


  @override
  Widget build(BuildContext context) {
    // List<Widget> posts = [];
    //
    // for (var element in postsList) {
    //   // Add each post to the posts list with a PostCard widget
    //   print("added");
    //   posts.add(
    //
    //     PostCard(
    //       post: InZonePost(userName: element["user_name"], category: element["main_category"], datePosted: Timestamp.now(), textContent: element["post"]["textContent"], userReference: "user_references", mainCategory: element["category"], comments: [CommentClass.fromJson(element['comments'])]),
    //       onTap: (postId) {
    //         print('You tapped on post with ID: $postId');
    //       },
    //     ),
    //   );
    //
    // }
    postsList.shuffle();

    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: postsList
        ),
      ),
    );
  }
}
