import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:inzone/constants.dart';
import 'package:inzone/data/post.dart';
import 'package:inzone/main_screens/comments_screen.dart';
import 'package:inzone/main_screens/custom_icons.dart';
import 'package:random_avatar/random_avatar.dart';
import 'package:sliding_sheet2/sliding_sheet2.dart';

class PostCard extends StatelessWidget {
  InZonePost post;
  PostCard({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Container(
        constraints: BoxConstraints(
          minHeight: post.assetPath == null ? 190 : 350,
        ),
        width: screenWidth! - 30,
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
            color: Color(0xff959595).withOpacity(0.3),
            spreadRadius: 0,
            blurRadius: 15,
            offset: const Offset(0, 4), // changes position of shadow
          ),
        ], color: Colors.white, borderRadius: BorderRadius.circular(15)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Row(
              children: [
                // Image.asset(post.profilePicturePath),
                RandomAvatar(post.userName, height: 40, width: 40),
                const SizedBox(
                  width: 10,
                ),
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(
                    post.userName,
                    style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                  // const Text(
                  //   "1m ago",
                  //   style: TextStyle(color: Colors.grey, fontSize: 15),
                  // ),
                ]),
                const Spacer(),
                PopupMenuButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  padding: EdgeInsets.all(15),
                  child: SvgPicture.asset(
                    CustomIcons.threeDots,
                    height: 40,
                    width: 40,
                  ),
                  onSelected: (value) {
                    // your logic
                  },
                  itemBuilder: (BuildContext bc) {
                    return [
                      menuOption(CustomIcons.save, "Save", "save"),
                      menuOption(CustomIcons.notInterested,
                          "Not Interested in this", "not_interested"),
                      menuOption(
                          CustomIcons.dontShow,
                          "Don't show content of ${post.userName}",
                          "dont_show"),
                      menuOption(
                          CustomIcons.manage, "Manage your interests", "manage")
                    ];
                  },
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              post.description,
              style: TextStyle(height: 1.5),
            ),
            SizedBox(
              height: 10,
            ),
            post.assetPath == null
                ? const SizedBox()
                : Image.asset(post.assetPath!),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SvgPicture.asset(CustomIcons.like),
                const SizedBox(
                  width: 10,
                ),
                GestureDetector(
                    onTap: () {
                      showSlidingBottomSheet(context,
                          builder: (context) => SlidingSheetDialog(
                                cornerRadius: 30,
                                snapSpec: const SnapSpec(snappings: [0.7, 0.9]),
                                builder: (context, state) {
                                  return CommentPage(
                                    post: post,
                                  );
                                },
                              ));
                    },
                    child: SvgPicture.asset(CustomIcons.comment)),
                const SizedBox(
                  width: 10,
                ),
                SvgPicture.asset(CustomIcons.send),
                const Spacer(),
              ],
            )
          ],
        ),
      ),
    );
  }
}

PopupMenuItem menuOption(String iconPath, String title, String value) {
  return PopupMenuItem(
    child: Row(children: [
      SvgPicture.asset(iconPath),
      SizedBox(
        width: 6,
      ),
      Text(title)
    ]),
    value: value,
  );
}
