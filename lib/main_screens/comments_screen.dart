import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Import Firestore
import 'package:inzone/data/inzone_post.dart';
import 'package:inzone/main_screens/comment_screen/comment_class.dart';
import 'package:inzone/main_screens/components/post_card.dart';
import 'package:lottie/lottie.dart';

import 'comment_screen/comment_widgets.dart';
import 'comment_screen/reply_class.dart';

class CommentPage extends StatefulWidget {
  CommentPage({Key? key, required this.post}) : super(key: key);

  final InZonePost post;

  @override
  State<CommentPage> createState() => _CommentPageState();
}

class _CommentPageState extends State<CommentPage> {
  TextEditingController _replyController = TextEditingController();
  TextEditingController mySearchController = TextEditingController();
  ScrollController _scrollController = ScrollController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Map<String, bool> _showReplyFields = {}; // Map to track showing reply fields

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
        ),
        title: Text(
          'Comment Page',
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: _firestore.collection('comments').snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final comments = snapshot.data!.docs.map((doc) {
                    final data = doc.data() as Map<String, dynamic>;
                    return Comment(
                      author: data['author'],
                      text: data['text'],
                      timestamp: data['timestamp'],
                      id: doc.id, postId: widget.post.id.toString(), userId: '',
                    );
                  }).toList();

                  return ListView.builder(
                    padding: const EdgeInsets.fromLTRB(20, 5, 20, 100),
                    itemCount: comments.length,
                    itemBuilder: (BuildContext context, int index) {
                      final comment = comments[index];
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
                            border: Border.all(
                              color: Colors.black26,
                              width: 1,
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      height: 50,
                                      width: 50,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                          image: AssetImage(
                                            'images/sample_avatar_2.png',
                                          ),
                                        ),
                                      ),
                                    ),
                                    Text(
                                      comment.author,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 17,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  comment.text,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                  ),
                                ),
                                SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        _toggleReplyField(comment.id!);
                                      },
                                      child: Text(
                                        "Reply",
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      comment.timestamp.substring(0, 11),
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 11,
                                      ),
                                    ),
                                  ],
                                ),
                                if (_showReplyFields[comment.id] ?? false)
                                  _buildReplyField(comment.id),
                                _buildReplyList(comment.id),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }

                return CircularProgressIndicator();
              },
            ),
          ),
          chatInput()
        ],
      ),
    );
  }
  Widget chatInput() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
      child: Row(
        children: [
          Expanded(
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
                        controller: mySearchController,
                        onTap: () {},
                        maxLines: null,
                        keyboardType: TextInputType.multiline,
                        cursorHeight: 17,
                        decoration: InputDecoration(
                          suffixIconColor: Colors.grey.withOpacity(0.4),
                          contentPadding: const EdgeInsets.only(
                              top: 10, left: 16, right: 16),
                          border: InputBorder.none,
                          hintText: 'Add your comment',
                          hintStyle: const TextStyle(
                            fontSize: 14,
                            fontFamily: 'Maneola',
                            fontWeight: FontWeight.w400,
                            color: Colors.black26,
                          ),
                          filled: true,
                          fillColor: Colors.grey.withOpacity(0.1),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: BorderSide(
                                color: Colors.black38,
                              )),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: BorderSide(
                                color: Colors.black,
                              )),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          MaterialButton(
            minWidth: 43,
            height: 43,
            color: Colors.blue,
            shape: const CircleBorder(),
            onPressed: () {
              _addComment();
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
      await _firestore.collection('comments').add({
        'author': 'User', // Replace with actual user name
        'text': commentText,
        'timestamp': DateTime.now().toString(),
      });
      setState(() {
        mySearchController.clear();
      });
    }
  }

  Widget _buildReplyField(String commentId) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              controller: _replyController,
              decoration: InputDecoration(
                hintText: 'Type your reply...',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          MaterialButton(
            minWidth: 33,
            height: 33,
            color: Colors.blue,
            shape: const CircleBorder(),
            onPressed: () {
              _addReply(commentId);
              setState(() {
                _showReplyFields[commentId] =
                !(_showReplyFields[commentId] ?? false);
              });
              },
            child: const Center(
              child: Icon(
                Icons.send,
                color: Colors.white,
                size: 15,
              ),
            ),
          ),

        ],
      ),
    );
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
              leading: CircleAvatar(
                backgroundImage:
                AssetImage('images/sample_avatar_2.png'),
              ),
              title: Text(reply.author),
              subtitle: Text(reply.text),
              trailing: Text(reply.timestamp.substring(0, 11)),
            ))
                .toList(),
          );
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }

        return CircularProgressIndicator();
      },
    );
  }

  void _toggleReplyField(String commentId) {
    setState(() {
      _showReplyFields[commentId] =
      !(_showReplyFields[commentId] ?? false);
    });
  }

  void _addReply(String commentId) async {
    String replyText = _replyController.text.trim();
    if (replyText.isNotEmpty) {
      await _firestore
          .collection('comments')
          .doc(commentId)
          .collection('replies')
          .add({
        'author': 'User', // Replace with actual user name
        'text': replyText,
        'timestamp': DateTime.now().toString(),
      });
      _replyController.clear();
    }
  }
}
