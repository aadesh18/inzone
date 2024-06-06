import 'dart:async';
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:video_player/video_player.dart';
import 'package:action_slider/action_slider.dart';
import 'package:choice/choice.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:inzone/backend/database.dart';
import 'package:inzone/constants.dart';
import 'package:inzone/models/auth_work.dart';
import 'package:inzone/models/chat_user_data.dart';
import 'package:inzone/welcome_screens/introduction_page.dart';
import 'package:lottie/lottie.dart';
import 'dart:async';
import 'dart:io';
import 'package:action_slider/action_slider.dart';
import 'package:choice/choice.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:inzone/constants.dart';
import 'package:lottie/lottie.dart';

import '../custom_icons.dart';
import '../models/chat_widget/messege_card.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  bool isImageSelected = false;
  bool doesNotWork = false;
  File? imageFile;
  bool submitted = false;
  bool isTyping = false;
  bool isEditingComplete = false;
  bool isPlaying = false;
  String postContent = "";
  double moveValue = 0.928;
  bool isUploading = false;

  double high = 0.928;
  double medium = 0.8;
  double low = 0.4;
  late Timer _timer;
  String imageUrl = "";
  String videoUrl = "";
  String thumbnailUrl = "";

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
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        child: Scaffold(
          backgroundColor: backgroundColor,
          // appBar: AppBar(
          //   elevation: 0,
          //   backgroundColor: backgroundColor,
          //   leading: IconButton(
          //       onPressed: () {},
          //       icon: const Icon(
          //         Icons.highlight_remove_outlined,
          //         color: Colors.grey,
          //       )),
          // ),
          body: Padding(
            padding: const EdgeInsets.only(bottom: 8.0, left: 8.0, right: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 6.0, right: 6.0, top: 6.0,),
                  child: Center(
                    child: Text(

                      doesNotWork ? "Please rephrase. Your message violates our guideline.":"Your post works well with InZone guidelines",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: doesNotWork ? Colors.red : Colors.blue,
                          fontSize: 12,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ),

                Container(
                  width: screenWidth,
                  height: 30,
                  child: Stack(
                    alignment: AlignmentDirectional.centerStart,
                    children: [
                      LayoutBuilder(builder:
                          (BuildContext context,
                          BoxConstraints constraints) {
                        maxWidth = constraints.maxWidth;
                        return Container(
                          height: 14,
                          width: double.infinity,
                          margin: const EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            borderRadius:
                            BorderRadius.circular(30),
                            gradient: const LinearGradient(
                              colors: [
                                Color(0xffff8d6c),
                                Color(0xffe064f7),
                                Color(0xff00b2e7)
                              ],
                            ),
                          ),
                          // transform:  (Matrix4.identity() + Matrix4.rotationZ(math.pi / 4))
                        );
                      }),
                      AnimatedContainer(
                        height: 14,
                        width: 16,
                        margin: EdgeInsets.only(
                            left: maxWidth * maxMovable * moveValue),
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: backgroundColor),
                            borderRadius:
                            BorderRadius.circular(30),
                            color: Colors.white),
                        duration: const Duration(seconds: 1),
                        // transform:  (Matrix4.identity() + Matrix4.rotationZ(math.pi / 4))
                      ),
                    ],
                  ),
                ),


                //
                // SlideAction(
                //   sliderButtonIconPadding: 6,
                //   sliderRotate: false,
                //   outerColor: Colors.blue,
                //   text: "Post to InZone",
                //   height: 60,
                //   elevation: 0,
                //   onSubmit: () {
                //     setState(() {
                //       submitted = true;
                //     });
                //   },
                // ),
                // PostSlider(
                //     afterSlideText: "Post Successful",
                //     beforeSlideText: "Post to InZone"),
                // SizedBox(
                //   height: 5,
                // ),

                //  const Divider(),
                SizedBox(height: 10,),
                TextField(
                  maxLines: 3, // Set maxLines to null for multiline
                  textInputAction: TextInputAction.send,
                  decoration: InputDecoration(
                    // labelText: 'What do you want you talk about?',
                    //
                    // labelStyle: TextStyle(color: Colors.grey.shade900),
                    hintText: 'What do you want to talk about ?',

                    hintStyle: TextStyle(color: Colors.grey.shade900),

                    border: InputBorder.none, // Remove the border
                    contentPadding: const EdgeInsets.only(
                        bottom: 8.0), // Adjust padding as needed
                  ),
                  onChanged: (value){
                    setState(() {
                      postContent = value;
                    });

                  },
                  onEditingComplete: () {
                    setState(() {
                      isTyping = false;

                    });
                  },
                  onSubmitted: (t) {
                    setState(() {
                      submitted = true;
                    });
                  },
                  onTapOutside: (t) {
                    setState(() {
                      isTyping = true;
                    });
                  },
                  onTap: () {
                    setState(() {

                      isTyping = true;
                    });
                  },
                ),
                const SizedBox(height: 2,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      onPressed: () async {
                        final ImagePicker _picker = ImagePicker();
                        // Pick an image
                        final XFile? image = await _picker.pickImage(
                            source: ImageSource.gallery, imageQuality: 90);
                        if (image != null) {
                          // setState(() {
                          //   _img = image.path;
                          // });
                          //upload image
                          setState(() {
                            isUploading = true;
                          });
                          await AuthWork.sendPostImage(FirebaseAuth.instance.currentUser!.uid , File(image.path)).then((value) {
                            imageUrl = value;
                          });
                          // Navigator.pop(context);
                          setState(() {
                            isUploading = false;
                          });
                        }
                      },
                      icon: Icon(
                        Icons.image,
                        color: Colors.blue,
                        size: 28,
                      ),
                    ),

                    IconButton(
                      onPressed: () async {
                        final ImagePicker _picker = ImagePicker();
                        // Pick a video
                        final XFile? video = await _picker.pickVideo(
                            source: ImageSource.gallery, maxDuration: Duration(minutes: 5));
                        if (video != null) {
                          setState(() {
                            isUploading = true;
                          });
                          await AuthWork.sendPostVideo(FirebaseAuth.instance.currentUser!.uid , File(video.path)).then((value){
                            videoUrl = value["videoUrl"]!;
                            thumbnailUrl = value["thumbnailUrl"]!;
                          });
                          setState(() {
                            isUploading = false;
                          });
                        }
                      },
                      icon: Icon(
                        Icons.switch_video_outlined,
                        color: Colors.blue,
                        size: 28,
                      ),
                    ),


                    IconButton(
                      onPressed: () async {
                        final ImagePicker _picker = ImagePicker();
                        // Pick an image
                        final XFile? image = await _picker.pickImage(
                            source: ImageSource.camera, imageQuality: 90);
                        if (image != null) {
                          // setState(() {
                          //   _img = image.path;
                          // });
                          //upload image
                          setState(() {
                            isUploading = true;
                          });
                          await AuthWork.sendPostImage(FirebaseAuth.instance.currentUser!.uid , File(image.path)).then((value) {
                            imageUrl = value;
                          });
                          // Navigator.pop(context);
                          setState(() {
                            isUploading = false;
                          });
                        }
                      },
                      icon: Icon(
                        Icons.camera_alt_rounded,
                        color: Colors.blue,
                        size: 28,
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 2,),
                // Images
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    imageUrl == ""
                        ? const SizedBox(
                      height: 5,
                    )
                        : Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20.0),
                        child: Image(
                          height: 140,
                          width: 140,
                          fit: BoxFit.cover,
                          image: NetworkImage(imageUrl),
                        ),
                      ),
                    ),
                    videoUrl == ""
                        ? const SizedBox(
                      height: 5,
                    )
                        : Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20.0),
                        child: InkWell(
                          onTap: () {
                            // Play video
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => VideoPlayerWidget(
                                    videoUrl),
                              ),
                            );
                          },
                          child: Stack(
                            children: [
                              CachedNetworkImage(
                                height: 140,
                                width: 140,
                                fit: BoxFit.fill,
                                imageUrl: "${thumbnailUrl}",
                                placeholder: (context, url) => Center(
                                    child: CircularProgressIndicator()),
                                errorWidget: (context, url, error) => SizedBox()

                              ),
                              Positioned.fill(
                                child: Center(
                                  child: Icon(Icons.play_arrow,
                                      size: 50, color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        )
                      ),
                    ),
                  ],
                ),
                // isTyping
                //     ? Container()
                //     : SizedBox(
                //   height: MediaQuery.of(context).size.height / 2.8,
                // ),

                // const  Divider(),



                // const  Text(
                //            "Suggestions based on your InZone post"),
                //
                //
                //
                //      SingleChildScrollView(
                //          child: InlineChoice(
                //            multiple: true,
                //            clearable: true,
                //            value: multipleSelected,
                //            onChanged: setMultipleSelected,
                //            itemCount: choices.length,
                //            itemBuilder: (selection, i) {
                //              return ChoiceChip(
                //                color:
                //                MaterialStateProperty.resolveWith(
                //                        (states) {
                //                      if (states.contains(
                //                          MaterialState.selected)) {
                //                        return backgroundColor;
                //                      }
                //                      return Colors.white;
                //                    }),
                //                selected:
                //                selection.selected(choices[i]),
                //                onSelected:
                //                selection.onSelected(choices[i]),
                //                label: Text(choices[i]),
                //              );
                //            },
                //            listBuilder: ChoiceList.createWrapped(
                //              spacing: 10,
                //              runSpacing: 10,
                //              padding: const EdgeInsets.symmetric(
                //                horizontal: 20,
                //                vertical: 25,
                //              ),
                //            ),
                //          ),
                //        ),

                //
                // isTyping
                //     ? Container(
                //   margin: const EdgeInsets.only(top: 0),
                //   padding: const EdgeInsets.only(
                //       top: 0, left: 10, right: 10),
                //   width: MediaQuery.of(context).size.width,
                //   height: 250,
                //   decoration: BoxDecoration(
                //     borderRadius:
                //     const BorderRadius.all(Radius.circular(40.0)),
                //     color: isTyping ? Colors.white : backgroundColor,
                //   ),
                //   child: Column(
                //     crossAxisAlignment: CrossAxisAlignment.center,
                //     mainAxisAlignment: MainAxisAlignment.start,
                //     children: [
                //       const SizedBox(
                //         height: 10,
                //       ),
                //       const Flexible(
                //         flex: 1,
                //         child: Text(
                //             "Suggestions based on your InZone post"),
                //       ),
                //
                //       // TODO: Replace the row with ListView.builder
                //
                //       Flexible(
                //         flex: 5,
                //         child: SingleChildScrollView(
                //           child: InlineChoice(
                //             multiple: true,
                //             clearable: true,
                //             value: multipleSelected,
                //             onChanged: setMultipleSelected,
                //             itemCount: choices.length,
                //             itemBuilder: (selection, i) {
                //               return ChoiceChip(
                //                 color:
                //                 MaterialStateProperty.resolveWith(
                //                         (states) {
                //                       if (states.contains(
                //                           MaterialState.selected)) {
                //                         return backgroundColor;
                //                       }
                //                       return Colors.white;
                //                     }),
                //                 selected:
                //                 selection.selected(choices[i]),
                //                 onSelected:
                //                 selection.onSelected(choices[i]),
                //                 label: Text(choices[i]),
                //               );
                //             },
                //             listBuilder: ChoiceList.createWrapped(
                //               spacing: 10,
                //               runSpacing: 10,
                //               padding: const EdgeInsets.symmetric(
                //                 horizontal: 20,
                //                 vertical: 25,
                //               ),
                //             ),
                //           ),
                //         ),
                //       ),
                //
                //
                //
                //     ],
                //   ),
                // )
                //     : const SizedBox(),

                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //   children: [
                //     GestureDetector(
                //       onTap: () {
                //         _pickImagefromGallery();
                //       },
                //       child: Container(
                //         height: 70,
                //         width: 70,
                //         decoration: BoxDecoration(
                //             borderRadius: BorderRadius.circular(15),
                //             color: Colors.white,
                //             boxShadow: const [
                //               BoxShadow(
                //                   color: Color(0xffe064f7),
                //                   blurRadius: 1.0,
                //                   spreadRadius: 1.0,
                //                   offset: Offset(1, 1))
                //             ]),
                //         child: Column(
                //           mainAxisAlignment: MainAxisAlignment.center,
                //           children: [
                //             SvgPicture.asset("assets/picture_icon.svg"),
                //             const SizedBox(height: 5),
                //             const Text(
                //               "Image",
                //               style: TextStyle(
                //                   color: Colors.black,
                //                   fontWeight: FontWeight.w700,
                //                   fontSize: 14),
                //             )
                //           ],
                //         ),
                //       ),
                //     ),
                //     Container(
                //       height: 70,
                //       width: 70,
                //       decoration: BoxDecoration(
                //           borderRadius: BorderRadius.circular(15),
                //           color: Colors.white,
                //           boxShadow: const [
                //             BoxShadow(
                //                 color: Color(0xff00b2e7),
                //                 blurRadius: 1.0,
                //                 spreadRadius: 1.0,
                //                 offset: Offset(1, 1))
                //           ]),
                //       child: Column(
                //         mainAxisAlignment: MainAxisAlignment.center,
                //         children: [
                //           SvgPicture.asset("assets/link_icon.svg"),
                //           const SizedBox(height: 5),
                //           const Text(
                //             "Link",
                //             style: TextStyle(
                //                 color: Colors.black,
                //                 fontWeight: FontWeight.w700,
                //                 fontSize: 14),
                //           )
                //         ],
                //       ),
                //     ),
                //
                //     // Image.asset("icons/post_icons/1.png"),
                //   ],
                // ),

                Spacer(flex: 3,),

                Container(
                  width: double.infinity,


                  child: ActionSlider.standard(
                    rolling: false,
                    backgroundColor: Colors.blue,
                    toggleColor: Colors.white,
                    sliderBehavior: SliderBehavior.stretch,
                    child: const Text(
                      'Post to InZone',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                          fontSize: 23),
                    ),
                    action: (controller)  async {

                      controller.loading(); //starts loading animation
                      //     await Future.delayed(const Duration(seconds: 2));
                      await InZoneDatabase.postContent(postMessage: postContent, imageRef: [imageUrl], videoRef: [videoUrl]).then((value) {
                        setState(() {
                          print(value);
                          if (value == -1){
                            moveValue = low;
                            doesNotWork = true;
                            controller.reset();
                          } else if (value == 0){
                            moveValue = medium;
                            doesNotWork = false;
                          } else if (value == 1){
                            moveValue = high;
                            doesNotWork = false;

                          } else {
                            moveValue = low;
                            doesNotWork = true;
                            controller.reset();
                          }
                        });
                      });

                      if (doesNotWork == false){
                        controller.success();
                        Navigator.pop(context);

                        showDialog(
                            context: context,
                            builder: (_) {
                              _timer = Timer(const Duration(seconds: 1), () {
                                Navigator.of(_).pop();

                              });
                              return Dialog(
                                backgroundColor: Colors.transparent,
                                child:  Stack(
                                  children: [
                                    RotatedBox(quarterTurns: 2, child: SizedBox(height:MediaQuery.of(context).size.height, width:MediaQuery.of(context).size.width, child: Lottie.asset(CustomIcons.confettiAnimation)),),
                                    const Align(
                                        alignment: Alignment.center,
                                        child: Text("Post Sucessful", style: TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.w400),))
                                  ],
                                ),
                              );
                            }
                        ).then((value) {
                          if (_timer.isActive) {
                            _timer.cancel();
                          }
                        });

                        //starts success animation
                      }



                    },
                  ),
                ),
