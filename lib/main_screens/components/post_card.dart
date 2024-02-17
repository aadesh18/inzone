import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:inzone/constants.dart';
import 'package:inzone/data/inzone_post.dart';
import 'package:inzone/main_screens/comments_screen.dart';
import 'package:inzone/custom_icons.dart';
import 'package:random_avatar/random_avatar.dart';
import 'package:sliding_sheet2/sliding_sheet2.dart';
import 'package:http/http.dart' as http;

class PostCard extends StatefulWidget {
  InZonePost post;
  PostCard({super.key, required this.post});

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  bool imageSuccess = false;

  void checkInternet() async {
    if (widget.post.imageContent! !=null ){
      print("eneeted");
      try {
        final response = await http.head(Uri.parse(widget.post.imageContent!.elementAt(0))).then((value) {
          if (value.statusCode == 200){
            imageSuccess = true;
          }
        });

      } catch (_) {
        imageSuccess = false;
      }
    } else {

        imageSuccess = false;

    }

  }

  @override
  void initState() {
    // TODO: implement initState
    //checkInternet();
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Container(
        constraints: BoxConstraints(
          minHeight: imageSuccess ? 350 : 190,
        ),
        width: screenWidth! - 30,
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
            color: const Color(0xff959595).withOpacity(0.3),
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
                RandomAvatar(widget.post.userName, height: 40, width: 40),
                const SizedBox(
                  width: 10,
                ),
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(
                    widget.post.userName,
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
                  padding: const EdgeInsets.all(15),
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
                          "Don't show content of ${widget.post.userName}",
                          "dont_show"),
                      menuOption(
                          CustomIcons.manage, "Manage your interests", "manage")
                    ];
                  },
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            widget.post.textContent == null ? SizedBox() :
            Text(
              widget.post.textContent!,
              style: const TextStyle(height: 1.5),
            ),
            const SizedBox(
              height: 10,
            ),

widget.post.imageContent == null  ? SizedBox() :

widget.post.imageContent!.length == 0 ? SizedBox(): Container(
width: screenWidth!-30,
  height: 200,
  child: ClipRRect(

    borderRadius: BorderRadius.circular(8.0),
    child: Image.network(widget.post.imageContent!.elementAt(0),

      fit: BoxFit.fitWidth,
      errorBuilder: (context, object, st){

      setState(() {
        imageSuccess = false;
      });
      print("Error");

      return const SizedBox();
    },),
  ),
),
//       widget.post.imageContent == null ?  SizedBox()  :
//
//               imageSuccess ? Container(
// height:  100,
//                  width:  200,
//
//                  child: ListView.builder(
//                   scrollDirection: Axis.horizontal, itemCount: widget.post.imageContent == null ?  0 : widget.post.imageContent!.length , itemBuilder: (context, index) {
//
//                   return
//                   ClipRRect(
//                     borderRadius: BorderRadius.circular(8.0),
//                     child: Image.network(widget.post.imageContent!.elementAt(index),errorBuilder: (context, object, st){
//                       setState(() {
//                         imageSuccess = false;
//                       });
//
//                       return const SizedBox();
//                     }),
//                   );
//                                },),
//                ) : SizedBox(),
//

            const SizedBox(
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
                                    post: widget.post,
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
    value: value,
    child: Row(children: [
      SvgPicture.asset(iconPath),
      const SizedBox(
        width: 6,
      ),
      Text(title)
    ]),
  );
}
