import 'dart:async';
import 'dart:io';

import 'package:action_slider/action_slider.dart';
import 'package:choice/choice.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:inzone/constants.dart';
import 'package:inzone/welcome_screens/introduction_page.dart';
import 'package:lottie/lottie.dart';

import '../custom_icons.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  bool isImageSelected = false;
  File? imageFile;
  bool submitted = false;
  bool isTyping = false;
  bool isEditingComplete = false;
  bool isPlaying = false;
  late Timer _timer;


  double maxWidth = 0.0;
  double maxMovable = 0.928;
  List<String> choices = [
    'News',
    'Entertainment',
    'Politics',
    'Automotive',
    'Sports',
  ];
  List<String> multipleSelected = [];

  void setMultipleSelected(List<String> value) {
    setState(() => multipleSelected = value);
  }

  _pickImagefromGallery() async {
    try {
      final pickedImage =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      if (pickedImage != null) {
        setState(() {
          imageFile = File(pickedImage.path);
          isImageSelected = true;
        });
      } else {
        print('User didnt pick any image.');
      }
    } catch (e) {
      print(e.toString());
    }
  }

  _pickImagefromCamera() async {
    try {
      final pickedImage =
          await ImagePicker().pickImage(source: ImageSource.camera);
      if (pickedImage != null) {
        setState(() {
          imageFile = File(pickedImage.path);
          isImageSelected = true;
        });
      } else {
        print('User didnt pick any image.');
      }
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
        duration: const Duration(seconds: 1),
        padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
        height: MediaQuery.of(context).size.height * 0.75,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Padding(
            padding: EdgeInsets.only(bottom: 20.0, left: 40.0, right: 30.0),
            child: Column(
              children: [
                SizedBox(
                    height: 300,
                    width: 300,
                  child: LottieBuilder.asset('assets/waiting.json'),

                   ),
                SizedBox(height: 30,),
                Text(
                    "You have been signed up for the waitlist for the full version.\n\nSit back and relax ;)", style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w500),),
              Spacer(),

                GestureDetector(
                    onTap: ()async {

                        await FirebaseAuth.instance.signOut();
                        Navigator.pushReplacement(
                            context, MaterialPageRoute(builder: (context) => IntroductionPage()));

                    },
                    child: Text("Sign Out", style: TextStyle(color: Colors.black, fontSize: 10, fontWeight: FontWeight.w500)))
              ],
            )
          ),
        ));
  }
}

