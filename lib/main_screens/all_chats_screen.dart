import 'package:flutter/material.dart';
import 'package:inzone/constants.dart';
import 'package:inzone/data/inzone_chat.dart';
import 'package:inzone/main_screens/components/chat_card.dart';
import 'package:inzone/main_screens/components/inzone_search_bar.dart';

class AllChatsScreen extends StatefulWidget {
  const AllChatsScreen({super.key});

  @override
  State<AllChatsScreen> createState() => _AllChatsScreenState();
}

class _AllChatsScreenState extends State<AllChatsScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Column(
          children: [
            const Text(
              "Chats",
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 30),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: InZoneSearchBar(),
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
                child: ListView(
                  shrinkWrap: true,
                  // physics: NeverScrollableScrollPhysics(),
                  children: [
                    ChatCard(
                        inZoneChat: InZoneChat(
                            personName: "John Monroe",
                            profilePicturePath: "images/sample_avatar_2.png",
                            lastMessage: "This was the last message")),
                    ChatCard(
                        inZoneChat: InZoneChat(
                            personName: "John Monroe",
                            profilePicturePath: "images/sample_avatar_2.png",
                            lastMessage: "This was the last message")),
                    ChatCard(
                        inZoneChat: InZoneChat(
                            personName: "John Monroe",
                            profilePicturePath: "images/sample_avatar_2.png",
                            lastMessage: "This was the last message")),
                    ChatCard(
                        inZoneChat: InZoneChat(
                            personName: "John Monroe",
                            profilePicturePath: "images/sample_avatar_2.png",
                            lastMessage: "This was the last message")),
                    ChatCard(
                        inZoneChat: InZoneChat(
                            personName: "John Monroe",
                            profilePicturePath: "images/sample_avatar_2.png",
                            lastMessage: "This was the last message")),
                    ChatCard(
                        inZoneChat: InZoneChat(
                            personName: "John Monroe",
                            profilePicturePath: "images/sample_avatar_2.png",
                            lastMessage: "This was the last message")),
                    ChatCard(
                        inZoneChat: InZoneChat(
                            personName: "John Monroe",
                            profilePicturePath: "images/sample_avatar_2.png",
                            lastMessage: "This was the last message")),
                    ChatCard(
                        inZoneChat: InZoneChat(
                            personName: "John Monroe",
                            profilePicturePath: "images/sample_avatar_2.png",
                            lastMessage: "This was the last message")),
                    ChatCard(
                        inZoneChat: InZoneChat(
                            personName: "John Monroe",
                            profilePicturePath: "images/sample_avatar_2.png",
                            lastMessage: "This was the last message")),
                    ChatCard(
                        inZoneChat: InZoneChat(
                            personName: "John Monroe",
                            profilePicturePath: "images/sample_avatar_2.png",
                            lastMessage: "This was the last message")),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
