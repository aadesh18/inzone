import 'package:flutter/material.dart';
import 'package:inzone/constants.dart';
import 'package:slide_to_act/slide_to_act.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: backgroundColor,
        leading: IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.highlight_remove_outlined,
              color: Colors.grey,
            )),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                maxLines: null, // Set maxLines to null for multiline
                decoration: const InputDecoration(
                  labelText: 'What do you want yo talk about?',
                  labelStyle: TextStyle(color: Colors.grey),
                  border: InputBorder.none, // Remove the border
                  contentPadding:
                      EdgeInsets.only(bottom: 8.0), // Adjust padding as needed
                ),
                onEditingComplete: () {
                  setState(() {
                    isTyping = false;
                  });
                },
                onSubmitted: (t) {
                  setState(() {
                    isTyping = false;
                  });
                },
                onTapOutside: (t) {
                  setState(() {
                    isTyping = false;
                  });
                },
                onTap: () {
                  setState(() {
                    isTyping = true;
                  });
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Image.asset("icons/post_icons/img0.png"),
                  const SizedBox(
                    width: 5,
                  ),
                  Image.asset("icons/post_icons/img1.png"),
                ],
              ),
              isTyping
                  ? Container()
                  : SizedBox(
                      height: MediaQuery.of(context).size.height / 2.5,
                    ),
              const SizedBox(
                height: 10,
              ),
              Container(
                margin: const EdgeInsets.only(top: 0),
                padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topLeft:
                        Radius.circular(40.0), // Adjust the radius as needed
                    topRight: Radius.circular(40.0),
                  ),
                  color: isTyping ? Colors.white : backgroundColor,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    isTyping
                        ? Container()
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Image.asset("icons/post_icons/0.png"),
                              Image.asset("icons/post_icons/1.png"),
                              Image.asset("icons/post_icons/2.png"),
                            ],
                          ),
                    !isTyping
                        ? Container()
                        : const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Suggestions based on your InZone post"),
                            ],
                          ),
                    !isTyping
                        ? Container()
                        : Container(
                            width: 80,
                            padding: const EdgeInsets.all(5),
                            margin: const EdgeInsets.only(top: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: backgroundColor,
                              boxShadow: [
                                const BoxShadow(
                                  color: Colors.blue,
                                  spreadRadius: 1,
                                  blurRadius: 1,
                                  offset: Offset(0,
                                      2), // Changes the position of the shadow
                                ),
                              ],
                            ),
                            child: const Center(child: Text("sport")),
                          ),
                    SlideAction(
                      sliderButtonIconPadding: 12,
                      sliderRotate: false,
                      outerColor: Colors.blue,
                      text: "Drag to post",
                      height: 50,
                      elevation: 0,
                      onSubmit: () {
                        setState(() {
                          submitted = true;
                        });
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool submitted = false;
  bool isTyping = false;
}
