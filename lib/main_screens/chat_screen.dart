
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:inzone/backend/database.dart';
import 'package:inzone/constants.dart';
import 'package:inzone/data/inzone_message.dart';
import 'package:inzone/main_screens/loading_screen.dart';
import 'package:random_avatar/random_avatar.dart';

class ChatScreen extends StatefulWidget {
  final String name;
  final String chatReference;

  const ChatScreen(
      {super.key, required this.name, required this.chatReference});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  List<InZoneMessage> messageList = [];
  var chatUsersList;
  var message = ValueNotifier("");
  final fieldText = TextEditingController();
  final ScrollController _controller = ScrollController();
  void clearText() {
    message.value = "";
    fieldText.clear();
  }

  InZoneDatabase database = InZoneDatabase();

  void _scrollDown() {
    _controller.animateTo(0.0,
        duration: const Duration(milliseconds: 1500), curve: Curves.decelerate);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: AppBar(
            elevation: 0,
            automaticallyImplyLeading: false,
            backgroundColor: backgroundColor,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(
                    Icons.arrow_back_ios_new,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                RandomAvatar(widget.name, height: 40, width: 40),
                // Image.asset(
                //   "images/sample_avatar_2.png",
                //   scale: 0.7,
                // ),
                const SizedBox(
                  width: 10,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.name,
                      style: const TextStyle(color: Colors.black),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    const Text(
                      "Active Now",
                      style: TextStyle(color: Colors.blue, fontSize: 12),
                    ),
                  ],
                ),
                const Spacer(),
              ],
            )),
      ),
      backgroundColor: backgroundColor,
      body: getBody(),
    );
  }

  Widget getBody() {
    return SafeArea(
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Column(
          children: <Widget>[
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30))),
                child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(30.0),
                      topRight: Radius.circular(30.0),
                    ),
                    child: StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('messages')
                          .doc(widget.chatReference)
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          messageList.clear();
                          chatUsersList = snapshot.data!.data()!['users'];
                          messageList = database.getMessages(snapshot);
                          return ListView.builder(
                            reverse: true,
                            shrinkWrap: true,
                            padding: const EdgeInsets.only(top: 15.0),
                            itemCount: messageList.length,
                            controller: _controller,
                            itemBuilder: (BuildContext context, int index) {
                              final message = messageList[index];

                              return _buildMessage(
                                  message.message, message.isMe);
                            },
                          );
                        }
                        return const LoadingScreen();
                      },
                    )),
              ),
            ),
            ValueListenableBuilder(
              valueListenable: message,
              builder: (context, value, child) {
                message.value = value;
                return _buildMessageComposer();
              },
            )
          ],
        ),
      ),
    );
  }

  _buildMessage(String message, bool isMe) {
    final Container msg = Container(
      margin: isMe
          ? const EdgeInsets.only(top: 2.5, bottom: 2.5, left: 80, right: 10)
          : const EdgeInsets.only(top: 2.5, bottom: 2.5, right: 80, left: 10),
      padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 13.0),
      width: MediaQuery.of(context).size.width * 0.75,
      decoration: BoxDecoration(
        color: isMe ? const Color(0xFF28A6FF) : const Color(0xFFDAF5FF),
        borderRadius: isMe
            ? const BorderRadius.only(
                topLeft: Radius.circular(20.0),
                bottomLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0),
                bottomRight: Radius.circular(4))
            : const BorderRadius.only(
                topLeft: Radius.circular(20.0),
                bottomLeft: Radius.circular(4.0),
                topRight: Radius.circular(20),
                bottomRight: Radius.circular(20)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            message,
            style: isMe
                ? const TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                  )
                : const TextStyle(
                    color: Colors.black,
                    fontSize: 16.0,
                  ),
          ),
          // Align(
          //   alignment: Alignment.bottomRight,
          //   child: Text(
          //     DateFormat.Hm().format(DateTime.now()),
          //     style: TextStyle(color: Colors.white, fontSize: 10),
          //   ),
          // )
        ],
      ),
    );
    if (isMe) {
      return msg;
    }
    return Row(
      children: <Widget>[
        msg,
      ],
    );
  }

  _buildMessageComposer() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      height: 70.0,
      decoration: const BoxDecoration(
        color: Colors.white,
        // borderRadius: BorderRadius.all(Radius.circular(30))
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextField(
              controller: fieldText,
              textCapitalization: TextCapitalization.sentences,
              onTap: () {
                _scrollDown();
              },
              onChanged: (value) {
                if (fieldText.text.length ==
                    fieldText.text.allMatches(" ").length) {
                  fieldText.clear();
                } else {
                  message.value = value;
                }
              },
              decoration: const InputDecoration.collapsed(
                  hintText: 'Send a message...',
                  hintStyle: TextStyle(color: Colors.black)),
            ),
          ),
          fieldText.text.isNotEmpty
              ? IconButton(
                  icon: const Icon(Icons.send),
                  iconSize: 25.0,
                  color: Colors.black,
                  onPressed: () async {
                    messageList = messageList.reversed.toList();
                    messageList.add(InZoneMessage(
                        message: message.value,
                        isMe: true,
                        timeSent: DateTime.now(),
                        senderID: "FZjcV1irTsrUVujUgBrM"));
                    clearText();
                    _scrollDown();
                    await database.addNewMessage(
                        usersList: chatUsersList,
                        chatReference: widget.chatReference,
                        messageList: messageList);
                  },
                )
              : const Icon(
                  Icons.send,
                  color: Colors.white,
                  size: 25,
                ),
        ],
      ),
    );
  }
}
