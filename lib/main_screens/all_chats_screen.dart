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
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: PreferredSize(
        preferredSize:
        const Size.fromHeight(50),
        child: AppBar(
            elevation: 0,
            automaticallyImplyLeading: false,
            backgroundColor: backgroundColor,
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios_new, size: 20,),

              color: Colors.black,
              onPressed: (){
                Navigator.pop(context);
              },
            ),
            title:      Text("Chats",
                style: const TextStyle(
                    fontSize: 26, fontWeight: FontWeight.w700)),

        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Column(
            children: [
              // const Text(
              //   "Chats",
              //   style: TextStyle(
              //       color: Colors.black,
              //       fontWeight: FontWeight.bold,
              //       fontSize: 30),
              // ),
              // const SizedBox(
              //   height: 10,
              // ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
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
                      color: backgroundColor,
                      style: BorderStyle.solid,
                      width: 10.0,
                    ),
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  child: Center(child: Text("You do not have any conversations", style: TextStyle(color: Colors.black, fontWeight: FontWeight.w300)))
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
