import 'dart:convert';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:inzone/backend/collection_names.dart';
import 'package:inzone/constants.dart';
import 'package:inzone/data/inzone_category.dart';
import 'package:inzone/data/inzone_current_user.dart';
import 'package:inzone/data/inzone_user.dart';
import 'package:inzone/data/inzone_post.dart';

import '../data/inzone_message.dart';

class InZoneDatabase {
  static Future<InZoneCurrentUser?> getUserData(String docID) async {
    final docRef = FirebaseFirestore.instance
        .collection(CollectionNames.usersCollection)
        .doc(docID);
    InZoneCurrentUser? user;
    await docRef.get().then(
      (DocumentSnapshot doc) {
        final data = doc.data() as Map<String, dynamic>;
        print(data['user_references']);
        user = InZoneCurrentUser(
            firstName: data["firstName"],
            lastName: data["lastName"],
            email: data["user_references"],
            adult: data["adult"],
            family:[data["family"]],
            userName: data["user_name"]);
      },


      onError: (e) => print("Error getting document: $e"),
    );

    return user;
  }

  static Future<List<InZonePost>> getFeed(collectionName) async {
    Random random = Random();
    int randomIndex = random.nextInt(7);
    List<InZonePost> posts = [];
    int currentIndex = 0;
    InZoneCurrentUser.subCategories = [];
    final collectionRef =
        FirebaseFirestore.instance.collection(CollectionNames.postsCollection);
    DateTime now = DateTime.now();
    int currentHour = now.hour;

    if (currentHour >= 9 && currentHour < 17) {
      // Focus
      await collectionRef
          .where('main_category', isEqualTo: "focus").orderBy('date_posted',descending: true)
          .limit(20)
          .get()
          .then((value) {
        for (var element in value.docs) {
          randomIndex = currentIndex;
          InZoneCurrentUser.subCategories.add(
            element["category"] == null
                ? InZoneCategory(categoryName: "animals", index: randomIndex)
                : InZoneCategory(
                    categoryName: element['category'], index: randomIndex),
          );
          if (currentIndex == 6) {
            currentIndex = 0;
          } else {
            currentIndex += 1;
          }
          posts.add(InZonePost(
            category:
                element["category"] == null ? "animals" : element["category"],
            userName:
                element["user_name"] == null ? "aadesh" : element["user_name"],
            comments: element["comments"],
            datePosted: element["date_posted"],
            likes: element['likes'],
            id: element.id,
            imageContent: element['post']['image_content'],
            //imageContent: ["https://images.unsplash.com/photo-1707822906791-e5a2f06d83d7?q=80&w=2574&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"],
            videoContent: element['post']['video_content'],
            textContent: element['post']['textContent'],
            userReference: element['user_references'] ?? "error",
            mainCategory: element['main_category'],
          ));
          print('my doc id is ${element.id}');
          print(
              'my current user is ${FirebaseAuth.instance.currentUser!.email}');
        }
      });
    } else if (currentHour >= 17 && currentHour < 22) {
      // Focus
      print("fallback");
      await collectionRef
          .where('main_category', isEqualTo: "fallback").orderBy('date_posted',descending: true)
          .limit(20)
          .get()
          .then((value) {
        print(value.docs.length);
        for (var element in value.docs) {
          randomIndex = currentIndex;
          InZoneCurrentUser.subCategories.add(
            element["category"] == null
                ? InZoneCategory(categoryName: "animals", index: randomIndex)
                : InZoneCategory(
                    categoryName: element['category'], index: randomIndex),
          );
          if (currentIndex == 6) {
            currentIndex = 0;
          } else {
            currentIndex += 1;
          }
          posts.add(InZonePost(
            category:
                element["category"] == null ? "animals" : element["category"],
            userName:
                element["user_name"] == null ? "aadesh" : element["user_name"],
            comments: element["comments"],
            datePosted: element["date_posted"],
            likes: element['likes'],
            id: element.id,
            imageContent: element['post']['image_content'],
            //imageContent: ["https://images.unsplash.com/photo-1707822906791-e5a2f06d83d7?q=80&w=2574&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"],
            videoContent: element['post']['video_content'],
            textContent: element['post']['textContent'],
            userReference: element['user_references'] ?? "error",
            mainCategory: element['main_category'],
          ));
        }
      });
    } else {
      // Custom

      await collectionRef
          .where('main_category', isEqualTo: "custom").orderBy('date_posted',descending: true)
          .limit(20)
          .get()
          .then((value) {
        for (var element in value.docs) {
          randomIndex = currentIndex;
          InZoneCurrentUser.subCategories.add(
            element["category"] == null
                ? InZoneCategory(categoryName: "animals", index: randomIndex)
                : InZoneCategory(
                    categoryName: element['category'], index: randomIndex),
          );
          if (currentIndex == 6) {
            currentIndex = 0;
          } else {
            currentIndex += 1;
          }
          posts.add(InZonePost(
            category:
                element["category"] == null ? "animals" : element["category"],
            userName:
                element["user_name"] == null ? "aadesh" : element["user_name"],
            comments: element["comments"],
            datePosted: element["date_posted"],
            likes: element['likes'],
            id: element.id,
            imageContent: element['post']['image_content'],
            //imageContent: ["https://images.unsplash.com/photo-1707822906791-e5a2f06d83d7?q=80&w=2574&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"],
            videoContent: element['post']['video_content'],
            textContent: element['post']['textContent'],
            userReference: element['user_references'] ?? "error",
            mainCategory: element['main_category'],
          ));
        }
      });
    }
    if (posts.length < 5) {
      // Focus
      await collectionRef.limit(30).orderBy('date_posted',descending: true).get().then((value) {
        for (var element in value.docs) {
          randomIndex = currentIndex;
          InZoneCurrentUser.subCategories.add(
            element["category"] == null
                ? InZoneCategory(categoryName: "animals", index: randomIndex)
                : InZoneCategory(
                    categoryName: element['category'], index: randomIndex),
          );
          if (currentIndex == 6) {
            currentIndex = 0;
          } else {
            currentIndex += 1;
          }
          // posts.add(InZonePost(
          //   category: element["category"] == null ? "animals" : element["category"]  ,
          //   userName: element["user_name"],
          //   comments: element["comments"],
          //   datePosted: element["date_posted"],
          //   likes: element['likes'],
          //   id: element.id,
          //   imageContent: element['post']['image_content'] ,
          //   //imageContent: ["https://images.unsplash.com/photo-1707822906791-e5a2f06d83d7?q=80&w=2574&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"],
          //   videoContent: element['post']['video_content'] ,
          //   textContent: element['post']['textContent'], userReference: element['user_references'], mainCategory: element['main_category'],
          // ));
        }
      });
    }
    return posts;
  }

