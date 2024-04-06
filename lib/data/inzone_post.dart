import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:inzone/main_screens/components/post_card.dart';

class InZonePost {
  String userName;
  String? id;
  String? textContent;
  String category;
  String mainCategory;
  Map? comments;
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
}
