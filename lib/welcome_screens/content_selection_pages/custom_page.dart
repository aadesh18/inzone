import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:inzone/constants.dart';
import 'package:inzone/data/inzone_enums.dart';
import 'package:inzone/main_screens/settings_screens/content_selection_screen.dart';
import 'package:lottie/lottie.dart';
import 'package:inzone/data/string_extension.dart';
import 'package:inzone/constants.dart';

class CustomPage extends StatefulWidget {
  bool newUser = false;
  CustomPage({super.key, required this.newUser});

  @override
  State<CustomPage> createState() => _CustomPageState();
}

class _CustomPageState extends State<CustomPage> {
  List<String> lowList = [];


  List<String> highList = [];

  // onStart(int index) {
  //   lowList.add(customContentList.elementAt(index).tittle);
  //   print(lowList);
  //   currentUser.setCustomTopics([
  //     {InZoneEnums.lowVisibility: lowList.toSet().toList()},
  //     {InZoneEnums.highVisibility: highList.toSet().toList()}
  //   ]);
  //   return ActionPane(
  //     // A motion is a widget used to control how the pane animates.
  //     extentRatio: 0.2,
  //     motion: const ScrollMotion(),
  //
  //     children: [
  //       // A SlidableAction can have an icon and/or a label.
  //
  //       Image.asset("icons/content_icons/low.png"),
  //     ],
  //   );
  // }

  // onEnd(int index) {
  //   highList.add(customContentList.elementAt(index).tittle);
  //   print(highList);
  //   currentUser.setCustomTopics([
  //     {InZoneEnums.lowVisibility: lowList.toSet().toList()},
  //     {InZoneEnums.highVisibility: highList.toSet().toList()}
  //   ]);
  //   return ActionPane(
  //     extentRatio: 0.2,
  //     motion: const ScrollMotion(),
  //     children: [
  //       Image.asset("icons/content_icons/high.png"),
  //     ],
  //   );
  // }

  String replaceAndCapitalize(String text) {
    // Split the text into words based on underscores.
    if (text.contains("_")) {
      List<String> words = text.split('_');

      // Capitalize the first letter of each word.
      words = words
          .map((word) => word.replaceFirst(word[0], word[0].toUpperCase()))
          .toList();

      // Join the words back together with spaces.
      return words.join(' ');
    }

    return text.capitalize();
  }

  
  
  // Fill it with false initially
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(40),
        color: Colors.white,
      ),
      child: Column(
        children: [
          Container(
              //height: 300,
              margin: const EdgeInsets.only(top: 30, bottom: 5),
              child: const Text(
                "Custom",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
              )),
          const Text(
            "Other times",
            style: TextStyle(
                fontSize: 13, color: Colors.grey, fontWeight: FontWeight.w200),
          ),
          SizedBox(
            height: 290,
            child: ListView.builder(
              //   scrollDirection: Axis.vertical,
              itemCount: customContentList.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedCustom[index] = !selectedCustom[index];
                    });

                                    lowList.add(customContentList.elementAt(index).tittle);
                                    currentUser.setCustomTopics(lowList);
    //                     highList.add(customContentList.elementAt(index).tittle);
    // print(lowList);
    // currentUser.setCustomTopics([
    //   {InZoneEnums.lowVisibility: lowList.toSet().toList()},
    //   {InZoneEnums.highVisibility: highList.toSet().toList()}
    // ]);
                  },
                  child: SizedBox(
                    height: index != customContentList.length - 1 ? 60 : 100,
                    child: Stack(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(
                              left: 10, right: 10, bottom: 5, top: 5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: selectedCustom[index]
                                ? backgroundColor
                                : Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: selectedCustom[index]
                                    ? backgroundColor
                                    : backgroundColor.withOpacity(0.5),
                                spreadRadius: 3,
                                blurRadius: 1,
                                offset: const Offset(
                                    0, 3), // Changes the position of the shadow
                              ),
                            ],
                          ),
                          child: ListTile(
                            title: Text(
                                replaceAndCapitalize(
                                    customContentList[index].tittle),
                                style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w700)),
                            leading: SvgPicture.asset(
                              "icons/category_icons/${customContentList[index].tittle}.svg",
                              height: 25,
                              width: 25,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Spacer(),


          Text("Click done below !",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),),
          Spacer()
        ],
      ),
    );
  }
}
