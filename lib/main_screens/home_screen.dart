import 'package:flutter/material.dart';
import 'package:inzone/backend/database.dart';
import 'package:inzone/data/post.dart';
import 'package:inzone/main_screens/components/category_selector_bar.dart';
import 'package:inzone/main_screens/components/post_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<PostCard> posts = [];

  getFeed() async {
    posts.clear();
    await InZoneDatabase.getFeed("aiPosts").then((value) {
      for (var element in value) {
          posts.add(PostCard(post: element));
        }
      setState(() {
        posts.reversed;
        posts.insert(0,
            PostCard(post: InZonePost(userName: 'Aadesh', description: "This is the description", firstName: "Aadesh", lastName: "Kheria", profilePicturePath: "", assetPath: "https://oaidalleapiprodscus.blob.core.windows.net/private/org-L8uhbbIqhLcpNhQ4vJz5ttcZ/user-FOFdXqaSxmHDK27p1kzl8H4Y/img-soxVKmpSQsGIRccnN2Otc6BA.png?st=2024-02-14T23%3A22%3A27Z&se=2024-02-15T01%3A22%3A27Z&sp=r&sv=2021-08-06&sr=b&rscd=inline&rsct=image/png&skoid=6aaadede-4fb3-4698-a8f6-684d7786b067&sktid=a48cca56-e6da-484e-a814-9c849652bcb3&skt=2024-02-14T23%3A36%3A16Z&ske=2024-02-15T23%3A36%3A16Z&sks=b&skv=2021-08-06&sig=laLHIhamIfJFjl5XXiUdetgCClEd%2BMe8LEonqoV3kwk%3D"))
        );
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
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
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
              
          
                const CategorySelectorBar(),
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
                Column(children: posts)
              ]),
        ),
      ),
    );
  }
}
