import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

import 'package:path/path.dart';
import 'chat_user_data.dart';
import 'messege.dart';

class AuthWork {
  static FirebaseAuth auth = FirebaseAuth.instance;
  static FirebaseFirestore firestore = FirebaseFirestore.instance;

  static User get user => auth.currentUser!;
  static FirebaseStorage storage = FirebaseStorage.instance;


  //for gmail user


  // for checking if user exists or not?

  //get only last message of a specific chat
  // static Stream<QuerySnapshot<Map<String, dynamic>>> getLastMessage(
  //     AcceptedDateData user) {
  //   return firestore
  //       .collection('chats/${getConversationID(user.id!)}/messages/')
  //       .orderBy('sent', descending: true)
  //       .limit(1)
  //       .snapshots();
  // }




  static Stream<DocumentSnapshot<Map<String, dynamic>>> getAllMessages(
      AcceptedDateData user) {
    return firestore
        .collection('messages')
        .doc(user.id)
        .snapshots();
  }




  // // for getting specific user info
  // static Stream<QuerySnapshot<Map<String, dynamic>>> getUserInfo(
  //     AcceptedDateData chatUser) {
  //   return firestore
  //       .collection('UserChat')
  //       .where('email', isEqualTo: FirebaseAuth.instance.currentUser!.email)
  //       .snapshots(); // Update with your stream
  // }

 static Future<String?> getConversationID(userEmail, userName) async {
    String? id ; bool found = false;
   await  firestore
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.email).get().then((value)  async {

          try {

            List allChats = value["chats"];
            allChats.forEach((element) {
              print(element['email']);
              print(userEmail);
              if (element['email'] == userEmail){
                found = true;
                id = element['id'];
                print("THE ID cccc IS $id");

              }
            });
            if (found==false){

              await FirebaseFirestore.instance.collection("messages").add(
                  {       "chatMessages" : [],
                    "users" : [FirebaseAuth.instance.currentUser!.email, userEmail]}
              ).then( (value) async {

                id = value.id;
                print("THE IDdddd IS $id");
                await FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.email).update({
                  "chats": FieldValue.arrayUnion(
                  [{
                  "email":userEmail,
                  "id":id,
                  "name":userName
                  }]
                  )
                });
                await FirebaseFirestore.instance.collection("users").doc(userEmail).update({
                  "chats": FieldValue.arrayUnion(
                      [{
                        "email":FirebaseAuth.instance.currentUser!.email,
                        "id":id,
                        "name":FirebaseAuth.instance.currentUser!.displayName
                      }]
                  )
                });
                return id;
              }
              );
            }
          } catch(e){
       print(e);
          }


     });
    return id;
  }


  // //update read status of message
  // static Future<void> updateMessageReadStatus(Messges message, AcceptedDateData user) async {
  //   firestore
  //       .collection('messages')
  //       .doc(user.id)
  //       .update({'read': DateTime.now().millisecondsSinceEpoch.toString()});
  // }



  // //delete message
  // static Future<void> deleteMessage(Messges message) async {
  //   await firestore
  //       .collection('chats/${getConversationID(message.toId!)}/messages/')
  //       .doc(message.sent)
  //       .delete();
  //
  //
  // }


//send first msg

  // static Future<void> sendFirstMessage(
  //     AcceptedDateData chatUser, String msg, Typee type) async {
  //   await firestore
  //       .collection('UserChat')
  //       .doc(chatUser.id!+user.uid)
  //       .collection('my_users')
  //       .doc(user.uid)
  //       .set({}).then((value) => sendMessage(chatUser, msg, type));
  // }


  //send chat image
  static Future<void> sendChatImage(AcceptedDateData chatUser, File file) async {
    //getting image file extension
    final ext = file.path.split('.').last;

    //storage file ref with path
    final ref = storage.ref().child(
        'images/${chatUser.id}/${DateTime.now().millisecondsSinceEpoch}.$ext');

    //uploading image
    await ref
        .putFile(file, SettableMetadata(contentType: 'image/$ext'))
        .then((p0) {
      log('Data Transferred: ${p0.bytesTransferred / 1000} kb');
    });

    //updating image in firestore database
    final imageUrl = await ref.getDownloadURL();
    await sendMessage(chatUser, imageUrl, Typee.image);
  }

  //send chat video

