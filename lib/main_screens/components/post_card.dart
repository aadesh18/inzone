import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:inzone/constants.dart';
import 'package:inzone/data/inzone_post.dart';
import 'package:inzone/main_screens/comment_screen/comment_screen.dart';
import 'package:inzone/main_screens/comment_screen/reply_class.dart';
import 'package:inzone/main_screens/comments_screen.dart';
import 'package:inzone/custom_icons.dart';
import 'package:random_avatar/random_avatar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sliding_sheet2/sliding_sheet2.dart';
import 'package:http/http.dart' as http;

import '../../backend/collection_names.dart';
import '../../backend/database.dart';
import '../../data/inzone_current_user.dart';
import '../../data/inzone_user.dart';
import '../comment_screen/comment_class.dart';

class PostCard extends StatefulWidget {
  InZonePost post;
  final Function(String)? onTap;

  PostCard({super.key, required this.post, this.onTap});

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  bool imageSuccess = false;

  bool isLiked = false;
  bool isUnLike = false;

  void checkInternet() async {
    if (widget.post.imageContent! != null) {
      print("eneeted");
      try {
        final response = await http
            .head(Uri.parse(widget.post.imageContent!.elementAt(0)))
            .then((value) {
          if (value.statusCode == 200) {
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

  String username = '';

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String?> getUsername() async {
    DocumentSnapshot snapshot = await FirebaseFirestore.instance
        .collection('newUser')
        .doc(_auth.currentUser!.uid)
        .get();

    if (snapshot.exists) {
      Map<String, dynamic> userData = snapshot.data() as Map<String, dynamic>;
      setState(() {
        username = userData['name'];
      });
      print("User name $username");
      return username;
    }
    return null;
  }

  @override
  void initState() {
    // TODO: implement initState
    //checkInternet();
    super.initState();
    getUsername();
    retrieveLikedComments();
    retrieveUnLikedComments();
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
                      menuOption(CustomIcons.notInterested, "Flag this post",
                          "not_interested"),
                      menuOption(
                          CustomIcons.dontShow,
                          "Block this user ${widget.post.userName}",
                          "dont_show"),
                      menuOption(
                          CustomIcons.manage, "Report this post", "manage")
                    ];
                  },
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            widget.post.textContent == null
                ? SizedBox()
                : Text(
                    widget.post.textContent!,
                    style: const TextStyle(height: 1.5),
                  ),
            const SizedBox(
              height: 10,
            ),

            widget.post.imageContent == null
                ? SizedBox()
                : widget.post.imageContent!.length == 0
                    ? SizedBox()
                    : Container(
                        width: screenWidth! - 30,
                        height: 200,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.network(
                            widget.post.imageContent!.elementAt(0),
                            fit: BoxFit.fitWidth,
                            errorBuilder: (context, object, st) {
                              setState(() {
                                imageSuccess = false;
                              });
                              print("Error");

                              return const SizedBox();
                            },
                          ),
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
                isLiked
                    ? GestureDetector(
                        onTap: () {
                          setState(() {
                            isLiked = false;
                          });
                        },
                        child: SvgPicture.asset(CustomIcons.like))
                    : GestureDetector(
                        onTap: () {
                          setState(() {
                            isLiked = true;
                          });
                        },
                        child: SvgPicture.asset(CustomIcons.notlike),
                      ),
                const SizedBox(
                  width: 10,
                ),
                InkWell(
                    onTap: () {
                      print('my fetch post doc id is ${widget.post.id}');
                      filterSheetModel();
                      // Navigator.push(context, MaterialPageRoute(builder: (context)=>CommentPage(
                      //   post: widget.post,
                      // )));
                    },
                    child: SvgPicture.asset(CustomIcons.comment)),
                const SizedBox(
                  width: 10,
                ),
                GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return CommentScreen();
                      }));
                      // showSlidingBottomSheet(context,
                      //     builder: (context) => SlidingSheetDialog(
                      //       cornerRadius: 30,
                      //       snapSpec: const SnapSpec(snappings: [0.7, 0.9]),
                      //       builder: (context, state) {
                      //
                      //         // return CommentPage(
                      //         //   post: widget.post,
                      //         // );
                      //       },
                      //     ));
                    },
                    child: SvgPicture.asset(CustomIcons.send)),
                const Spacer(),
              ],
            )
          ],
        ),
      ),
    );
  }

  TextEditingController _replyController = TextEditingController();
  TextEditingController mySearchController = TextEditingController();
  ScrollController _scrollController = ScrollController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String type = '';

  String? selectedCommentId;

  Widget chatInput(String? commentId, String? name) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
      child: Row(
        children: [
          Expanded(
            child: Scrollbar(
              controller: _scrollController,
              child: Container(
                constraints: const BoxConstraints(maxHeight: 100),
                child: TextFormField(
                  scrollController: _scrollController,
                  cursorColor: Colors.black,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontFamily: 'Maneola',
                    fontWeight: FontWeight.w500,
                  ),
                  controller:
                      type == 'Reply' ? _replyController : mySearchController,
                  onTap: () {},
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                  // cursorHeight: 17,
                  decoration: InputDecoration(
                    suffixIconColor: Colors.grey.withOpacity(0.4),
                    contentPadding:
                        const EdgeInsets.only(top: 10, left: 16, right: 16),
                    border: InputBorder.none,
                    hintText: type == 'Reply' ? 'Add Reply' : 'Add Comment',
                    hintStyle: const TextStyle(
                      fontSize: 14,
                      fontFamily: 'Maneola',
                      fontWeight: FontWeight.w400,
                      color: Colors.black26,
                    ),
                    filled: true,
                    fillColor: Colors.grey.withOpacity(0.1),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(
                        color: Colors.black38,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          MaterialButton(
            minWidth: 43,
            height: 43,
            color: Colors.blue,
            shape: const CircleBorder(),
            onPressed: () {
              if (type == 'Reply') {
                // Check if a comment is selected
                if (selectedCommentId != null) {
                  _addReply(
                      selectedCommentId!); // Pass stored commentId to _addReply function
                  _replyController.clear();
                  setState(() {
                    type = '';
                    selectedCommentId =
                        null; // Clear selected comment ID after replying
                  });
                }
              } else {
                _addComment();
              }
            },
            child: const Center(
              child: Icon(
                Icons.send,
                color: Colors.white,
                size: 18,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _addComment() async {
    String commentText = mySearchController.text.trim();
    if (commentText.isNotEmpty) {
      // Add comment to Firestore
      DocumentReference documentReference =
          await _firestore.collection('comments').add({
        'author': username, // Replace with actual user name
        'text': commentText,
        'userId': FirebaseAuth.instance.currentUser!.uid,
        'timestamp': DateTime.now().toString(),
        'postId': widget.post.id.toString(),
        'likedBy': [], // Initialize likedBy as an empty list
      });
      String commentId =
          documentReference.id; // Get the ID of the newly added comment
      setState(() {
        mySearchController.clear();
      });
    }
  }

  Widget _buildReplyList(String commentId) {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore
          .collection('comments')
          .doc(commentId)
          .collection('replies')
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final replies = snapshot.data!.docs.map((doc) {
            final data = doc.data() as Map<String, dynamic>;
            return Reply(
              author: data['author'],
              text: data['text'],
              timestamp: data['timestamp'],
            );
          }).toList();

          return Column(
            children: replies
                .map((reply) => ListTile(
                      leading: RandomAvatar(widget.post.userName,
                          height: 30, width: 30),

                      // leading: CircleAvatar(
                      //           backgroundImage:
                      //               AssetImage('images/sample_avatar_2.png'),
                      //         ),
                      title: Text(
                        reply.author,
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.grey,
                            fontSize: 12),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            reply.text,
                            style: TextStyle(fontSize: 12),
                          ),
                          SizedBox(
                            height: 7,
                          ),
                          Text(
                            comment!.timestamp.substring(0, 11),
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 9,
                            ),
                          ),
                        ],
                      ),
                    ))
                .toList(),
          );
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }

        return Center(child: CircularProgressIndicator());
      },
    );
  }

  void _addReply(String commentId) async {
    String replyText = _replyController.text.trim();
    if (replyText.isNotEmpty) {
      await _firestore
          .collection('comments')
          .doc(commentId)
          .collection('replies')
          .add({
        'author': username,
        // Replace with actual user name
        'text': replyText,
        'commentId': commentId,
        'timestamp': DateTime.now().toString(),
      });
      _replyController.clear();
    }
  }

  Comment? comment;
// Function to toggle like status and store it in SharedPreferences
  toggleLikeComment(String commentId) async {
    Comment comment = await getComment(commentId);
    String currentUserId = FirebaseAuth.instance.currentUser!.uid;

    // Check if the current user has already liked or disliked the comment
    bool isLiked = comment.likedBy!.contains(currentUserId);
    bool isDisliked = comment.dislikedBy!.contains(currentUserId);

    // Remove from dislikedBy if the comment was previously disliked
    if (isDisliked) {
      comment.dislikedBy!.remove(currentUserId);
    }

    // Toggle like status
    if (isLiked) {
      // Remove from likedBy if the comment was previously liked
      comment.likedBy!.remove(currentUserId);
    } else {
      // Add to likedBy if the comment was not previously liked
      comment.likedBy!.add(currentUserId);
      // Make sure to remove from dislikedBy if the comment was previously disliked
      comment.dislikedBy!.remove(currentUserId);
    }

    // Update the likedBy and dislikedBy fields in Firestore
    await _firestore
        .collection('comments')
        .doc(commentId)
        .update({'likedBy': comment.likedBy, 'dislikedBy': comment.dislikedBy});

    // Store the updated like status in SharedPreferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(commentId, !isLiked);

    // If the comment was disliked, update the disliked status as well
    if (isDisliked) {
      setState(() {
        dislikedComments[commentId] = false;
      });
      await prefs.setBool(commentId, false);
    }

    // Return the updated like status
    return !isLiked;
  }

// Function to toggle dislike status and store it in SharedPreferences
  toggleUnLikeComment(String commentId) async {
    Comment comment = await getComment(commentId);
    String currentUserId = FirebaseAuth.instance.currentUser!.uid;

    // Check if the current user has already liked or disliked the comment
    bool isDisliked = comment.dislikedBy!.contains(currentUserId);
    bool isLiked = comment.likedBy!.contains(currentUserId);

    // Remove from likedBy if the comment was previously liked
    if (isLiked) {
      comment.likedBy!.remove(currentUserId);
    }

    // Toggle dislike status
    if (isDisliked) {
      // Remove from dislikedBy if the comment was previously disliked
      comment.dislikedBy!.remove(currentUserId);
    } else {
      // Add to dislikedBy if the comment was not previously disliked
      comment.dislikedBy!.add(currentUserId);
      // Make sure to remove from likedBy if the comment was previously liked
      comment.likedBy!.remove(currentUserId);
    }

    // Update the likedBy and dislikedBy fields in Firestore
    await _firestore
        .collection('comments')
        .doc(commentId)
        .update({'likedBy': comment.likedBy, 'dislikedBy': comment.dislikedBy});

    // Store the updated dislike status in SharedPreferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(commentId, !isDisliked);

    // If the comment was liked, update the liked status as well
    if (isLiked) {
      setState(() {
        likedComments[commentId] = false;
      });
      await prefs.setBool(commentId, false);
    }

    // Return the updated dislike status
    return !isDisliked;
  }

// Inside the retrieveLikedComments method
  Future<void> retrieveLikedComments() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    likedComments.clear(); // Clear the existing map
    for (String commentId in prefs.getKeys()) {
      if (prefs.getBool(commentId)!) {
        likedComments[commentId] = true;
      }
    }
  }



// Inside the retrieveUnLikedComments method
  Future<void> retrieveUnLikedComments() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    dislikedComments.clear(); // Clear the existing map
    for (String commentId in prefs.getKeys()) {
      if (!prefs.getBool(commentId)!) {
        dislikedComments[commentId] = true;
      }
    }
  }



  Future<Comment> getComment(String commentId) async {
    DocumentSnapshot snapshot =
        await _firestore.collection('comments').doc(commentId).get();
    return Comment.fromJson(snapshot.data() as Map<String, dynamic>);
  }

  Map<String, bool> likedComments = {};
  Map<String, bool> dislikedComments = {};
  bool showReplies = false; // Flag to track whether to show replies or not

  filterSheetModel() {
    setState(() {
      _replyController.clear();
      selectedCommentId = null;
      type = '';
    });

    showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          var width = MediaQuery.of(context).size.width;
          return Padding(
            padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.8,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(30),
                  topLeft: Radius.circular(30),
                ),
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Comments',
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Expanded(
                    child: StreamBuilder<QuerySnapshot>(
                      stream: _firestore
                          .collection('comments')
                          .where('postId', isEqualTo: widget.post.id)
                          .orderBy('author', descending: true)
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          final comments = snapshot.data!.docs.map((doc) {
                            final data = doc.data() as Map<String, dynamic>;
                            return Comment(
                              author: data['author'],
                              text: data['text'],
                              timestamp: data['timestamp'],
                              id: doc.id,
                              postId: widget.post.id.toString(),
                              userId: FirebaseAuth.instance.currentUser!.uid,
                            );
                          }).toList();
                          if (comments.isEmpty) {
                            return Center(
                              child: Text(
                                'No Comments Available',
                                style: TextStyle(color: Colors.black, fontSize: 20),
                              ),
                            );
                          }
                          return ListView.builder(
                            padding: const EdgeInsets.fromLTRB(20, 5, 20, 100),
                            itemCount: comments.length,
                            itemBuilder: (BuildContext context, int index) {
                              comment = comments[index];
                              bool isLiked = likedComments.containsKey(comments[index].id)
                                  ? likedComments[comments[index].id]!
                                  : false;
                              bool isDisliked = dislikedComments.containsKey(comments[index].id)
                                  ? dislikedComments[comments[index].id]!
                                  : false;


                              return Padding(
                                padding: const EdgeInsets.only(
                                  right: 8.0,
                                  top: 10,
                                  bottom: 5,
                                ),
                                child: Container(
                                  constraints: BoxConstraints(minWidth: 100),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            RandomAvatar(comment?.author ?? "", height: 40, width: 40),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              comment?.author ?? "",
                                              style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 15,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            Spacer(),
                                            Text(
                                              comment?.timestamp.substring(0, 11) ?? "",
                                              style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 10,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(top: 8.0, left: 10),
                                          child: Text(
                                            comment?.text ?? "",
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 15,
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 10),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            InkWell(
                                              onTap: () {
                                                setState(() {
                                                  type = 'Reply';
                                                  _replyController.clear();
                                                  selectedCommentId = comments[index].id;
                                                });
                                                print('Selected comment id is $selectedCommentId');
                                              },
                                              child: Text(
                                                "Reply",
                                                style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: [
                                                IconButton(
                                                  icon: Icon(
                                                    isLiked ? Icons.favorite : Icons.favorite_border,
                                                    color: isLiked ? Colors.red : null,
                                                    size: 20,

                                                  ),
                                                  onPressed: () async {
                                                    bool updatedLikedStatus = await toggleLikeComment(comments[index].id);
                                                    setState(() {
                                                      likedComments[comments[index].id] = updatedLikedStatus;
                                                    });
                                                  },
                                                ),

                                                IconButton(
                                                  icon: Icon(
                                                    isDisliked ? Icons.thumb_down : Icons.thumb_down_alt_outlined,
                                                    color: isDisliked ? Colors.black : null,
                                                    size: 20,
                                                  ),
                                                  onPressed: () async {
                                                    bool updatedUnLikedStatus = await toggleUnLikeComment(comments[index].id);
                                                    setState(() {
                                                      dislikedComments[comments[index].id] = updatedUnLikedStatus;
                                                    });
                                                  },
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        showReplies == '' ?  Center(
                                          child: Text(
                                            'There is no Reply',
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 13,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        )  :
                                        InkWell(
                                          onTap: () {
                                            setState(() {
                                              // Toggle the visibility of replies
                                              showReplies = !showReplies;
                                            });
                                          },
                                          child: Padding(
                                            padding:  EdgeInsets.symmetric(vertical: 8.0),
                                            child:
                                            showReplies ?  _buildReplyList(comment!.id) :
                                            Text(
                                              'View all replies',
                                              style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 13,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        } else if (snapshot.hasError) {
                          print("Error: ${snapshot.error}");
                          return Center(
                            child: Text(
                              'Error: ${snapshot.error}',
                              style: TextStyle(color: Colors.red),
                            ),
                          );
                        } else {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      },
                    ),
                  ),
                  chatInput(comment?.id.toString(), comment?.author.toString())
                ],
              ),
            ),
          );
        },
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
