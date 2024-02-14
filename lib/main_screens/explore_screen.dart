import 'package:flutter/material.dart';
import 'package:inzone/backend/database.dart';
import 'package:inzone/main_screens/components/inzone_search_bar.dart';
import 'package:inzone/main_screens/components/post_card.dart';
import 'package:inzone/main_screens/settings_screens/components/explore_page_category_selector.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  List<PostCard> posts = [];

  getFeed() async {
    posts.clear();
    await InZoneDatabase.getFeed("aiPosts").then((value) {
      for (var element in value) {
          if (element.description.length > 280) {
            element.description = element.description.substring(0, 279);
          }
          posts.add(PostCard(post: element));
        }
      setState(() {
        posts.reversed;
      });
    });
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
                itemCount: posts.length,
                itemBuilder: (BuildContext context, int index) {
                  return SizedBox(
                    width: MediaQuery.of(context).size.width - 20,
                    height: MediaQuery.of(context).size.height / 2,
                    child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 15.0, horizontal: 20.0),
                        child: posts[index]),
                  );
                },
              ),
            ),
            const ExplorePageCategorySelector(),
            const SizedBox(
              height: 20,
            ),
            Column(
              children: posts,
            ),
          ],
        ),
      ),
    ));
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