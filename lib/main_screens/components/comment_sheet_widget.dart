import 'package:flutter/material.dart';

import 'comment_model.dart';
import 'comment_widgets.dart';

//comment sheet widget...
class CommentSheetWidget extends StatefulWidget {
  const CommentSheetWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<CommentSheetWidget> createState() => _CommentSheetWidgetState();
}

class _CommentSheetWidgetState extends State<CommentSheetWidget> {
  List<CommentModel> commentModelList = myAllCommentData();
  List<CommentModel> commentModelDetailList = myAllCommentDetailData();
  TextEditingController mySearchController = TextEditingController();
  bool isCommentDetailOpen = false;
  String replyTo = '';

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Container(
      width: double.infinity,
      height: height / 1.2,
      // margin: const EdgeInsets.only(top: 100),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(50),
          topRight: Radius.circular(50),
          bottomLeft: Radius.circular(0),
          bottomRight: Radius.circular(0),
        ),
      ),
      child: isCommentDetailOpen == false
          ? Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Container(
                      height: 5,
                      width: 50,
                      margin: const EdgeInsets.only(top: 6, bottom: 16),
                      decoration: BoxDecoration(
                        color: const Color(0xFFD9D9D9),
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                    const Text(
                      "Comment",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Container(
                      height: 0.5,
                      width: double.infinity,
                      margin: const EdgeInsets.only(top: 12),
                      color: const Color(0xFFD9D9D9),
                    ),
                  ],
                ),
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 100),
                    itemCount: commentModelList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return CommentListItemsWidget(
                        image: commentModelList[index].image,
                        name: commentModelList[index].name,
                        reply: commentModelList[index].reply,
                        like: commentModelList[index].like,
                        time: commentModelList[index].time,
                        isShowReply: commentModelList[index].isShowReply,
                        comment: commentModelList[index].comment,
                        onCommentPressed: () {
                          setState(() {
                            isCommentDetailOpen = true;
                            replyTo = commentModelList[index].name;
                          });
                        },
                      );
                    },
                  ),
                )
              ],
            )
          : Stack(
              alignment: Alignment.bottomCenter,
              children: <Widget>[
                Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Container(
                          height: 5,
                          width: 50,
                          margin: const EdgeInsets.only(top: 6, bottom: 16),
                          decoration: BoxDecoration(
                            color: const Color(0xFFD9D9D9),
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                        Stack(
                          alignment: Alignment.center,
                          children: <Widget>[
                            Align(
                              alignment: Alignment.topRight,
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(7, 0, 16, 0),
                                child: InkWell(
                                  onTap: () {
                                    setState(() {
                                      isCommentDetailOpen = false;
                                    });
                                  },
                                  child: const Icon(
                                    Icons.close,
                                    color: Colors.black,
                                    size: 25,
                                  ),
                                ),
                              ),
                            ),
                            const Text(
                              "Comment",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        Container(
                          height: 0.5,
                          width: double.infinity,
                          margin: const EdgeInsets.only(top: 12),
                          color: const Color(0xFFD9D9D9),
                        ),
                      ],
                    ),
                    Expanded(
                      child: ListView.builder(
                        padding: const EdgeInsets.fromLTRB(16, 16, 16, 120),
                        itemCount: commentModelDetailList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return CommentListItemsWidget(
                            image: commentModelDetailList[index].image,
                            name: commentModelDetailList[index].name,
                            reply: commentModelDetailList[index].reply,
                            like: commentModelDetailList[index].like,
                            time: commentModelDetailList[index].time,
                            isShowReply:
                                commentModelDetailList[index].isShowReply,
                            comment: commentModelDetailList[index].comment,
                            onCommentPressed: () {},
                          );
                        },
                      ),
                    ),
                  ],
                ),
                Container(
                  height: 50,
                  width: double.infinity,
                  margin: const EdgeInsets.fromLTRB(16, 0, 16, 60),
                  child: TextField(
                    controller: mySearchController,
                    maxLines: 1,
                    style: const TextStyle(
                      color: Color(0xFF717D96),
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                    textInputAction: TextInputAction.done,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      prefixIcon: Container(
                        height: 30,
                        width: 30,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: AssetImage("assets/images/person1.jpg"),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      prefixIconConstraints: const BoxConstraints(
                        minHeight: 10,
                        minWidth: 55,
                      ),
                      hintText: "Reply to $replyTo",
                      hintStyle: const TextStyle(
                        color: Color(0xFFA0ABC0),
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide: const BorderSide(
                          color: Color(0xFFA0ABC0),
                          width: 1,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide: const BorderSide(
                          color: Color(0xFFA0ABC0),
                          width: 1,
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide: const BorderSide(
                          color: Color(0xFFA0ABC0),
                          width: 1,
                        ),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide: const BorderSide(
                          color: Color(0xFFA0ABC0),
                          width: 1,
                        ),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        // horizontal: 12,
                        vertical: 13.5,
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
