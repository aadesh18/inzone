// import 'package:flutter/material.dart';
// import 'package:inzone/constants.dart';
// import 'package:inzone/main_screens/components/settings_tile.dart';
// import 'package:inzone/main_screens/settings_screens/inzone_schedule.dart';
// import 'package:inzone/main_screens/settings_screens/content_selection_screen.dart';
// import 'package:inzone/main_screens/settings_screens/inzone_blockout_screen.dart';
// import 'package:inzone/main_screens/settings_screens/user_details_screen.dart';
//
// class SettingsScreen extends StatelessWidget {
//   const SettingsScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: backgroundColor,
//       appBar: PreferredSize(
//         preferredSize: const Size.fromHeight(60),
//         child: AppBar(
//           elevation: 0,
//           backgroundColor: backgroundColor,
//           iconTheme: const IconThemeData(color: Colors.black),
//           title: const Text(
//             "Settings",
//             textAlign: TextAlign.center,
//             style: TextStyle(
//               fontWeight: FontWeight.bold,
//               color: Colors.black,
//             ),
//           ),
//         ),
//       ),
//       body: SafeArea(
//           child: Padding(
//         padding: const EdgeInsets.all(10.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.start,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const Text(
//               "Settings",
//               style:
//                   TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(
//               height: 10,
//             ),
//             Container(
//               width: screenWidth! - 20,
//               decoration: BoxDecoration(
//                   color: Colors.white, borderRadius: BorderRadius.circular(30)),
//               child: Column(children: [
//                 SettingsTile(
//                     title: "InZone Schedule",
//                     imagePath: "images/sample_avatar_1.png",
//                     onPressed: () {
//                       Navigator.of(context)
//                           .push(MaterialPageRoute(builder: (context) {
//                         return const InZoneSchedule();
//                       }));
//                     }),
//                 SettingsTile(
//                     title: "Content Selection",
//                     imagePath: "images/sample_avatar_1.png",
//                     onPressed: () {
//                       Navigator.of(context)
//                           .push(MaterialPageRoute(builder: (context) {
//                         return const ContentSelectionScreen();
//                       }));
//                     }),
//                 SettingsTile(
//                     title: "Content BlockOut",
//                     imagePath: "images/sample_avatar_1.png",
//                     onPressed: () {
//                       Navigator.of(context)
//                           .push(MaterialPageRoute(builder: (context) {
//                         return const InZoneBlockOutScreen();
//                       }));
//                     }),
//                 SettingsTile(
//                     title: "Your Feed",
//                     imagePath: "images/sample_avatar_1.png",
//                     onPressed: () {}),
//               ]),
//             ),
//             const SizedBox(
//               height: 10,
//             ),
//             const Text(
//               "Other Settings",
//               style:
//                   TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(
//               height: 10,
//             ),
//             Container(
//               width: screenWidth! - 20,
//               decoration: BoxDecoration(
//                   color: Colors.white, borderRadius: BorderRadius.circular(30)),
//               child: Column(children: [
//                 SettingsTile(
//                     title: "Edit Profile",
//                     imagePath: "images/sample_avatar_1.png",
//                     onPressed: () {
//                       Navigator.of(context)
//                           .push(MaterialPageRoute(builder: (context) {
//                         return const UserDetailScreen();
//                       }));
//                     }),
//                 SettingsTile(
//                     title: "Help & Support",
//                     imagePath: "images/sample_avatar_1.png",
//                     onPressed: () {}),
//                 SettingsTile(
//                     title: "Privacy Policy",
//                     imagePath: "images/sample_avatar_1.png",
//                     onPressed: () {}),
//                 SettingsTile(
//                     title: "Terms & Conditions",
//                     imagePath: "images/sample_avatar_1.png",
//                     onPressed: () {}),
//                 SettingsTile(
//                     title: "Delete Account",
//                     imagePath: "images/sample_avatar_1.png",
//                     onPressed: () {}),
//                 SettingsTile(
//                     title: "Logout",
//                     imagePath: "images/sample_avatar_1.png",
//                     onPressed: () {}),
//               ]),
//             ),
//           ],
//         ),
//       )),
//     );
//   }
// }