//
//
//
// class PostScreen extends StatefulWidget {
//   const PostScreen({super.key});
//
//   @override
//   State<PostScreen> createState() => _PostScreenState();
// }
//
// class _PostScreenState extends State<PostScreen> {
//   bool isImageSelected = false;
//   File? imageFile;
//   _pickImagefromGallery() async {
//     try {
//       final pickedImage =
//           await ImagePicker().pickImage(source: ImageSource.gallery);
//       if (pickedImage != null) {
//         setState(() {
//           imageFile = File(pickedImage.path);
//           isImageSelected = true;
//         });
//       } else {
//         print('User didnt pick any image.');
//       }
//     } catch (e) {
//       print(e.toString());
//     }
//   }
//
//   _pickImagefromCamera() async {
//     try {
//       final pickedImage =
//           await ImagePicker().pickImage(source: ImageSource.camera);
//       if (pickedImage != null) {
//         setState(() {
//           imageFile = File(pickedImage.path);
//           isImageSelected = true;
//         });
//       } else {
//         print('User didnt pick any image.');
//       }
//     } catch (e) {
//       print(e.toString());
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: backgroundColor,
//       // appBar: AppBar(
//       //   elevation: 0,
//       //   backgroundColor: backgroundColor,
//       //   leading: IconButton(
//       //       onPressed: () {},
//       //       icon: const Icon(
//       //         Icons.highlight_remove_outlined,
//       //         color: Colors.grey,
//       //       )),
//       // ),
//       body: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: SingleChildScrollView(
//           child: Column(
//             children: [
//               TextField(
//                 maxLines: null, // Set maxLines to null for multiline
//                 decoration: InputDecoration(
//                   labelText: 'What do you want you talk about?',
//                   labelStyle: TextStyle(color: Colors.grey.shade900),
//                   border: InputBorder.none, // Remove the border
//                   contentPadding:
//                       EdgeInsets.only(bottom: 8.0), // Adjust padding as needed
//                 ),
//                 onEditingComplete: () {
//                   setState(() {
//                     isTyping = false;
//                   });
//                 },
//                 onSubmitted: (t) {
//                   setState(() {
//                     isTyping = false;
//                   });
//                 },
//                 onTapOutside: (t) {
//                   setState(() {
//                     isTyping = false;
//                   });
//                 },
//                 onTap: () {
//                   setState(() {
//                     isTyping = true;
//                   });
//                 },
//               ),
//               SizedBox(
//                 height: 40,
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 children: [
//                   imageFile == null
//                       ? const SizedBox(
//                           height: 100,
//                         )
//                       : ClipRRect(
//                           borderRadius: BorderRadius.circular(20.0),
//                           child: Image(
//                             height: 150,
//                             width: 150,
//                             fit: BoxFit.cover,
//                             image: FileImage(imageFile!),
//                           ),
//                         ),
//                 ],
//               ),
//               isTyping
//                   ? Container()
//                   : SizedBox(
//                       height: MediaQuery.of(context).size.height / 2.8,
//                     ),
//               Container(
//                 margin: const EdgeInsets.only(top: 0),
//                 padding: const EdgeInsets.only(top: 0, left: 10, right: 10),
//                 width: MediaQuery.of(context).size.width,
//                 height: MediaQuery.of(context).size.height - 200,
//                 decoration: BoxDecoration(
//                   borderRadius: const BorderRadius.only(
//                     topLeft:
//                         Radius.circular(40.0), // Adjust the radius as needed
//                     topRight: Radius.circular(40.0),
//                   ),
//                   color: isTyping ? Colors.white : backgroundColor,
//                 ),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   children: [
//                     isTyping
//                         ? Container()
//                         : Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                             children: [
//                               GestureDetector(
//                                   onTap: () {
//                                     _pickImagefromGallery();
//                                   },
//                                   child: Image.asset("icons/post_icons/0.png")),
//                               // Image.asset("icons/post_icons/1.png"),
//                               GestureDetector(
//                                   onTap: () {
//                                     _pickImagefromCamera();
//                                   },
//                                   child: Image.asset("icons/post_icons/2.png")),
//                             ],
//                           ),
//                     SizedBox(
//                       height: 10,
//                     ),
//                     !isTyping
//                         ? Container()
//                         : const Row(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               Text("Suggestions based on your InZone post"),
//                             ],
//                           ),
//                     Row(
//                       children: [
//                         !isTyping
//                             ? Container()
//                             : Container(
//                                 width: 80,
//                                 padding: const EdgeInsets.all(5),
//                                 margin:
//                                     const EdgeInsets.only(top: 10, bottom: 30),
//                                 decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(5),
//                                   color: backgroundColor,
//                                   boxShadow: [
//                                     const BoxShadow(
//                                       color: Colors.blue,
//                                       spreadRadius: 1,
//                                       blurRadius: 1,
//                                       offset: Offset(0,
//                                           2), // Changes the position of the shadow
//                                     ),
//                                   ],
//                                 ),
//                                 child: const Center(child: Text("sport")),
//                               ),
//                         SizedBox(
//                           width: 20,
//                         ),
//                         !isTyping
//                             ? Container()
//                             : Container(
//                                 width: 120,
//                                 padding: const EdgeInsets.all(5),
//                                 margin:
//                                     const EdgeInsets.only(top: 10, bottom: 30),
//                                 decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(5),
//                                   color: backgroundColor,
//                                   boxShadow: [
//                                     const BoxShadow(
//                                       color: Colors.blue,
//                                       spreadRadius: 1,
//                                       blurRadius: 1,
//                                       offset: Offset(0,
//                                           2), // Changes the position of the shadow
//                                     ),
//                                   ],
//                                 ),
//                                 child:
//                                     const Center(child: Text("entertainment")),
//                               ),
//                       ],
//                     ),
//                     SlideAction(
//                       sliderButtonIconPadding: 12,
//                       sliderRotate: false,
//                       outerColor: Colors.blue,
//                       text: "Drag to post",
//                       height: 80,
//                       elevation: 0,
//                       onSubmit: () {
//                         setState(() {
//                           submitted = true;
//                         });
//                       },
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
// }
