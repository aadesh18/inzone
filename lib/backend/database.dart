import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:inzone/backend/collection_names.dart';
import 'package:inzone/data/inzone_user.dart';
import 'package:inzone/data/post.dart';

import '../data/inzone_message.dart';

class InZoneDatabase {
  static Future<InZoneUser?> getUserData(String docID) async {
    final docRef = FirebaseFirestore.instance
        .collection(CollectionNames.usersCollection)
        .doc(docID);
    InZoneUser? user;
    await docRef.get().then(
      (DocumentSnapshot doc) {
        final data = doc.data() as Map<String, dynamic>;
        user = InZoneUser(
            firstName: data["firstName"],
            lastName: data["lastName"],
            email: data["email"],
            adult: data["adult"],
            family: data["family"],
            userName: data["userName"]);
      },
      onError: (e) => print("Error getting document: $e"),
    );
    return user;
  }

  static Future<List<InZonePost>> getFeed(collectionName) async {
    List<InZonePost> posts = [];
    final collectionRef = FirebaseFirestore.instance.collection(collectionName);
    print("Fetching data");
    await collectionRef.get().then((value) {
      value.docs.forEach((element) {
        posts.add(InZonePost(
          userName: element["user_name"],
          firstName: "David",
          lastName: "Morel",
          profilePicturePath: "images/sample_avatar_1.png",
          description: element["post"]["textContent"],
        ));
      });
    });
    posts.insert(
        1,
        InZonePost(
            userName: "david_morel",
            profilePicturePath: "images/sample_avatar_1.png",
            description:
                "I literally have been looking for this since the past two months. I FINALLY FOUND IT",
            firstName: "David",
            assetPath: "images/sample_picture_2.png",
            lastName: "Morel"));

    posts.insert(
        3,
        InZonePost(
            userName: "david_morel",
            profilePicturePath: "images/sample_avatar_1.png",
            description:
                "I literally have been looking for this since the past two months. I FINALLY FOUND IT",
            firstName: "David",
            assetPath: "images/sample_picture_1.png",
            lastName: "Morel"));
    return posts;
  }

  List<InZoneMessage> getMessages(
      AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>> snapshot) {
    List<InZoneMessage> messageList = [];
    List tempList = [];
    bool isMe;
    if (snapshot.hasData) {
      tempList = snapshot.data!.data()!['chatMessages'];
      tempList.reversed.forEach((element) {
        if (DateTime.now().microsecond % 2 == 0) {
          isMe = false;
        } else {
          isMe = true;
        }
        messageList.add(InZoneMessage(
            message: element['message'],
            isMe: isMe,
            // isMe: FirebaseAuth.instance.currentUser!.uid == element['sender'],
            timeSent: element['timeSent'].toDate(),
            senderID: element['sender']));
      });
    }
    return messageList;
  }

  Future<bool> addNewMessage(
      {required var usersList,
      required String chatReference,
      required List<dynamic> messageList}) async {
    bool added = false;
    List<Map<String, dynamic>> tempList = [];
    messageList.forEach((element) {
      tempList.add({
        "message": element.message,
        "sender": element.senderID,
        "timeSent": Timestamp.fromDate(element.timeSent)
      });
    });
    await FirebaseFirestore.instance
        .collection(CollectionNames.messagesCollection)
        .doc(chatReference)
        .update(
      {"users": usersList, "chatMessages": tempList},
    );
    return added;
  }

  // final Stream currentUserDocStream = FirebaseFirestore.instance
  //     .collection('users')
  //     .doc(currentUser.getUID())
  //     .snapshots();

  // parseUserData(
  //     AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>> snapshot) {
  //   if (snapshot.hasData) {
  //     Map<String, dynamic>? data = snapshot.data!.data();
  //     if (data != null) {
  //       currentUser.setChatDetails(data['chat']);
  //       currentUser.setPremium(data['premiumUser']);
  //     }
  //   }
  // }

  // DocumentReference<Map<String, dynamic>> retreiveDocument(
  //     String documentPath) {
  //   return _firestore.doc(documentPath);
  // }

  // List<Message> getMessages(
  //     AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>> snapshot) {
  //   List<Message> messageList = [];
  //   List tempList = [];

  //   if (snapshot.hasData) {
  //     tempList = snapshot.data!.data()!['chatMessages'];

  //     tempList.reversed.forEach((element) {
  //       messageList.add(Message(
  //           message: element['message'],
  //           isMe: currentUser.getUID()! == element['sender'],
  //           timeSent: element['timeSent'].toDate(),
  //           senderID: element['sender']));
  //     });
  //   }

  //   return messageList;
  // }

  // Future<bool> addNewMessage(
  //     {required var usersList,
  //     required String chatReference,
  //     required List<dynamic> messageList}) async {
  //   bool added = false;
  //   List<Map<String, dynamic>> tempList = [];
  //   messageList.forEach((element) {
  //     tempList.add({
  //       "message": element.message,
  //       "sender": element.senderID,
  //       "timeSent": Timestamp.fromDate(element.timeSent)
  //     });
  //   });
  //   await _messagesCollection.doc(chatReference).update(
  //     {"users": usersList, "chatMessages": tempList},
  //   );
  //   // await _messagesCollection.doc(chatReference).add({
  //   //   "message": message.message,
  //   //   "sender": message.senderID,
  //   //   "timeSent": ,
  //   // }).then((value) {
  //   //   added = true;
  //   // });
  //   return added;
  // }

  // Future<String> addNewChat(
  //     {required String chatName, required String chatMemberID}) async {
  //   DocumentReference docRef = await _messagesCollection.add([
  //     {
  //       "chatMessages": [],
  //       "users": [currentUser.getUID()!, chatMemberID]
  //     }
  //   ]);

  //   return docRef.id;
  // }
}