// Function to send chat video
  static Future<void> sendChatVideo(AcceptedDateData chatUser, File videoFile) async {
    try {
      // Getting video file extension
      final ext = extension(videoFile.path);

      // Storage file ref with path for video
      final videoRef = storage.ref().child(
          'videos/${chatUser.id}/${DateTime.now().millisecondsSinceEpoch}$ext');

      // Uploading video
      final videoTask = videoRef.putFile(videoFile, SettableMetadata(contentType: 'video/$ext'));
      final videoSnapshot = await videoTask.whenComplete(() {});
      final videoUrl = await videoSnapshot.ref.getDownloadURL();

      // Generate thumbnail
      final thumbnail = await generateThumbnail(videoFile);

      // Storage file ref with path for thumbnail
      final thumbnailRef = storage.ref().child(
          'thumbnails/${chatUser.id}/${DateTime.now().millisecondsSinceEpoch}_thumbnail.jpg');

      // Uploading thumbnail
      final thumbnailTask = thumbnailRef.putFile(thumbnail);
      final thumbnailSnapshot = await thumbnailTask.whenComplete(() {});
      final thumbnailUrl = await thumbnailSnapshot.ref.getDownloadURL();

      // Send message with video and thumbnail URLs
      await sendMessage(chatUser, videoUrl, Typee.video, thumbnailUrl: thumbnailUrl);
    } catch (e) {
      print('Error uploading video: $e');
      throw Exception('Error uploading video');
    }
  }


// Function to generate thumbnail from video file
  static Future<File> generateThumbnail(File videoFile) async {
    // Generate thumbnail using video_thumbnail package
    final thumbnail = await VideoThumbnail.thumbnailFile(
      video: videoFile.path,
      imageFormat: ImageFormat.JPEG,
      maxWidth: 150, // Specify the width of the thumbnail
      quality: 25, // Specify the quality of the thumbnail
    );
    return File(thumbnail.toString());
  }



// for sending message
  static Future<void> sendMessage(AcceptedDateData chatUser, String msg, Typee type, {String? thumbnailUrl}) async {

    // message sending time (also used as id)
    print("IN SEND MESSAGE");
    final time = DateTime.now().millisecondsSinceEpoch.toString();

    // message to send
    final Messges message = Messges(
      toId: chatUser.email,
      msg: msg,
      read: '',
      type: type,
      fromId: user.uid,
      sent: time,
      thumbnailUrl: thumbnailUrl, // Pass the thumbnailUrl parameter
    );
print(chatUser.id);
    final ref = firestore
        .collection('messages');
    print(message.toJson);
    await ref.doc(chatUser.id).update(
      {
        "chatMessages": FieldValue.arrayUnion([message.toJson( )])
      }
    );
        //.then((value) =>
      //sendPushNotification(chatUser as AcceptedDateData, type == Typee.text ? msg : 'image'));

    // await ref.doc(time).set(message.toJson()).then((value) =>
    //     sendPushNotification(chatUser as AcceptedDateData, type == Typee.text ? msg : 'image'));
  }



  // for sending push notification
  // static Future<void> sendPushNotification(
  //     AcceptedDateData chatUser, String msg) async {
  //   try {
  //     final body = {
  //       "to": chatUser.id,
  //       "notification": {
  //         "title": chatUser.name, //our name should be send
  //         "body": msg,
  //         "android_channel_id": "chats"
  //       },
  //       "data": {
  //         "some_data": "User ID: ${chatUser.id}",
  //       },
  //     };
  //
  //   } catch (e) {
  //     // log('\nsendPushNotificationE: $e');
  //   }
  // }



  // chats (collection) --> conversation_id (doc) --> messages (collection) --> message (doc)

  // useful for getting conversation id
  // static String getConversationID(String id) => user.uid.hashCode <= id.hashCode
  //     ? '${user.uid}_$id'
  //     : '${id}_${user.uid}';


}
