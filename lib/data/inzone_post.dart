import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:inzone/main_screens/components/post_card.dart';

class InZonePost {
  String userName;
  String? id;
  String? textContent;
  String category;
  String mainCategory;
  dynamic? comments;
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
    this.comments,
  });


  toInZonePostCard(InZonePost inZonePost){
    return PostCard(post: inZonePost);

  }




   static List<InZonePost> fromJson(List json) {
    List<InZonePost> returnList = [];
    json.forEach((i){
      String dateString = i['date_posted'];
      DateFormat format = DateFormat("EEE, dd MMM yyyy HH:mm:ss 'GMT'");
      DateTime dateTime = format.parse(dateString, true).toUtc();
      Timestamp timestamp = Timestamp.fromDate(dateTime);

      returnList.add(
          InZonePost(
            category: i["category"] == null ? "animals" : i["category"],
            userName:
            i["user_name"] == null ? "Robert" : i["user_name"],
            comments: i["comments"],
            datePosted:timestamp,
            likes: i['likes'],
            id: "id",
            imageContent: i['post']['image_content'],
            //imageContent: ["https://images.unsplash.com/photo-1707822906791-e5a2f06d83d7?q=80&w=2574&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"],
            videoContent: i['post']['video_content'],
            textContent: i['post']['textContent'],
            userReference: i['user_references'] ?? "error",
            mainCategory: i['main_category'],
          ));
    });


    return returnList ;
  }
}
