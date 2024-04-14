// import 'dart:async';
// import 'dart:io';
//
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:google_fonts/google_fonts.dart';
// import '../../constants.dart';
// import '../auth_work.dart';
// import '../chat_user_data.dart';
// import '../chat_widget/chat_user_card.dart';
//
// // Import your models, widgets, and other necessary files here
//
// class InboxScreen extends StatefulWidget {
//   const InboxScreen({Key? key}) : super(key: key);
//
//   @override
//   State<InboxScreen> createState() => _InboxScreenState();
// }
//
// class _InboxScreenState extends State<InboxScreen> {
//   // for storing user data
//   List<AcceptedDateData> list = [];
//
//   // for storing search item
//   final List<AcceptedDateData> _searchList = [];
//
//   // for storing search status
//   bool isSearching = false;
//   AuthWork? auth;
//   List<AcceptedDateData> userData = [];
//
//   String? datingMemberId;
//   String? datedMemberId;
//   late StreamSubscription subscription;
//   bool isDeviceConnected = false;
//   bool isAlertSet = false;
//
//   getData() async {
//     // if (user != null) {
//     QuerySnapshot res =
//         await FirebaseFirestore.instance.collection('newUser').get();
//     if (res.docs.isNotEmpty)
//       setState(() {
//         {
//           userData = res.docs
//               .map((e) =>
//                   AcceptedDateData.fromMap(e.data() as Map<String, dynamic>))
//               .toList();
//         }
//       });
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     SystemChannels.lifecycle.setMessageHandler((message) {
//       // Handle system lifecycle events here
//       return Future.value(message);
//     });
//     auth = AuthWork();
//     getData();
//   }
//
//   @override
//   void dispose() {
//     // TODO: implement dispose
//     super.dispose();
//     subscription.cancel();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: backgroundColor,
//       extendBodyBehindAppBar: true,
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         automaticallyImplyLeading: false,
//         leading: InkWell(
//           onTap: (){
//             Navigator.pop(context);
//           },
//             child: Icon(
//           Icons.arrow_back_ios_new,
//           color: Colors.black,
//         )),
//         actions: [
//           IconButton(
//             onPressed: () {
//               setState(() {
//                 isSearching = !isSearching;
//               });
//             },
//             icon: Icon(
//               isSearching
//                   ? CupertinoIcons.clear_circled_solid
//                   : CupertinoIcons.search,
//             ),
//           ),
//         ],
//         title: isSearching
//             ? TextFormField(
//                 onChanged: (val) {
//                   // search logic
//                   _searchList.clear();
//                   for (var i in list) {
//                     if (i.name!.toLowerCase().contains(val.toLowerCase())) {
//                       _searchList.add(i);
//                     }
//                   }
//                   setState(() {
//                     _searchList;
//                   });
//                 },
//                 style: TextStyle(
//                     color: Colors.white, fontSize: 16, letterSpacing: 1),
//                 cursorColor: Colors.black,
//                 autofocus: true,
//                 decoration: InputDecoration(
//                     border: InputBorder.none,
//                     hintText: 'Search People',
//                     hintStyle: TextStyle(color: Colors.black, fontSize: 16)),
//               )
//             : Text(
//                 'Chat',
//                 style: GoogleFonts.montserrat(
//                   fontSize: 24,
//                   fontWeight: FontWeight.w500,
//                   color: Colors.black,
//                 ),
//                 textScaleFactor: 1.0,
//               ),
//       ),
//       body: Center(
//         child: DecoratedBox(
//           decoration: BoxDecoration(
//             image: DecorationImage(
//               image: AssetImage("assets/images/bg.jpg"),
//               opacity: 0.8,
//               fit: BoxFit.cover,
//             ),
//           ),
//           child:StreamBuilder(
//               stream: FirebaseFirestore.instance
//                   .collection('user')
//                   .where('email',
//                   isNotEqualTo: FirebaseAuth.instance.currentUser!.email)
//                   .snapshots(), // Update with your stream
//               builder: (context, snapshot) {
//                 switch (snapshot.connectionState) {
//                   case ConnectionState.waiting:
//                   case ConnectionState.none:
//                     return Center(
//                       child: CircularProgressIndicator(
//                         color: Colors.white,
//                         strokeWidth: 3,
//                       ),
//                     );
//
//                   case ConnectionState.active:
//                   case ConnectionState.done:
//                     final data = snapshot.data?.docs;
//
//                     list = data?.map((e) {
//                       final userData = AcceptedDateData.fromMap(e.data());
//                       return userData;
//                     }).toList() ??
//                         [];
//
//                     if (list.isNotEmpty) {
//                       // list.sort((a, b) {
//                       //   final aTimestamp = a.timestamp ;
//                       //   final bTimestamp = b.timestamp ;
//                       //   return bTimestamp!.compareTo(aTimestamp!);
//                       // });
//
//                       return Container(
//                         child: Column(
//                           children: [
//                             SizedBox(
//                               height: 100,
//                             ),
//                             Expanded(
//                               child: ListView.builder(
//                                 shrinkWrap: true,
//                                 padding: EdgeInsets.only(
//                                   top: MediaQuery.of(context).size.height * .01,
//                                 ),
//                                 itemCount: isSearching
//                                     ? _searchList.length
//                                     : list.length,
//                                 physics: BouncingScrollPhysics(),
//                                 itemBuilder: (context, index) {
//                                   // Reverse the index to show the latest message card at the top
//                                   final reversedIndex = isSearching
//                                       ? _searchList.length - 1 - index
//                                       : list.length - 1 - index;
//                                   return ChatUserCard(
//                                     userData: isSearching
//                                         ? _searchList[reversedIndex]
//                                         : list[reversedIndex],
//                                   );
//                                 },
//                               ),
//
//                               // ListView.builder(
//                               //     shrinkWrap: true,
//                               //     padding: EdgeInsets.only(
//                               //         top: MediaQuery.of(context)
//                               //                 .size
//                               //                 .height *
//                               //             .01),
//                               //     itemCount: isSearching
//                               //         ? _searchList.length
//                               //         : list.length,
//                               //     physics: BouncingScrollPhysics(),
//                               //     itemBuilder: (context, index) {
//                               //       return ChatUserCard(
//                               //         userData: isSearching
//                               //             ? _searchList[index]
//                               //             : list[index],
//                               //       );
//                               //     }),
//                             ),
//                           ],
//                         ),
//                       );
//                     } else {
//                       return Center(
//                         child: Container(
//                           height: 100,
//                           width: 100,
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(15),
//                             color: Colors.white,
//                           ),
//                           child: Column(
//                             children: [
//                               SizedBox(
//                                 height: 20,
//                               ),
//
//                               SizedBox(
//                                 height: 20,
//                               ),
//                               Text(
//                                 'No Chat Found',
//                                 style: GoogleFonts.openSans(
//                                   fontSize: 20,
//                                   fontWeight: FontWeight.w700,
//                                   color: Colors.black,
//                                 ),
//                                 textScaleFactor: 1.0,
//                               ),
//                             ],
//                           ),
//                         ),
//                       );
//                     }
//                 }
//               }),
//         ),
//       ),
//     );
//   }
// }