  static Future<List<InZonePost>> getExploreFeed(collectionName) async {
    List<InZonePost> posts = [];
    InZoneCurrentUser.subCategories = [];
    final collectionRef =
        FirebaseFirestore.instance.collection(CollectionNames.postsCollection);
    DateTime now = DateTime.now();
    int currentHour = now.hour;
    // Focus
    await collectionRef.limit(20).get().then((value) {
      for (var element in value.docs) {
        posts.add(InZonePost(
          category:
              element["category"] == null ? "Sports" : element["category"],
          userName: element["user_name"] ?? "Aadesh",
          comments: element["comments"],
          datePosted: element["date_posted"],
          likes: element['likes'],
          id: element.id,
          imageContent: element['post']['image_content'],
          videoContent: element['post']['video_content'],
          textContent: element['post']['textContent'],
          userReference: element['user_references'],
          mainCategory: element['main_category'],
        ));
      }
    });

    print("Explore Functin");
    print(posts);
    return posts;
  }

  List<InZoneMessage> getMessages(
      AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>> snapshot) {
    List<InZoneMessage> messageList = [];
    List tempList = [];
    bool isMe;
    if (snapshot.hasData) {
      tempList = snapshot.data!.data()!['chatMessages'];
      for (var element in tempList.reversed) {
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
      }
    }
    return messageList;
  }

