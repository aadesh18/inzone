import 'package:flutter/material.dart';
import 'package:inzone/data/inzone_post.dart';
import 'package:inzone/main_screens/components/post_card.dart';
import 'package:lottie/lottie.dart';

class CommentPage extends StatefulWidget {
  CommentPage({super.key, required this.post});
  InZonePost post;

  @override
  State<CommentPage> createState() => _CommentPageState();
}

class _CommentPageState extends State<CommentPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20))),
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              PostCard(post: widget.post),
              const Divider(),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: Column(
                    children: [
                      SizedBox(
                        height: 300,
                        width: 300,
                        child: LottieBuilder.asset('assets/waiting.json'),

                      ),
                      SizedBox(height: 30,),
                      Text(
                        "You have been signed up for the waitlist for the full version.\n\nSit back and relax ;)", style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w500),),

                    ],
                    ),
                  )



            ],
          ),
        ),
      ),
      // child: Stack(
      //   children: [

      //     // Align(
      //     //   alignment: Alignment.bottomCenter,
      //     //   child: TextField(
      //     //     textAlign: TextAlign.start,
      //     //     decoration: InputDecoration(
      //     //         fillColor: Colors.white,
      //     //         filled: true,
      //     //         hintText: "Post a comment",
      //     //         hintStyle: TextStyle(fontSize: 13),
      //     //         suffixIcon: Icon(Icons.send)),
      //     //   ),
      //     // ),
      //   ],
    );
  }
}
