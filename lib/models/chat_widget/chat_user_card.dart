import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inzone/models/messege.dart';
import 'package:random_avatar/random_avatar.dart';

import '../auth_work.dart';
import '../chat_user_data.dart';
import '../inbox/chat_screen_complete.dart';
import '../widgets/date_time_util.dart';

class ChatUserCard extends StatefulWidget {
  AcceptedDateData userData;
  Messges? messges;


  ChatUserCard({Key? key, required this.userData,this.messges}) : super(key: key);

  @override
  State<ChatUserCard> createState() => _ChatUserCardState();
}

class _ChatUserCardState extends State<ChatUserCard> {
  Messges? messges;
  List<AcceptedDateData> userData = [];

  final user = FirebaseAuth.instance.currentUser!.uid;

  getData() async {
    // if (user != null) {
    QuerySnapshot res =
    await FirebaseFirestore.instance.collection('newUser').get();
    if (res.docs.isNotEmpty)
      setState(() {
        {
          userData = res.docs
              .map((e) =>
              AcceptedDateData.fromMap(e.data() as Map<String, dynamic>))
              .toList();
        }
      });
  }
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChatScreenNew(
              acceptUser: widget.userData,
            ),
          ),
        );
      },
      child: StreamBuilder(
          stream: AuthWork.getLastMessage(widget.userData),
          builder: (context, snapshot) {
            final data = snapshot.data?.docs;
            final _list =
                data?.map((e) => Messges.fromJson(e.data())).toList() ?? [];

            if (_list.isNotEmpty) {
              messges = _list[0];
            }



            return ListTile(
              leading: Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Color(0xffFFE2A9),
                    width: 1.5,
                  ),
                  shape: BoxShape.circle
                ),
                child:  RandomAvatar(widget.userData.name.toString(),
                    height: 30, width: 30),
              ),
              title: Text(
                '${widget.userData.name}',
                style: GoogleFonts.openSans(
                  color: Colors.black,
                  fontSize: 17,
                  fontWeight: FontWeight.w500,
                ),
              ),
              subtitle: Text(
                '${messges != null ? messges!.type == Typee.image ? 'Image' :  messges!.type == Typee.video ? 'Video' : messges!.msg : widget.userData.email}',

                maxLines: 1,
                style: GoogleFonts.openSans(
                  color: Colors.black45,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
              trailing: messges == null
                  ? null
                  : messges!.read!.isEmpty &&
                          messges!.fromId != AuthWork.user.uid
                      ? Container(
                          height: 12,
                          width: 12,
                          decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(10)),
                        )
                      : Text(
                          MyDateUtil.getLastMessageTime(
                              context: context, time: '${messges!.sent}'),
                          style: GoogleFonts.openSans(
                            color: Colors.black45,
                            fontSize: 13,
                          ),
                        ),
            );
          }),
    );
  }
}
