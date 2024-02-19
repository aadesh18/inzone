import 'package:flutter/material.dart';
import 'package:inzone/data/string_extension.dart';
import 'package:inzone/backend/database.dart';
import 'package:inzone/constants.dart';
import 'package:inzone/data/inzone_category.dart';
import 'package:inzone/main_screens/components/inzone_search_bar.dart';
import 'package:inzone/main_screens/components/post_card.dart';
import 'package:inzone/main_screens/settings_screens/components/explore_page_category_selector.dart';
import 'package:intl/intl.dart';
class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  List<PostCard> explorePostsWithoutImages = [];
  List<PostCard> explorePostsWithImages = [];
  List<String> categoriesList = [];
  getFeed() async {
    explorePostsWithImages.clear()   ;
    explorePostsWithoutImages.clear();
    categoriesList.clear();
    await InZoneDatabase.getExploreFeed("aiPosts").then((value) {
      for (var element in value) {
        if (element.textContent != null){
          if (element.textContent!.length > 280) {
            element.textContent = element.textContent!.substring(0, 279);
          }
          if (element.imageContent != null){
            if (element.imageContent!.length > 0){
              print("ADDED IMAGE");
              explorePostsWithImages.add(PostCard(post: element));
            } else {
              print("ADDED NO IMAGE");
              element.imageContent = null;
              explorePostsWithoutImages.add(PostCard(post: element));
            }

          } else {
            print("ADDED NO IMAGE");
            element.imageContent = null;
            explorePostsWithoutImages.add(PostCard(post: element));
          }


        }

        categoriesList.add(
            element.category
        );
        setState(() {
          explorePostsWithImages.reversed;
          explorePostsWithoutImages.reversed;
          categoriesList.reversed;
        });

        }

    });
  }

  String replaceAndCapitalize(String text) {
    // Split the text into words based on underscores.
    if (text.contains("_")){
      List<String> words = text.split('_');

      // Capitalize the first letter of each word.
      words = words
          .map((word) => word.replaceFirst(word[0], word[0].toUpperCase()))
          .toList();

      // Join the words back together with spaces.
      return words.join(' ');
    }



    return text.capitalize();


  }

  @override
  void initState() {
    // TODO: implement initState
    getFeed();
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: PreferredSize(
        preferredSize:
        const Size.fromHeight(50),
        child: AppBar(
          elevation: 0,
          automaticallyImplyLeading: false,
          backgroundColor: backgroundColor,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_new, size: 20,),

            color: Colors.black,
            onPressed: (){
              Navigator.pop(context);
            },
          ),
          title: Text("Explore",
              style: const TextStyle(
                  fontSize: 26, fontWeight: FontWeight.w700)),

        ),
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const InZoneSearchBar(),
              // const Padding(
              //   padding: EdgeInsets.all(10),
              //   child: Text(
              //     "Saved Posts",
              //     textAlign: TextAlign.left,
              //     style: TextStyle(
              //         color: Colors.black,
              //         fontWeight: FontWeight.bold,
              //         fontSize: 20),
              //   ),
              // ),

              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 2.25,
                // width: MediaQuery.of(context).size.width - 40,
                // height: MediaQuery.of(context).size.height / 2,
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: explorePostsWithoutImages.length,
                  itemBuilder: (BuildContext context, int index) {
                    return SizedBox(
                      width: MediaQuery.of(context).size.width - 20,
                      height: MediaQuery.of(context).size.height / 2,
                      child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 15.0, horizontal: 20.0),
                          child: explorePostsWithoutImages[index]),
                    );
                  },
                ),
              ),
           ExplorePageCategorySelector(categoryList: categoriesList,),
              const SizedBox(
                height: 20,
              ),
              Column(
                children: explorePostsWithImages,
              ),
            ],
          ),
        ),
      )),
    );
  }
}
            // PostCard(
            //     post: InZonePost(
            //         userName: "David Morel",
            //         profilePicturePath: "images/sample_avatar_2.png",
            //         description:
            //             "If you think you are too small to make a difference, try sleeping with a mosquito. - Dalai Lama")),
            // PostCard(
            //     post: InZonePost(
            //         userName: "Marianne Onile",
            //         profilePicturePath: "images/sample_avatar_1.png",
            //         description:
            //             "If you think you are too small to make a difference, try sleeping with a mosquito. - Dalai Lama")),
            // PostCard(
            //     post: InZonePost(
            //         userName: "David Morel",
            //         profilePicturePath: "images/sample_avatar_2.png",
            //         description:
            //             "If you think you are too small to make a difference, try sleeping with a mosquito. - Dalai Lama",
            //         assetPath: "images/sample_picture_2.png")),
            // PostCard(
            //     post: InZonePost(
            //         userName: "Aadesh",
            //         profilePicturePath: "images/sample_avatar_1.png",
            //         description:
            //             "If you think you are too small to make a difference, try sleeping with a mosquito. - Dalai Lama")),
            // PostCard(
            //     post: InZonePost(
            //         userName: "Jayme",
            //         profilePicturePath: "images/sample_avatar_2.png",
            //         description:
            //             "If you think you are too small to make a difference, try sleeping with a mosquito. - Dalai Lama",
            //         assetPath: "images/sample_picture_1.png")),