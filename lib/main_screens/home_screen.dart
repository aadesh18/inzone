import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:inzone/backend/database.dart';
import 'package:inzone/data/inzone_current_user.dart';
import 'package:inzone/data/inzone_user.dart';
import 'package:inzone/main_screens/components/category_selector.dart';
import 'package:inzone/main_screens/components/category_selector_bar.dart';
import 'package:inzone/main_screens/components/post_card.dart';
import  'package:string_similarity/string_similarity.dart';

import '../backend/collection_names.dart';



class HomeScreen extends StatefulWidget {

  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<PostCard> posts = [];
  List<Widget>  categories = [];
  List<String> categoriesList = [];


  getFeed() async {
    posts.clear();
    await InZoneDatabase.getFeed("posts").then((value) {
      categoriesList.clear();
      for (var element in value) {
        print(element.category);
        posts.add(
          PostCard(
            post: element,
            onTap: (postId) {
              // Show the ID of the tapped post
            print('You tapped on post with ID: $postId');
            },
          ),
        );
        categoriesList.add(element.category);
      }

      setState(() {
        posts.reversed;
        categoriesList.reversed;
      });
    });
  }


 triggerSortingBy(String value){
    setState(() {
      posts.sort((a, b) =>
          b.post.category.similarityTo(value).compareTo(a.post.category.similarityTo(value)));

    });
posts.forEach((element) {print(element.post.id);});

 }



  @override
  void initState() {
    // TODO: implement initState
    getFeed();
    super.initState();



  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Row(
                  //   mainAxisSize: MainAxisSize.max,
                  //   children: [
                  //     Expanded(
                  //         flex: 5,
                  //         child: TextButton(
                  //           child: Text(
                  //             "InZone",
                  //             style: TextStyle(
                  //                 color: Colors.black,
                  //                 fontWeight: FontWeight.bold,
                  //                 fontSize: 25),
                  //           ),
                  //           style: TextButton.styleFrom(
                  //               padding: EdgeInsets.zero,
                  //               minimumSize: Size(50, 30),
                  //               tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  //               alignment: Alignment.centerLeft),
                  //           onPressed: () {
                  //             getFeed();
                  //           },
                  //         )),
                  //     Expanded(
                  //         flex: 2,
                  //         child: Container(
                  //           padding: const EdgeInsets.symmetric(
                  //               horizontal: 25, vertical: 10),
                  //           decoration: BoxDecoration(
                  //             color: const Color(0xffb8dfee).withOpacity(0.8),
                  //             borderRadius: BorderRadius.circular(30),
                  //           ),
                  //           child: const Text(
                  //             "120 Hr",
                  //             style: TextStyle(
                  //                 color: Colors.black,
                  //                 fontWeight: FontWeight.bold),
                  //           ),
                  //         )),
                  //     Expanded(
                  //         flex: 1,
                  //         child: SvgPicture.asset(CustomIcons.notifications))
                  //   ],
                  // ),
                  // const SizedBox(
                  //   height: 10,
                  // ),


                   CategorySelectorBar(categories: categoriesList,onTap: triggerSortingBy,),
                  const SizedBox(
                    height: 20,
                  ),
                  // Container(
                  //   height: 300,
                  //   width: screenWidth,
                  //   child: ListView.builder(
                  //       itemCount: posts.length,
                  //       shrinkWrap: true,
                  //       reverse: true,
                  //       itemBuilder: (context, index) {
                  //         return PostCard(post: posts[index]);
                  //       }),
                  // ),
                  Column(children:posts)
                ]),
          ),
        ),
      ),
    );
  }
}



