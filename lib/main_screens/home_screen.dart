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
    await InZoneDatabase.getFeed().then((value) {
      print("GOT VALUE");
      print(value);
      categoriesList.clear();
      for (var element in value) {
        print(element.imageContent);

        posts.add(
          PostCard(
            post: element,
            onTap: (postId) {
            print('You tapped on post with ID: $postId');
            },
          ),
        );
        if (!categoriesList.contains(element.category)){
          categoriesList.add(element.category);
        }

      }

      setState(() {
        // posts.shuffle();
        // posts.reversed;
        print(posts.length);
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
        child: RefreshIndicator(
          onRefresh: () async {
            await getFeed();
            setState(() {

            });

          },
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                     CategorySelectorBar(categories: categoriesList,onTap: triggerSortingBy,),
                    const SizedBox(
                      height: 20,
                    ),
                    Column(children:posts)
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}



