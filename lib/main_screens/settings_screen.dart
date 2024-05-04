import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:inzone/constants.dart';
import 'package:inzone/main_screens/components/settings_tile.dart';
import 'package:inzone/main_screens/settings_screens/inzone_schedule.dart';
import 'package:inzone/main_screens/settings_screens/content_selection_screen.dart';
import 'package:inzone/main_screens/settings_screens/inzone_blockout_screen.dart';
import 'package:inzone/main_screens/settings_screens/user_details_screen.dart';
import 'package:inzone/welcome_screens/introduction_page.dart';
import 'package:url_launcher/url_launcher.dart';

import '../welcome_screens/content_selection_signup_screen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});
  Future<void> _launchInBrowser(String url) async {
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: false,
        forceWebView: false,
        headers: <String, String>{"header_key": "header_value"},
      );
    } else {
      throw "Could not launch $url";
    }
  }
  Future<void> _deleteAccount(BuildContext context) async {
    try {
      // Your logic to delete the account comes here
      // Example: Firebase Auth to delete the current user
      await FirebaseAuth.instance.currentUser?.delete();

      // After deleting the account, navigate to the introduction screen
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => IntroductionPage()),
      );
    } on FirebaseAuthException catch (e) {
      // If an error occurs, show the error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to delete the account: ${e.message}')),
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          elevation: 0,
          backgroundColor: backgroundColor,
          iconTheme: const IconThemeData(color: Colors.black),
          title: const Text(
            "Settings",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
      ),
      body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Settings",
                  style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  width: screenWidth! - 20,
                  decoration: BoxDecoration(
                      color: Colors.white, borderRadius: BorderRadius.circular(30)),
                  child: Column(children: [
                    SettingsTile(
                        title: "InZone Schedule",
                        imagePath: "assets/inzoneschedule.png",
                        onPressed: () {
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (context) {
                            return const InZoneSchedule();
                          }));
                        }),
                    SettingsTile(
                        title: "Content Selection",
                        imagePath: "assets/contentselection.png",
                        onPressed: () {
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (context) {
                            return ContentSelectionSignupScreen(newUser: false);
                          }));
                        }),
                    SettingsTile(
                        title: "Content BlockOut",
                        imagePath: "assets/contentblockout.png",
                        onPressed: () {
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (context) {
                            return const InZoneBlockOutScreen();
                          }));
                        }),

                  ]),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "Other Settings",
                  style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  width: screenWidth! - 20,
                  decoration: BoxDecoration(
                      color: Colors.white, borderRadius: BorderRadius.circular(30)),
                  child: Column(children: [
                    SettingsTile(
                        title: "Edit Profile",
                        imagePath: "assets/editprofile.png",
                        onPressed: () {
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (context) {
                            return const UserDetailScreen();
                          }));
                        }),

                    SettingsTile(
                        title: "Privacy Policy",
                        imagePath: "assets/privacypolicy.png",
                        onPressed: () {_launchInBrowser("https://www.inzone.ai/privacypolicy");}),
                    SettingsTile(
                        title: "Terms & Conditions",
                        imagePath: "assets/termsandconditions.png",
                        onPressed: () {_launchInBrowser(
                            "https://www.inzone.ai/terms-condition");}),
                    SettingsTile(
                        title: "Delete Account",
                        imagePath: "assets/deleteaccount.png",
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text('Delete Account'),
                                content: const Text('Are you sure you want to delete your account? This cannot be undone.'),
                                actions: <Widget>[
                                  TextButton(
                                    child: const Text('Cancel'),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                  TextButton(
                                    child: const Text('Delete'),
                                    onPressed: () {
                                      // Dismiss the dialog and then call the delete account method
                                      Navigator.of(context).pop();
                                      _deleteAccount(context);
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        }
                    ),
                    SettingsTile(
                        title: "Logout",
                        imagePath: "assets/logout.png",
                        onPressed: () {
                          FirebaseAuth.instance.signOut().then((value) {
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>IntroductionPage()));
                          });
                        }),
                  ]),
                ),
              ],
            ),
          )),
    );
  }
}

// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:inzone/constants.dart';
// import 'package:inzone/main_screens/components/settings_tile.dart';
// import 'package:url_launcher/url_launcher.dart';
// import 'package:inzone/main_screens/settings_screens/inzone_schedule.dart';
// import 'package:inzone/main_screens/settings_screens/content_selection_screen.dart';
// import 'package:inzone/main_screens/settings_screens/inzone_blockout_screen.dart';
// import 'package:inzone/main_screens/settings_screens/user_details_screen.dart';
// import 'package:inzone/welcome_screens/introduction_page.dart';
//
// class SettingsScreen extends StatefulWidget {
//   const SettingsScreen({super.key});
//
//   @override
//   State<SettingsScreen> createState() => _SettingsScreenState();
// }
//
// class _SettingsScreenState extends State<SettingsScreen> {
//   Future<void> _launchInBrowser(String url) async {
//     if (await canLaunch(url)) {
//       await launch(
//         url,
//         forceSafariVC: false,
//         forceWebView: false,
//         headers: <String, String>{"header_key": "header_value"},
//       );
//     } else {
//       throw "Could not launch $url";
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final FirebaseAuth _auth = FirebaseAuth.instance;
//     String _deleteMessage = '';
//
//     Future<void> _deleteAccount() async {
//       try {
//         await _auth.currentUser!.delete();
//         setState(() {
//           _deleteMessage = 'User account deleted successfully.';
//         });
//       } catch (error) {
//         setState(() {
//           _deleteMessage = 'Failed to delete user account: $error';
//         });
//       }
//     }
//
//     return Scaffold(
//         backgroundColor: backgroundColor,
//         appBar: PreferredSize(
//           preferredSize: const Size.fromHeight(60),
//           child: AppBar(
//             elevation: 0,
//             backgroundColor: backgroundColor,
//             leading: IconButton(
//               icon: Icon(Icons.arrow_back),
//               onPressed: () {
//                 Navigator.pop(context);
//               },
//             ),
//             title: const Text(
//               "Settings",
//               textAlign: TextAlign.center,
//               style: TextStyle(
//                 fontWeight: FontWeight.bold,
//                 color: Colors.black,
//               ),
//             ),
//           ),
//         ),
//         body: SafeArea(
//           child: Padding(
//             padding: const EdgeInsets.all(10.0),
//             child: Column(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   SettingsTile(
//                       title: "Privacy Policy",
//                       imagePath: "assets/p3.png",
//                       onPressed: () {
//                         _launchInBrowser("https://www.inzone.ai/privacypolicy");
//                       }),
//                   SettingsTile(
//                       title: "Terms & Conditions",
//                       imagePath: "assets/term.png",
//                       onPressed: () {
//                         _launchInBrowser(
//                             "https://www.inzone.ai/terms-condition");
//                       }),
//                   SettingsTile(
//                       title: "Delete Account",
//                       imagePath: "assets/p7.png",
//                       onPressed: () {
//                         _deleteAccount().whenComplete(() {
//                           Navigator.of(context)
//                               .push(MaterialPageRoute(builder: (context) {
//                             return IntroductionPage();
//                           }));
//                         });
//                       }),
//                   SettingsTile(
//                       title: "Logout",
//                       imagePath: "assets/p8.png",
//                       onPressed: () async {
//                         await FirebaseAuth.instance.signOut();
//                         Navigator.of(context)
//                             .push(MaterialPageRoute(builder: (context) {
//                           return const IntroductionPage();
//                         }));
//                       }),
//                 ]),
//           ),
//         ));
//   }
// }