Spacer(flex: 1,),
              ],
            ),
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
//   bool submitted = false;
//   bool isTyping = false;
//   bool isEditingComplete = false;
//   bool isPlaying = false;
//   late Timer _timer;
//
//
//   double maxWidth = 0.0;
//   double maxMovable = 0.928;
//   List<String> choices = [
//     'News',
//     'Entertainment',
//     'Politics',
//     'Automotive',
//     'Sports',
//   ];
//   List<String> multipleSelected = [];
//
//   void setMultipleSelected(List<String> value) {
//     setState(() => multipleSelected = value);
//   }
//
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
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//
//   }
//   @override
//   void dispose() {
//     // TODO: implement dispose
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return AnimatedContainer(
//         duration: const Duration(seconds: 1),
//         padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
//         height: MediaQuery.of(context).size.height * 0.75,
//         width: MediaQuery.of(context).size.width,
//         decoration: const BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.only(
//                 topLeft: Radius.circular(20), topRight: Radius.circular(20))),
//         child: Scaffold(
//           backgroundColor: Colors.white,
//           body: Padding(
//             padding: EdgeInsets.only(bottom: 20.0, left: 40.0, right: 30.0),
//             child: Column(
//               children: [
//                 SizedBox(
//                     height: 300,
//                     width: 300,
//                   child: LottieBuilder.asset('assets/waiting.json'),
//
//                    ),
//                 SizedBox(height: 30,),
//                 Text(
//                     "You have been signed up for the waitlist for the full version.\n\nSit back and relax ;)", style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w500),),
//               Spacer(),
//
//                 GestureDetector(
//                     onTap: ()async {
//
//                         await FirebaseAuth.instance.signOut();
//                         Navigator.pushReplacement(
//                             context, MaterialPageRoute(builder: (context) => IntroductionPage()));
//
//                     },
//                     child: Text("Sign Out", style: TextStyle(color: Colors.black, fontSize: 10, fontWeight: FontWeight.w500)))
//               ],
//             )
//           ),
//         ));
//   }
// }

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





class VideoWidget extends StatefulWidget {
  final String videoUrl;

  const VideoWidget({Key? key, required this.videoUrl}) : super(key: key);

  @override
  _VideoWidgetState createState() => _VideoWidgetState();
}

class _VideoWidgetState extends State<VideoWidget> {
  late VideoPlayerController _controller;
  bool _isPlaying = false;
  bool _isBuffering = true;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.videoUrl)
      ..addListener(() {
        final bool isBuffering = _controller.value.isBuffering;
        if (_isBuffering != isBuffering) {
          setState(() {
            _isBuffering = isBuffering;
          });
        }
      })
      ..initialize().then((_) {
        setState(() {
          _isBuffering = false;
        });
        // Optionally play the video automatically
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _controller.value.isInitialized
        ? Stack(
      alignment: Alignment.center,
      children: [
        AspectRatio(
          aspectRatio: _controller.value.aspectRatio,
          child: VideoPlayer(_controller),
        ),
        if (_isBuffering)
          const CircularProgressIndicator(),
        IconButton(
          icon: Icon(
            _isPlaying ? Icons.pause : Icons.play_arrow,
            color: Colors.white,
          ),
          onPressed: () {
            setState(() {
              _isPlaying
                  ? _controller.pause()
                  : _controller.play();
              _isPlaying = !_isPlaying;
            });
          },
        ),
      ],
    )
        : const Center(
      child: CircularProgressIndicator(),
    );
  }
}
