import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:inzone/constants.dart';
import 'package:inzone/data/inzone_chat.dart';
import 'package:inzone/main_screens/components/chat_card.dart';
import 'package:inzone/main_screens/components/inzone_search_bar.dart';

import '../models/auth_work.dart';
import '../models/chat_user_data.dart';
import '../models/chat_widget/chat_user_card.dart';

class AllChatsScreen extends StatefulWidget {
  const AllChatsScreen({super.key});

  @override
  State<AllChatsScreen> createState() => _AllChatsScreenState();
}

class _AllChatsScreenState extends State<AllChatsScreen> {

  // for storing user data
  List<AcceptedDateData> list = [];
  // for storing search item
   List<AcceptedDateData> _searchList = [];
  // for storing search status
  bool isSearching = false;
  AuthWork? auth;
  List<AcceptedDateData> userData = [];
  late StreamSubscription subscription;

  // getData() async {
  //   // if (user != null) {
  //   QuerySnapshot res =
  //   await FirebaseFirestore.instance.collection('newUser').get();
  //   if (res.docs.isNotEmpty)
  //     setState(() {
  //       {
  //         userData = res.docs
  //             .map((e) =>
  //             AcceptedDateData.fromMap(e.data() as Map<String, dynamic>))
  //             .toList();
  //       }
  //     });
  // }

  @override
  void initState() {
    super.initState();
    auth = AuthWork();
   // getData();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    subscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
 list.clear();
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: PreferredSize(
        preferredSize:
        const Size.fromHeight(50),
        child: AppBar(
            elevation: 0,
            automaticallyImplyLeading: false,
            backgroundColor: backgroundColor,
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios_new, size: 20,),

              color: Colors.black,
              onPressed: (){
                Navigator.pop(context);
              },
            ),
            title: Text("Chats",
                style: const TextStyle(
                    fontSize: 26, fontWeight: FontWeight.w700)),

        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Column(
            children: [

               Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child:    SizedBox(
                  height: 60,
                  child: TextFormField(
                    onChanged: (val) {
                      setState(() {
                        isSearching = val.isNotEmpty;
                        _searchList = list.where((user) {
                          final name = user.name!.toLowerCase();
                          final searchLower = val.toLowerCase();
                          return name.contains(searchLower);
                        }).toList();
                      });
                    },
                    style: const TextStyle(
                        color: Colors.black, fontSize: 16, letterSpacing: 1),
                    cursorColor: Colors.black,
                    // autofocus: true,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.search,color: Colors.black,),
                      filled: true,
                        fillColor: Colors.white,
                        border: InputBorder.none,
                        hintText: 'Search People',
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide(
                            color: Colors.black.withOpacity(0.1),
                            width: 2, // Set the border width
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide(
                            color: Color(0xff004C6B).withOpacity(0.5),
                            width: 2, // Set the border width
                          ),
                        ),
                        hintStyle: TextStyle(color: Colors.black, fontSize: 16)),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),

              Expanded(
                child: Container(
                  width: screenWidth!,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.white,
                      style: BorderStyle.solid,
                      width: 10.0,
                    ),
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  child: StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('users')
                          .doc( FirebaseAuth.instance.currentUser!.email).snapshots(), // Update with your stream
                      builder: (context, snapshot) {

                        switch (snapshot.connectionState) {
                          case ConnectionState.waiting:
                          case ConnectionState.none:
                            return Center(
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 3,
                              ),
                            );

                          case ConnectionState.active:
                          case ConnectionState.done:

if ( snapshot.data!=null){

  try {

List temp = snapshot.data!['chats'];
temp.forEach((element) {
  list.add(AcceptedDateData.fromMap(element));
});
  } catch (e){

    // FirebaseFirestore.instance
    //     .collection('users')
    //     .doc( FirebaseAuth.instance.currentUser!.email).set({
    //   "email": FirebaseAuth.instance.currentUser!.email,
    //   "id": FirebaseAuth.instance.currentUser!.uid,
    //   "chats":[]
    //
    // });
  }


}
                            if (list.isNotEmpty || isSearching) {
                              // list.sort((a, b) {
                              //   final aTimestamp = a.timestamp ;
                              //   final bTimestamp = b.timestamp ;
                              //   return bTimestamp!.compareTo(aTimestamp!);
                              // });

                              return Column(
                                children: [

                                  Expanded(
                                    child: ListView.builder(
                                      shrinkWrap: true,
                                      padding: EdgeInsets.only(
                                        top: MediaQuery.of(context).size.height * .01,
                                      ),
                                      itemCount: isSearching ? _searchList.length : list.length,
                                      physics: BouncingScrollPhysics(),
                                      itemBuilder: (context, index) {
                                        // Reverse the index to show the latest message card at the top
                                        final reversedIndex = isSearching
                                            ? _searchList.length - 1 - index
                                            : list.length - 1 - index;
                                        return ChatUserCard(
                                          userData: isSearching
                                              ? _searchList[reversedIndex]
                                              : list[reversedIndex],
                                        );
                                      },
                                    ),


                                  ),
                                ],
                              );
                            } else {
                              return Center(
                                child: Container(
                                  height: 100,
                                  width: 100,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: Colors.white,
                                  ),
                                  child:   Text(
                                    'No Chat Found',
                                    style: GoogleFonts.openSans(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.black,
                                    ),
                                    textScaleFactor: 1.0,
                                  ),
                                ),
                              );
                            }
                        }
                      }),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

Stream<DocumentSnapshot<Map<String, dynamic>>> getAllChatStream()  {
  Stream<DocumentSnapshot<Map<String, dynamic>>> snapshots;
  dynamic temp;

  temp = FirebaseFirestore.instance
        .collection('users')
        .doc( FirebaseAuth.instance.currentUser!.email).get().onError((error, stackTrace) {
     FirebaseFirestore.instance
        .collection('users')
        .doc( FirebaseAuth.instance.currentUser!.email).update({
      "email": FirebaseAuth.instance.currentUser!.email,
      "id": FirebaseAuth.instance.currentUser!.uid,
      "chats":[]

    });
     return  FirebaseFirestore.instance
         .collection('users')
         .doc( FirebaseAuth.instance.currentUser!.email).get();
  });



  return  FirebaseFirestore.instance
      .collection('users')
      .doc( FirebaseAuth.instance.currentUser!.email).snapshots();
}


