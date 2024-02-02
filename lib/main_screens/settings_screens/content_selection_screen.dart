import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter/material.dart';
import 'package:inzone/constants.dart';

class ContentSelectionScreen extends StatefulWidget {
  const ContentSelectionScreen({super.key});

  @override
  State<ContentSelectionScreen> createState() => _ContentSelectionScreenState();
}

class _ContentSelectionScreenState extends State<ContentSelectionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
                width: 358,
                height: 80,
                child: Text(
                    "Swipe Low visibility and High visibility content in each mode of your choice.",
                    textAlign: TextAlign.center,
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.w500))),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topLeft:
                        Radius.circular(40.0), // Adjust the radius as needed
                    topRight: Radius.circular(40.0),
                  ),
                  color: Colors.white,
                ),
                child: Column(
                  children: [
                    Container(
                        margin: const EdgeInsets.only(top: 30, bottom: 25),
                        child: const Text(
                          "Fall Back",
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.w800),
                        )),
                    Expanded(
                      child: ListView.builder(
                        itemCount: contentList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Slidable(
                            key: Key('$index'),
                            child: SizedBox(
                              height:
                                  index != contentList.length - 1 ? 60 : 100,
                              child: Stack(
                                children: [
                                  Expanded(
                                    child: Container(
                                      margin: const EdgeInsets.only(
                                          left: 10,
                                          right: 10,
                                          bottom: 5,
                                          top: 5),
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        color: Colors.white,
                                        // border: Border(
                                        //     top: BorderSide(
                                        //         color: backgroundColor)
                                        //         ),
                                        boxShadow: [
                                          BoxShadow(
                                            color: backgroundColor
                                                .withOpacity(0.5),
                                            spreadRadius: 3,
                                            blurRadius: 1,
                                            offset: const Offset(0,
                                                3), // Changes the position of the shadow
                                          ),
                                        ],
                                      ),
                                      child: ListTile(
                                        title: Text(contentList[index].tittle,
                                            style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w700)),
                                        leading: Image.asset(
                                            "${contentList[index].iconPath}/$index.png"),
                                      ),
                                    ),
                                  ),
                                  index != contentList.length - 1
                                      ? Container()
                                      : GestureDetector(
                                          onTap: () {
                                            // Navigator.push(context, MaterialPageRoute(builder: (context)=>const UserDetail()));
                                          },
                                          child: Align(
                                              alignment: Alignment.bottomCenter,
                                              child: Image.asset(
                                                  "icons/content_icons/next.png")),
                                        ),
                                ],
                              ),
                            ),

                            startActionPane: ActionPane(
                              // A motion is a widget used to control how the pane animates.
                              extentRatio: 0.2,
                              motion: const ScrollMotion(),

                              children: [
                                // A SlidableAction can have an icon and/or a label.
                                Image.asset("icons/content_icons/low.png")
                              ],
                            ),

                            // The end action pane is the one at the right or the bottom side.
                            endActionPane: ActionPane(
                              extentRatio: 0.2,
                              motion: ScrollMotion(),
                              children: [
                                Image.asset("icons/content_icons/high.png"),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ContentModel {
  final String tittle;
  final String iconPath;

  ContentModel({required this.tittle, required this.iconPath});
}

List<ContentModel> contentList = [
  ContentModel(tittle: 'Sports', iconPath: 'icons/content_icons'),
  ContentModel(tittle: 'Gaming', iconPath: 'icons/content_icons'),
  ContentModel(
      tittle: 'Pop Culture & Entertainment', iconPath: 'icons/content_icons'),
  ContentModel(tittle: 'Humor & Memes', iconPath: 'icons/content_icons'),
  ContentModel(tittle: 'Music & Art', iconPath: 'icons/content_icons'),
  ContentModel(tittle: 'Fashion & Style', iconPath: 'icons/content_icons'),
  ContentModel(tittle: 'DIY & Crafts', iconPath: 'icons/content_icons'),
  ContentModel(tittle: 'Food', iconPath: 'icons/content_icons'),
];
