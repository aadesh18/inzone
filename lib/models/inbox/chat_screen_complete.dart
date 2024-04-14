import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:inzone/constants.dart';
import 'package:inzone/models/chat_widget/messege_card.dart';
import 'package:inzone/models/messege.dart';
import 'package:random_avatar/random_avatar.dart';
import '../auth_work.dart';
import '../chat_user_data.dart';

class ChatScreenNew extends StatefulWidget {
  final AcceptedDateData? acceptUser;

  const ChatScreenNew({
    Key? key,
    this.acceptUser,
  }) : super(key: key);

  @override
  State<ChatScreenNew> createState() => _ChatScreenNewState();
}

class _ChatScreenNewState extends State<ChatScreenNew> {
  Messges? messges;
  List<Messges> _list = [];
  TextEditingController msg = TextEditingController();
  ScrollController _scrollController = ScrollController();

  bool isUploading = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: WillPopScope(
        onWillPop: () {
            return Future.value(true);
        },
        child: Scaffold(
          // resizeToAvoidBottomInset : false,
          backgroundColor: Colors.white,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: backgroundColor,
            systemOverlayStyle:
                const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
            flexibleSpace: Padding(
              padding: const EdgeInsets.only(top: 25.0),
              child: _appBar(),
            ),
          ),
          body: Column(
            children: [
              Expanded(
                child: StreamBuilder(
                    stream: AuthWork.getAllMessages(widget.acceptUser!),
                    builder: (context, snapshot)  {
                      switch (snapshot.connectionState) {
                        case ConnectionState.waiting:
                        case ConnectionState.none:
                        // return SizedBox();

                        case ConnectionState.active:
                        case ConnectionState.done:
                          final data = snapshot.data;
                          try {
                            _list.clear();

                            List temp =  data!["chatMessages"];

                            temp.forEach((element) {
                              _list.add(Messges.fromJson(element));
                            });

                            temp.clear();
                            print("SADASDASDSA");
                            print(_list);

                          } catch (e){
                            // print(widget.acceptUser!.id);
                            // FirebaseFirestore.instance.collection("messages").doc(widget.acceptUser!.id).update({
                            //   "chatMessages" : []
                            // });
                            // _list = [];
                          }


                          if (_list.isNotEmpty) {
                            return ListView.builder(
                                reverse: true,
                                padding: EdgeInsets.only(
                                    top:
                                        MediaQuery.of(context).size.height * .01),
                                itemCount: _list.length,
                                physics: BouncingScrollPhysics(),
                                itemBuilder: (context, index) {
                                  int length = _list.length;
                                  return MessgeCard(
                                    messegs: _list[length-index-1],
                                  );
                                });
                          } else {
                            return Center(
                              child: Text(
                                'Say Hi.. 👋',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black45,
                                ),
                              ),
                            );
                          }
                      }
                    }),
              ),

              //uploadig image

              if (isUploading)
                Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 8,
                    ),
                    child: Container(
                      width: 35,
                      height: 35,
                      child:CircularProgressIndicator(),
                    ),
                  ),
                ),
              chatInput(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _appBar() {
    return Row(
      children: [
        SizedBox(
          width: 20,
        ),
        InkWell(
            onTap: (){
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back_ios_new,
              color: Colors.black,
            )),
        SizedBox(
          width: 10,
        ),
        Container(
          height: 50,
          width: 50,
          decoration: BoxDecoration(
              border: Border.all(
                color: Color(0xffFFE2A9),
                width: 1.5,
              ),
              shape: BoxShape.circle),
          child: RandomAvatar(widget.acceptUser!.name.toString(),
              height: 30, width: 30),
        ),
        SizedBox(
          width: 7,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${widget.acceptUser!.name}',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: 4,
            ),

          ],
        )
      ],
    );
  }

  Widget chatInput() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 5),
      child: Row(
        children: [
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: Scrollbar(
                    controller: _scrollController,
                    child: Container(
                      constraints: BoxConstraints(maxHeight: 100),
                      child: TextFormField(
                        scrollController: _scrollController,
                        cursorColor: Colors.black,
                        style: GoogleFonts.openSans(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                        ),
                        controller: msg,
                        maxLines: null, //grow automatically
                        keyboardType: TextInputType.multiline,
                        decoration: InputDecoration(
                          suffixIconColor: Colors.black,
                          contentPadding:
                              EdgeInsets.only(top: 10, left: 16, right: 16),
                          border: InputBorder.none,
                          hintText: 'Type Your Text here...',
                          hintStyle: GoogleFonts.openSans(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Colors.black26,
                          ),
                          filled: true,
                          fillColor: Colors.blue.withOpacity(0.2),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () async {
                    final ImagePicker _picker = ImagePicker();
                    // Pick an image
                    final List<XFile?> images =
                    await _picker.pickMultiImage(imageQuality: 90);
                    for (var i in images) {
                      setState(() {
                        isUploading = true;
                      });
                      await AuthWork.sendChatImage(widget.acceptUser!, File(i!.path));
                      // Navigator.pop(context);
                      setState(() {
                        isUploading = false;
                      });
                    }

                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.image,
                    color: Colors.blue,
                    size: 22,
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
                      await AuthWork.sendChatImage(
                          widget.acceptUser!, File(image.path));
                      // Navigator.pop(context);
                      setState(() {
                        isUploading = false;
                      });
                    }
                  },
                  icon: Icon(
                    Icons.camera_alt_rounded,
                    color: Colors.blue,
                    size: 22,
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
                      await AuthWork.sendChatVideo(widget.acceptUser!, File(video.path));
                      setState(() {
                        isUploading = false;
                      });
                    }
                  },
                  icon: Icon(
                    Icons.switch_video_outlined,
                    color: Colors.blue,
                    size: 22,
                  ),
                ),
              ],
            ),
          ),
          MaterialButton(
            minWidth: 43,
            height: 43,
            color: Colors.blue,
            shape: CircleBorder(),
            onPressed: () {

              if (msg.text.trim().isNotEmpty) {
                if (_list.isEmpty) {
                  //AuthWork.sendFirstMessage(widget.acceptUser!, msg.text, Typee.text);
                  AuthWork.sendMessage(widget.acceptUser!, msg.text, Typee.text);
                } else {
                  AuthWork.sendMessage(widget.acceptUser!, msg.text, Typee.text);
                }
                msg.text = '';
              }



            },
            child: Center(
              child: Icon(
                Icons.send,
                color: Colors.white,
                size: 18,
              ),
            ),
          ),
        ],
      ),
    );
  }

}
