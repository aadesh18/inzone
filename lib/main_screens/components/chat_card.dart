import 'package:flutter/material.dart';
import 'package:inzone/data/inzone_chat.dart';
import 'package:inzone/main_screens/chat_screen.dart';

class ChatCard extends StatelessWidget {
  InZoneChat inZoneChat;
  ChatCard({super.key, required this.inZoneChat});

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 0,
        child: ListTile(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (BuildContext context) {
              return const ChatScreen(
                name: "Smith Mathew",
                chatReference: "FZjcV1irTsrUVujUgBrM",
              );
            }));
          },
          leading: inZoneChat.profilePicturePath == null
              ? const CircleAvatar(
                  backgroundColor: Colors.amber,
                )
              : Image.asset(inZoneChat.profilePicturePath!),
          title: inZoneChat.personName == null
              ? const SizedBox()
              : Text(
                  inZoneChat.personName!,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
          subtitle: inZoneChat.lastMessage == null
              ? const SizedBox()
              : Text(inZoneChat.lastMessage!),
          tileColor: Colors.white,
          shape: const Border(
              bottom: BorderSide(width: 0.5, color: Color(0xffE6E5E5))),
        ));
  }
}
