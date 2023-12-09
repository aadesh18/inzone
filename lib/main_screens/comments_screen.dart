import 'package:flutter/material.dart';
import 'package:inzone/data/post.dart';
import 'package:inzone/main_screens/components/post_card.dart';

class CommentPage extends StatefulWidget {
  CommentPage({Key? key, required this.post});
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
              Row(
                children: [
                  Image.asset("images/sample_avatar_1.png"),
                  const SizedBox(
                    width: 10,
                  ),
                  const Text(
                    "Robert Fox",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "If you think you are too small to make a difference, try sleeping with a mosquito",
                style: TextStyle(
                    fontWeight: FontWeight.normal, color: Colors.black54),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Image.asset("images/sample_avatar_1.png"),
                  const SizedBox(
                    width: 10,
                  ),
                  const Text(
                    "Mira Culhane",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "If you think you are too small to make a difference, try sleeping with a mosquito",
                style: TextStyle(
                    fontWeight: FontWeight.normal, color: Colors.black54),
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
