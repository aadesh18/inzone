import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:inzone/main_screens/comment_screen/comment_class.dart';
import 'package:inzone/main_screens/components/post_card.dart';
class InZonePost {
  String userName;
  String? id;
  String? textContent;
  String category;
  String mainCategory;
  List<CommentClass> comments;
  Timestamp datePosted;
  List<dynamic>? imageContent;
  List<dynamic>? videoContent;
  String userReference;
  int likes;
  InZonePost({
    required this.userName,
    this.id,
    required this.category,
    required this.datePosted,
    required this.textContent,
    required this.userReference,
    required this.mainCategory,
    this.likes = 0,
    this.videoContent,
    this.imageContent,
    required this.comments,
  });
  toInZonePostCard(InZonePost inZonePost){
    return PostCard(post: inZonePost);
  }
  // static List<InZonePost> fromJson(List json) {
  //   List<InZonePost> returnList = [];
  //   json.forEach((i){
  //     String dateString = i['date_posted'];
  //     DateFormat format = DateFormat("EEE, dd MMM yyyy HH:mm:ss 'GMT'");
  //     DateTime dateTime = format.parse(dateString, true).toUtc();
  //     Timestamp timestamp = Timestamp.fromDate(dateTime);
  //     returnList.add(
  //         InZonePost(
  //           category: i["category"] == null ? "animals" : i["category"],
  //           userName:
  //           i["user_name"] == null ? "Robert" : i["user_name"],
  //           comments: i["comments"],
  //           datePosted:timestamp,
  //           likes: i['likes'],
  //           id: "id",
  //           imageContent: i['post']['image_content'],
  //           //imageContent: ["https://images.unsplash.com/photo-1707822906791-e5a2f06d83d7?q=80&w=2574&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"],
  //           videoContent: i['post']['video_content'],
  //           textContent: i['post']['textContent'],
  //           userReference: i['user_references'] ?? "error",
  //           mainCategory: i['main_category'],
  //         ));
  //   });
  //   return returnList ;
  // }
  // static List<InZonePost> fromJson(dynamic json) {
  //   List<InZonePost> returnList = [];
  //   json['posts'].forEach((i) {
  //     Map<String, dynamic> data = i['data'];
  //     var timestampData = data['date_posted'];
  //     Timestamp timestamp = Timestamp(timestampData['_seconds'], timestampData['_nanoseconds']);
  //    dynamic commentsList = data['comments'];
  //    List<CommentClass> finalCommentsList = [];
  //
  //    // commentsList.forEach((elem){
  //    //   finalCommentsList.add(CommentClass(author: elem['name'], text: elem['text'], timestamp: Timestamp.now().toString(), id: i["id"], postId: i["id"], userId: data["user_name"] ?? "Robert", replies: elem["replies"]));
  //    // });
  //    //  print(data["comments"]);
  //    //  print("commentsList");
  //    //  print(commentsList);
  //    commentsList.clear();
  //     returnList.add(
  //       InZonePost(
  //         category: data["category"] ?? "animals",
  //         userName: data["user_name"] ?? "Robert",
  //         comments: finalCommentsList,
  //         datePosted: timestamp,
  //         likes: data['likes'] ?? 0,
  //         id: i['id'],
  //         imageContent: data['post']['image_content'] ?? [],
  //         videoContent: data['post']['video_content'] ?? [],
  //         textContent: data['post']['textContent'] ?? '',
  //         userReference: data['user_references'] ?? "error",
  //         mainCategory: data['main_category'] ?? '',
  //       ),
  //     );
  //   });
  //   return returnList;
  // }
  static List<InZonePost> fromJson(dynamic json) {
    List<InZonePost> returnList = [];
    List<dynamic> commentsList = [];
    print("Passed 1");
    json['posts'].forEach((i) {
      Map<String, dynamic> data = i['data'];
      var timestampData = data['date_posted'];
      Timestamp timestamp = Timestamp(timestampData['_seconds'], timestampData['_nanoseconds']);
      try {
      commentsList = data['comments'] as List<dynamic>;
      } catch (e){
        commentsList.add(data['comments']);

      }
      print("Passed 2");

      List<CommentClass> finalCommentsList = [];

      commentsList.forEach((elem) {
        List<ReplyClass> repliesList = [];
        if (elem['replies'] != null) {
          List<dynamic> replies = elem['replies'] as List<dynamic>;
          replies.forEach((reply) {
            repliesList.add(ReplyClass(
              name: reply['name'],
              text: reply['text'],
              uid: reply['uid']
            ));
          });
        }
        print("Passed 3");


        finalCommentsList.add(CommentClass(
          author: elem['name'] ?? "Error",
          text: elem['text'] ?? "Error",
          timestamp: Timestamp.now().toString(),
          id: elem['uid'] ?? '',
          postId: i['id'] ?? "Error",
          userId: data['user_name'] ?? 'Robert',
          replies: repliesList?? [],
          likedBy: elem['likedBy'] != null
              ? List<String>.from(elem['likedBy'])
              : [],
          dislikedBy: elem['dislikedBy'] != null
              ? List<String>.from(elem['dislikedBy'])
              : [],
        ));
        print("Passed 4");

      });
print("Passed 5");
      returnList.add(
        InZonePost(
          category: data['category'] ?? 'animals',
          userName: data['user_name'] ?? 'Robert',
          comments: finalCommentsList,
          datePosted: timestamp,
          likes: data['likes'] ?? 0,
          id: i['id'],
          imageContent: data['post']['image_content'] != null
              ? List<String>.from(data['post']['image_content'])
              : [],
          videoContent: data['post']['video_content'] != null
              ? List<String>.from(data['post']['video_content'])
              : [],
          textContent: data['post']['textContent'] ?? '',
          userReference: data['user_references'] ?? 'error',
          mainCategory: data['main_category'] ?? '',
        ),
      );
    });
    return returnList;
  }

  @override
  String toString() {
    return 'InZonePost(userName: $userName, id: $id, textContent: $textContent, category: $category, mainCategory: $mainCategory, comments: $comments, datePosted: $datePosted, imageContent: $imageContent, videoContent: $videoContent, userReference: $userReference, likes: $likes)';
  }
}