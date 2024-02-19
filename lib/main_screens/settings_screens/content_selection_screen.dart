// import 'package:flutter_slidable/flutter_slidable.dart';
// import 'package:flutter/material.dart';
// import 'package:inzone/constants.dart';
//
// class ContentSelectionScreen extends StatefulWidget {
//   const ContentSelectionScreen({super.key});
//
//   @override
//   State<ContentSelectionScreen> createState() => _ContentSelectionScreenState();
// }
//
// class _ContentSelectionScreenState extends State<ContentSelectionScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: backgroundColor,
//       body: Column(
//         children: [
//           const SizedBox(
//               width: 358,
//               height: 80,
//               child: Text(
//                   "Swipe Low visibility and High visibility content in each mode of your choice.",
//                   textAlign: TextAlign.center,
//                   style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500))),
//           Expanded(
//             child: Container(
//               decoration: const BoxDecoration(
//                 borderRadius:  BorderRadius.only(
//                   topLeft: Radius.circular(40.0), // Adjust the radius as needed
//                   topRight: Radius.circular(40.0),
//                 ),
//                 color: Colors.white,
//               ),
//               child: Column(
//                 children: [
//                   Container(
//                       margin: const EdgeInsets.only(top: 30, bottom: 25),
//                       child: const Text(
//                         "Fall Back",
//                         style: TextStyle(
//                             fontSize: 30, fontWeight: FontWeight.w800),
//                       )),
//                   Expanded(
//                     child: ListView.builder(
//                       itemCount: contentList.length,
//                       itemBuilder: (BuildContext context, int index) {
//                         return Slidable(
//                           key: Key('$index'),
//
//                           startActionPane: ActionPane(
//                             // A motion is a widget used to control how the pane animates.
//                             extentRatio: 0.2,
//                             motion: const ScrollMotion(),
//
//                             children: [
//                               // A SlidableAction can have an icon and/or a label.
//                               Image.asset("icons/content_icons/low.png")
//                             ],
//                           ),
//
//                           // The end action pane is the one at the right or the bottom side.
//                           endActionPane: ActionPane(
//                             extentRatio: 0.2,
//                             motion: const ScrollMotion(),
//                             children: [
//                               Image.asset("icons/content_icons/high.png"),
//                             ],
//                           ),
//                           child: SizedBox(
//                             height: index != contentList.length - 1 ? 60 : 100,
//                             child: Stack(
//                               children: [
//                                 Expanded(
//                                   child: Container(
//                                     margin: const EdgeInsets.only(
//                                         left: 10, right: 10, bottom: 5, top: 5),
//                                     decoration: BoxDecoration(
//                                       borderRadius: BorderRadius.circular(10.0),
//                                       color: Colors.white,
//                                       // border: Border(
//                                       //     top: BorderSide(
//                                       //         color: backgroundColor)
//                                       //         ),
//                                       boxShadow: [
//                                         BoxShadow(
//                                           color:
//                                               backgroundColor.withOpacity(0.5),
//                                           spreadRadius: 3,
//                                           blurRadius: 1,
//                                           offset: const Offset(0,
//                                               3), // Changes the position of the shadow
//                                         ),
//                                       ],
//                                     ),
//                                     child: ListTile(
//                                       title: Text(contentList[index].tittle,
//                                           style: const TextStyle(
//                                               fontSize: 16,
//                                               fontWeight: FontWeight.w700)),
//                                       leading: Image.asset(
//                                           "${contentList[index].iconPath}/$index.png"),
//                                     ),
//                                   ),
//                                 ),
//                                 index != contentList.length - 1
//                                     ? Container()
//                                     : GestureDetector(
//                                         onTap: () {
//                                           // Navigator.push(context, MaterialPageRoute(builder: (context)=>const UserDetail()));
//                                         },
//                                         child: Align(
//                                             alignment: Alignment.bottomCenter,
//                                             child: Image.asset(
//                                                 "icons/content_icons/next.png")),
//                                       ),
//                               ],
//                             ),
//                           ),
//                         );
//                       },
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
class ContentModel {
  final String tittle;
  final String iconPath;

  ContentModel({required this.tittle, required this.iconPath});
}

List<ContentModel> focusContentList = [
  ContentModel(tittle: 'environmental_conservation', iconPath: 'icons/content_icons'),
  ContentModel(tittle: 'bullying_prevention', iconPath: 'icons/content_icons'),
  ContentModel(
      tittle: 'mental_health', iconPath: 'icons/content_icons'),
  ContentModel(tittle: 'inclusivity', iconPath: 'icons/content_icons'),
  ContentModel(tittle: 'anti_discrimination', iconPath: 'icons/content_icons'),
  ContentModel(tittle: 'healthy_habits', iconPath: 'icons/content_icons'),
  ContentModel(tittle: 'community_service', iconPath: 'icons/content_icons'),
  ContentModel(tittle: 'creativity', iconPath: 'icons/content_icons'),
  ContentModel(tittle: 'science', iconPath: 'icons/content_icons'),
];


List<ContentModel> fallbackContentList = [
  ContentModel(tittle: 'funny_memes', iconPath: 'icons/content_icons'),
  ContentModel(tittle: 'diy', iconPath: 'icons/content_icons'),
  ContentModel(
      tittle: 'video_game_reviews', iconPath: 'icons/content_icons'),
  ContentModel(tittle: 'animated_movies', iconPath: 'icons/content_icons'),
  ContentModel(tittle: 'challenge_videos', iconPath: 'icons/content_icons'),
  ContentModel(tittle: 'cooking', iconPath: 'icons/content_icons'),
  ContentModel(tittle: 'animals', iconPath: 'icons/content_icons'),
  ContentModel(tittle: 'magic_tricks', iconPath: 'icons/content_icons'),
  ContentModel(tittle: 'board_games', iconPath: 'icons/content_icons'),
  ContentModel(tittle: 'art', iconPath: 'icons/content_icons'),
];


List<ContentModel> customContentList = [
  ContentModel(tittle: 'dance', iconPath: 'icons/content_icons'),
  ContentModel(tittle: 'outdoor_adventures', iconPath: 'icons/content_icons'),
  ContentModel(
      tittle: 'music', iconPath: 'icons/content_icons'),
  ContentModel(tittle: 'books', iconPath: 'icons/content_icons'),
  ContentModel(tittle: 'travel', iconPath: 'icons/content_icons'),
  ContentModel(tittle: 'lego', iconPath: 'icons/content_icons'),
  ContentModel(tittle: 'fashion', iconPath: 'icons/content_icons'),
  ContentModel(tittle: 'financial_literacy', iconPath: 'icons/content_icons'),
  ContentModel(tittle: 'empowerment', iconPath: 'icons/content_icons'),
  ContentModel(tittle: 'friendship', iconPath: 'icons/content_icons'),
];
