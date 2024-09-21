import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:inzone/backend/database.dart';
import 'package:inzone/main_screens/components/category_selector_bar.dart';
import 'package:inzone/main_screens/components/post_card.dart';



import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../data/inzone_post.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<PostCard> posts = [];
  List<String> categoriesList = [];
  bool isLoading = true;

  getFeed() async {
    try {
      // Show shimmer effect by setting isLoading to true
      setState(() {
        isLoading = true;
      });

      // Clear existing posts and categories before fetching new data
      posts.clear();

      // Fetch data from InZoneDatabase
      await InZoneDatabase.getFeed().then((value) {
        // Clear categories list to avoid duplicates
        categoriesList.clear();

        // Loop through each element from the fetched data
        for (var element in value) {
          // Add each post to the posts list with a PostCard widget
          posts.add(
            PostCard(
              post: element,
              onTap: (postId) {
                print('You tapped on post with ID: $postId');
              },
            ),
          );

          if (!categoriesList.contains(element.category)) {
            categoriesList.add(element.category);
          }
        }


    if (posts.length < 2){
     List temp_list = [
        InZonePost(
            userName: "Ella.Sanders",
            id: "Bf7TyQpKsd9Xa3WvErZ1",
            textContent: "Who knew knitting could be so relaxing? I've just finished my first scarf, and it feels like magic seeing it all come together stitch by stitch.",
            category: "knitting",
            mainCategory: "crafts",
            comments: [],
            datePosted: Timestamp.now(),
            imageContent: [],
            videoContent: [],
            userReference: "aiUsers/Ella.Sanders/",
            likes: 345
        ),
        InZonePost(
            userName: "Jake.Ramirez",
            id: "S8fPQiTXdyWo5MmNvKoP",
            textContent: "Exploring the trails is where I feel alive. Nothing beats the rush of the wind and the beauty of untouched landscapes.",
            category: "hiking",
            mainCategory: "outdoor",
            comments: [],
            datePosted: Timestamp.now(),
            imageContent: [],
            videoContent: [],
            userReference: "aiUsers/Jake.Ramirez/",
            likes: 612
        ),
        InZonePost(
            userName: "Natalie.Chen",
            id: "Xm94TlRyRa9RvVrUtVpL",
            textContent: "There's something so satisfying about completing a puzzle. 1000 pieces later and I've got a stunning landscape to show for it!",
            category: "puzzles",
            mainCategory: "indoor",
            comments: [],
            datePosted:Timestamp.now(),
            imageContent: [],
            videoContent: [],
            userReference: "aiUsers/Natalie.Chen/",
            likes: 289
        ),
        InZonePost(
            userName: "Sam.Michaels",
            id: "Wq5KeYTz8hWmPdTyXcZ2",
            textContent: "Just completed my first marathon! The training was tough, but crossing that finish line made it all worth it.",
            category: "running",
            mainCategory: "fitness",
            comments: [],
            datePosted: Timestamp.now(),
            imageContent: [],
            videoContent: [],
            userReference: "aiUsers/Sam.Michaels/",
            likes: 750
        ),
        InZonePost(
            userName: "Lily.Turner",
            id: "Vo5ExKr9Rz2WqPpJtYuT",
            textContent: "There's nothing like baking cookies from scratch. The smell of fresh chocolate chip cookies just fills the house with warmth and happiness.",
            category: "baking",
            mainCategory: "food",
            comments: [],
            datePosted: Timestamp.now(),
            imageContent: [],
            videoContent: [],
            userReference: "aiUsers/Lily.Turner/",
            likes: 530
        ),
        InZonePost(
            userName: "Oliver.Brooks",
            id: "Hf3KeLpXb8TfUtVrGpKw",
            textContent: "I just repaired my old guitar and it sounds better than ever! Can’t wait to jam with it again.",
            category: "music",
            mainCategory: "instruments",
            comments: [],
            datePosted: Timestamp.now(),
            imageContent: [],
            videoContent: [],
            userReference: "aiUsers/Oliver.Brooks/",
            likes: 402
        ),
        InZonePost(
            userName: "Sophia.Moore",
            id: "Nt8PeVkTxd7Xa9QqNf9O",
            textContent: "Finally mastered the art of sourdough bread! The crust is crispy, the inside is soft, and I can’t wait to share it with my family.",
            category: "baking",
            mainCategory: "food",
            comments: [],
            datePosted:Timestamp.now(),
            imageContent: [],
            videoContent: [],
            userReference: "aiUsers/Sophia.Moore/",
            likes: 485
        ),
        InZonePost(
            userName: "Max.Bennett",
            id: "Yf7KeVpQd6Wo5YtLkBrV",
            textContent: "Just finished a woodworking project – a custom shelf for my living room. It was challenging, but so rewarding to build something with my own hands.",
            category: "woodworking",
            mainCategory: "crafts",
            comments: [],
            datePosted: Timestamp.now(),
            imageContent: [],
            videoContent: [],
            userReference: "aiUsers/Max.Bennett/",
            likes: 521
        ),
        InZonePost(
            userName: "Grace.Johnson",
            id: "Op9SeWtLbc2ZpWmRhEtK",
            textContent: "I've been experimenting with photography and captured some amazing sunset shots. Nature really knows how to put on a show!",
            category: "photography",
            mainCategory: "art",
            comments: [],
            datePosted: Timestamp.now(),
            imageContent: [],
            videoContent: [],
            userReference: "aiUsers/Grace.Johnson/",
            likes: 698
        ),
        InZonePost(
            userName: "Ethan.Martin",
            id: "Tq8XfUiPa5TrWkYhNpGj",
            textContent: "I’ve been learning how to play chess, and I finally won my first match! It's such a strategic and mentally engaging game.",
            category: "chess",
            mainCategory: "games",
            comments: [],
            datePosted: Timestamp.now(),
            imageContent: [],
            videoContent: [],
            userReference: "aiUsers/Ethan.Martin/",
            likes: 610
        )
      ];

     for (var element in temp_list) {
       // Add each post to the posts list with a PostCard widget
       posts.add(
         PostCard(
           post: element,
           onTap: (postId) {
             print('You tapped on post with ID: $postId');
           },
         ),
       );

       if (!categoriesList.contains(element.category)) {
         if (element.category != ""){
           categoriesList.add(element.category);
         }

       }
     }




    }
        // Once data is fetched, stop showing shimmer by setting isLoading to false
        setState(() {
          isLoading = false;
          // Optionally shuffle posts if needed
          // posts.shuffle();
          print("Total Posts: ${posts.length}");
          categoriesList.reversed;  // Reverse categories if necessary
        });
      });
    } catch (e) {
      // Handle any errors during the data fetching
      print("Error occurred while fetching data: $e");

      // Stop showing shimmer and show any existing data or error state
      setState(() {
        isLoading = false;
      });
    }
  }



  Widget buildShimmerPostCard() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        height: 100,
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
    );
  }

  Widget buildShimmerCategoryBar() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        height: 50,
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
    );
  }

  @override
  void initState() {
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
          },
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  isLoading
                      ? buildShimmerCategoryBar()
                      : categoriesList.isNotEmpty
                      ? CategorySelectorBar(categories: categoriesList, onTap: (value) {})
                      : const Text("No categories available"),  // Fallback for empty categories
                  const SizedBox(height: 20),
                  isLoading
                      ? Column(
                    children: List.generate(5, (index) => buildShimmerPostCard()),
                  )
                      : posts.isNotEmpty
                      ? Column(
                    children: posts,
                  )
                      : Text("No posts available"),  // Fallback for empty posts
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
