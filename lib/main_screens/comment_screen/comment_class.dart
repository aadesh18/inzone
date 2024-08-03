import 'package:comment_tree/data/comment.dart';

class ReplyClass {
  String name;
  String text;
  String uid;

  ReplyClass({required this.name, required this.text, required this.uid});

  factory ReplyClass.fromJson(Map<String, dynamic> json) {
    return ReplyClass(
      name: json['name'],
      text: json['text'],
      uid: json['uid']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'text': text,
      'uid': uid
    };
  }
}

class CommentClass extends Comment {
  final String author;
  final String text;
  final String timestamp;
  final String id;
  final String postId;
  final String userId;
  List<String>? likedBy;
  List<String>? dislikedBy;
  final List<ReplyClass> replies;

  CommentClass({
    required this.author,
    required this.text,
    required this.timestamp,
    required this.id,
    required this.postId,
    required this.userId,
    required this.replies,
    this.likedBy,
    this.dislikedBy,
  }) : super(avatar: "avatar", userName: author, content: text);
  //
  // factory CommentClass.fromJson(Map<String, dynamic> json) {
  //   return CommentClass(
  //     author: json['author'],
  //     text: json['text'],
  //     timestamp: json['timestamp'],
  //     id: json['uid'] ?? '',
  //     postId: json['postId'],
  //     userId: json['userId'],
  //     replies: json['replies'] != null
  //         ? List<ReplyClass>.from(
  //         json['replies'].map((reply) => ReplyClass.fromJson(reply)))
  //         : [],
  //     likedBy:
  //         json['likedBy'] != null ? List<String>.from(json['likedBy']) : [],
  //     dislikedBy: json['dislikedBy'] != null
  //         ? List<String>.from(json['dislikedBy'])
  //         : [],
  //   );
  // }
  //
  // Map<String, dynamic> toJson() {
  //   return {
  //     'author': author,
  //     'text': text,
  //     'timestamp': timestamp,
  //     'id': id,
  //     'postId': postId,
  //     'userId': userId,
  //     'replies': replies.map((reply) => reply.toJson()).toList(),
  //     'likedBy': likedBy,
  //     'dislikedBy': dislikedBy,
  //   };
  // }

  factory CommentClass.fromJson(Map<String, dynamic> json) {
    return CommentClass(
      author: json['name'],
      text: json['text'],
      timestamp: json['timestamp'].toString(),
      id: json['uid'] ?? '',
      postId: json['postId'] ?? '',
      userId: json['userId'] ?? '',
      replies: json['replies'] != null
          ? List<ReplyClass>.from(
          json['replies'].map((reply) => ReplyClass.fromJson(reply)))
          : [],
      likedBy: json['likedBy'] != null
          ? List<String>.from(json['likedBy'])
          : [],
      dislikedBy: json['dislikedBy'] != null
          ? List<String>.from(json['dislikedBy'])
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': author,
      'text': text,
      'timestamp': timestamp,
      'uid': id,
      'postId': postId,
      'userId': userId,
      'replies': replies.map((reply) => reply.toJson()).toList(),
      'likedBy': likedBy,
      'dislikedBy': dislikedBy,
    };
  }

}