  Future<bool> addNewMessage(
      {required var usersList,
      required String chatReference,
      required List<dynamic> messageList}) async {
    bool added = false;
    List<Map<String, dynamic>> tempList = [];
    for (var element in messageList) {
      tempList.add({
        "message": element.message,
        "sender": element.senderID,
        "timeSent": Timestamp.fromDate(element.timeSent)
      });
    }
    await FirebaseFirestore.instance
        .collection(CollectionNames.messagesCollection)
        .doc(chatReference)
        .update(
      {"users": usersList, "chatMessages": tempList},
    );
    return added;
  }

  static Future<int> postContent({
    required String postMessage,
    required List<String> imageRef,
    required List<String> videoRef,
  }) async {
    bool added = false;
    String category = "Unknown"; // Default category
    int sentiment = -10;

    try {
      var value = await InZoneDatabase.sendSentimentRequest(postMessage);
      if (value != null && value["sentiment"] != -1) {
        sentiment = int.parse(value["sentiment"]);
        try {
          category = value["category"];
          if (category.contains("-")) {
            List<String> parts = category.split('-');
            parts.map((part) => part[0].toUpperCase() + part.substring(1));
            parts.join(" ");
          }
          DateTime now = DateTime.now();
          int currentHour = now.hour;
          String mainCategory = "";
          if (currentHour >= 9 && currentHour < 17) {
            mainCategory = "focus";
          } else if (currentHour >= 17 && currentHour < 22) {
            mainCategory = "fallback";
          } else {
            mainCategory = "custom";
          }
          if (category.length < 1) {
            category = "Entertainment";
          }
          await FirebaseFirestore.instance
              .collection(CollectionNames.postsCollection)
              .add({
            "category": category,
            "comments": [],
            "date_posted": DateTime.now(),
            "likes": 0,
            "main_category": mainCategory,
            "post": {
              "image_content": imageRef,
              "video_content": videoRef,
              "textContent": postMessage
            },
            "sub_category": category,
            "user_name": FirebaseAuth.instance.currentUser!.displayName,
            "user_references": FirebaseAuth.instance.currentUser!.email,
          });
          added = true;
        } catch (e) {
          category = "Entertainment"; // Default to entertainment on error
        }
      }
    } catch (e) {
      print(e);
    }

    return sentiment;
  }

  static Future<Map<String, dynamic>?> sendSentimentRequest(String body) async {
    const String url =
        'https://us-central1-inzonebackend.cloudfunctions.net/api/sentiment-analysis';
    try {
      final http.Response response = await http.post(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'text/plain; charset=UTF-8',
        },
        body: body, // Send raw text directly as the body
      );

      if (response.statusCode == 200) {
        // Assuming the response is JSON, decode it
        final Map<String, dynamic> responseData = json.decode(response.body);
        print("This is where the response begins:\n\n\n");
        print(responseData);
        print("This is where the response ends:\n\n\n");
        return responseData;
      } else {
        print('Server error: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      // Handle any errors that occur during the request
      print('Error sending request: $e');
      return null;
    }
  }

  Future<Map<String, dynamic>?> sendPostRequest() async {
    const String url =
        'https://us-central1-inzonebackend.cloudfunctions.net/api/get_posts';
    try {
      final http.Response response = await http.post(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(
            <String, dynamic>{}), // Send raw text directly as the body
      );

      if (response.statusCode == 200) {
        // Assuming the response is JSON, decode it
        final Map<String, dynamic> responseData = json.decode(response.body);
        print(responseData);
        return responseData;
      } else {
        print('Server error: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      // Handle any errors that occur during the request
      print('Error sending request: $e');
      return null;
    }
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
