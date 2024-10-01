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
import '../main_screens/root_app.dart';

class InZoneDatabase {
  static Future<InZoneCurrentUser?> getUserData(String docID) async {
    final docRef = FirebaseFirestore.instance
        .collection(CollectionNames.usersCollection)
        .doc(docID);
    InZoneCurrentUser? user;
    await docRef.get().then(
          (DocumentSnapshot doc) {
        final data = doc.data() as Map<String, dynamic>;

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

  static Future<List<InZonePost>> getFeed() async {
    Random random = Random();
    int randomIndex = random.nextInt(7);
    List<InZonePost> posts = [];  // This needs to be declared once here
    int currentIndex = 0;
    InZoneCurrentUser.subCategories = [];  // Reset the categories list
    String? email = FirebaseAuth.instance.currentUser?.email;
    String url = "";
    DateTime time = DateTime.now();

    // Build the URL based on whether the email is present
    if (email != null) {
      url = 'https://us-central1-inzonebackend.cloudfunctions.net/api/get_posts';
    } else {
      url = 'https://us-central1-inzonebackend.cloudfunctions.net/api/get_posts';
    }

    try {
      // Make the POST request
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );

      // Check if the response status code is 200 (OK)
      if (response.statusCode == 200) {
        // Decode the response body
        final jsonMap = jsonDecode(response.body.toString());
        print("Posts received:");
        print(jsonMap);

        // Ensure the expected data structure is valid
        if (jsonMap != null && jsonMap is Map<String, dynamic>) {
          try {
            // Convert the JSON response to List of InZonePost objects
            List<InZonePost> fetchedPosts = InZonePost.fromJson(jsonMap);
            print("Post converted successfully:");
            print(fetchedPosts);

            // Add subcategories based on posts
            fetchedPosts.forEach((elem) {
              int randomIndex = currentIndex;

              // Add categories to the current user subcategories list
              InZoneCurrentUser.subCategories.add(
                elem.category.trim().isEmpty
                    ? InZoneCategory(categoryName: "Animals", index: randomIndex)
                    : InZoneCategory(categoryName: elem.category, index: randomIndex),
              );

              // Reset the current index after reaching the limit (6)
              if (currentIndex == 6) {
                currentIndex = 0;
              } else {
                currentIndex += 1;
              }
            });

            randomIndex = currentIndex;

            // Return the fetched posts after successful conversion
            return fetchedPosts;
          } catch (e) {
            // Catch any errors during the conversion process
            print("Error during post conversion: $e");
            return posts;  // Return empty list in case of error
          }
        } else {
          print("Invalid JSON structure");
          return posts;  // Return empty list in case of invalid response
        }
      } else {
        // Log if status code is not 200 (OK)
        print("Failed to load posts. Status code: ${response.statusCode}");
        return posts;  // Return empty list in case of failure
      }
    } catch (e) {
      // Handle any other exceptions
      print("Error occurred during data fetching: $e");
      return posts;  // Return empty list in case of error
    }
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


  // static Future<int> postContent({
  //   required String postMessage,
  //   required List<String> imageRef,
  //   required List<String> videoRef,
  // }) async {
  //   bool added = false;
  //   String category = "Unknown"; // Default category
  //   int sentiment = -10;
  //
  //   try {
  //     var value = await InZoneDatabase.sendSentimentRequest(postMessage);
  //     if (value != null && value["sentiment"] != -1) {
  //       sentiment = int.parse(value["sentiment"]);
  //       try {
  //         category = value["category"];
  //         if (category.contains("-")) {
  //           List<String> parts = category.split('-');
  //           parts.map((part) => part[0].toUpperCase() + part.substring(1));
  //           parts.join(" ");
  //         }
  //         DateTime now = DateTime.now();
  //         int currentHour = now.hour;
  //         String mainCategory = "";
  //         if (currentHour >= 9 && currentHour < 17) {
  //           mainCategory = "focus";
  //         } else if (currentHour >= 17 && currentHour < 22) {
  //           mainCategory = "fallback";
  //         } else {
  //           mainCategory = "custom";
  //         }
  //         if (category.length < 1) {
  //           category = "Entertainment";
  //         }
  //         await FirebaseFirestore.instance
  //             .collection(CollectionNames.postsCollection)
  //             .add({
  //           "category": category,
  //           "comments": [],
  //           "date_posted": DateTime.now(),
  //           "likes": 0,
  //           "main_category": mainCategory,
  //           "post": {
  //             "image_content": imageRef,
  //             "video_content": videoRef,
  //             "textContent": postMessage
  //           },
  //           "sub_category": category,
  //           "user_name": FirebaseAuth.instance.currentUser!.displayName,
  //           "user_references": FirebaseAuth.instance.currentUser!.email,
  //         });
  //         added = true;
  //       } catch (e) {
  //         category = "Entertainment"; // Default to entertainment on error
  //       }
  //     }
  //   } catch (e) {
  //
  //   }
  //
  //   return sentiment;
  // }

  static Future<int> postContent({
    required String postMessage,
    required List<String> imageRef,
    required List<String> videoRef,
  }) async {
    bool added = false;
    String category = "Unknown"; // Default category
    int sentiment = -10;

    try {
      // First, get sentiment analysis for the post
      var value = await InZoneDatabase.sendSentimentRequest(postMessage);
      if (value != null && value["sentiment"] != -1) {
        sentiment = int.parse(value["sentiment"]);

        // Parse category and format properly
        try {
          category = value["category"];
          if (category.contains("-")) {
            List<String> parts = category.split('-');
            parts = parts.map((part) => part[0].toUpperCase() + part.substring(1)).toList();
            category = parts.join(" ");
          }

          // Set the main category based on the time of the day
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

          // Ensure category has a value
          if (category.isEmpty) {
            category = "Entertainment";
          }

          // Prepare the post content to send via the new API
          var postBody = jsonEncode({
            "category": category,
            "comments": [],
            "date_posted": DateTime.now().toIso8601String(), // Ensure date is in ISO format
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

          // Send POST request to the new API endpoint
          final response = await http.post(
            Uri.parse('https://us-central1-inzonebackend.cloudfunctions.net/api/create_post'),
            headers: {
              'Content-Type': 'application/json',
            },
            body: postBody,
          );

          // Check if the POST request was successful
          if (response.statusCode == 200) {
            added = true;
          } else {
            // Handle failure
            print('Failed to create post: ${response.statusCode}');
          }

        } catch (e) {
          category = "Entertainment"; // Default to entertainment on error
        }
      }
    } catch (e) {
      // Handle any other exceptions
      print('Error: $e');
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



        return responseData;
      } else {

        return null;
      }
    } catch (e) {
      // Handle any errors that occur during the request

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

        return responseData;
      } else {

        return null;
      }
    } catch (e) {
      // Handle any errors that occur during the request

      return null;
    }
  }


  static Future<void> signUpAnonymouslyAndCreateDocument(BuildContext context) async {
    try {

      UserCredential userCredential = await FirebaseAuth.instance.signInAnonymously();
      User? user = userCredential.user;

      if (user != null) {
        // Create a Firestore document with sample values
        final userCollection = FirebaseFirestore.instance.collection('users');
        String uid = user.uid;

        await userCollection.doc(uid).set({
          "age": 0, // Sample age
          "bio": "",
          "categories": {
            "focus": [],
            "fallback": [],
            "custom": []
          },
          "chats":[],
          "email":"anonymous",
          "family":"",
          "firstName": "anonymous",
          "lastName": "anonymous",
          "followers":[],
          "following": [],
          "gender": "anonymous",
          "parent": false,
          "user_name": "anonymous",
          "ai":false,
          "uid": uid
        });

        // Navigate to the root app or home screen
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
          return RootApp();
        }));
      } else {
        throw FirebaseAuthException(
          code: 'ERROR_ANONYMOUS_SIGN_IN_FAILED',
          message: 'Anonymous sign-in failed',
        );
      }
    } on FirebaseAuthException catch (e) {
      // Show error message
      final snackBar = SnackBar(
        content: Text("Error: ${e.message}"),
        backgroundColor: Colors.red,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
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