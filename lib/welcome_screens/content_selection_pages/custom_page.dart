import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:inzone/constants.dart';
import 'package:inzone/data/inzone_enums.dart';
import 'package:inzone/main_screens/settings_screens/content_selection_screen.dart';

class CustomPage extends StatelessWidget {
   CustomPage({super.key});

  List<String> lowList = [];
  List<String> highList = [];

  onStart(int index){

    lowList.add(contentList.elementAt(index).tittle);
    print(lowList);
    currentUser.setCustomTopics(
        [{InZoneEnums.lowVisibility : lowList.toSet().toList()},{ InZoneEnums.highVisibility : highList.toSet().toList()}
        ]);
    return ActionPane(

      // A motion is a widget used to control how the pane animates.
      extentRatio: 0.2,
      motion: const ScrollMotion(),

      children: [
        // A SlidableAction can have an icon and/or a label.


        Image.asset("icons/content_icons/low.png"),
      ],
    );
  }

  onEnd(int index){
    highList.add(contentList.elementAt(index).tittle);
    print(highList);
    currentUser.setCustomTopics(
        [{InZoneEnums.lowVisibility : lowList.toSet().toList()},{ InZoneEnums.highVisibility : highList.toSet().toList()}
        ]);
    return ActionPane(
      extentRatio: 0.2,
      motion: const ScrollMotion(),
      children: [
        Image.asset("icons/content_icons/high.png"),
      ],
    );
  }
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
              margin: const EdgeInsets.only(top: 30, bottom: 20),
              child: const Text(
                "Custom",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
              )),
          SizedBox(
            height: 325,
            child: ListView.builder(
              itemCount: contentList.length,
              itemBuilder: (BuildContext context, int index) {
                return Slidable(
                  key: Key('$index'),

                  startActionPane: ActionPane(
                    // A motion is a widget used to control how the pane animates.
                    extentRatio: 0.2,
                    motion: const ScrollMotion(),

                    children: [
                      // A SlidableAction can have an icon and/or a label.
                      Image.asset("icons/content_icons/low.png")
                    ],
                  ),

                  // The end action pane is the one at the right or the bottom side.
                  endActionPane: ActionPane(
                    extentRatio: 0.2,
                    motion: const ScrollMotion(),
                    children: [
                      Image.asset("icons/content_icons/high.png"),
                    ],
                  ),
                  child: SizedBox(
                    height: index != contentList.length - 1 ? 60 : 100,
                    child: Stack(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(
                              left: 10, right: 10, bottom: 5, top: 5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: Colors.white,
                            // border: Border(
                            //     top: BorderSide(
                            //         color: backgroundColor)
                            //         ),
                            boxShadow: [
                              BoxShadow(
                                color: backgroundColor.withOpacity(0.5),
                                spreadRadius: 3,
                                blurRadius: 1,
                                offset: const Offset(
                                    0, 3), // Changes the position of the shadow
                              ),
                            ],
                          ),
                          child: ListTile(
                            title: Text(contentList[index].tittle,
                                style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w700)),
                            leading: Image.asset(
                                "${contentList[index].iconPath}/$index.png"),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          const Spacer(),
          Icon(
            Icons.check,
            color: Colors.grey.shade600,
          ),
          const Text(
            "Done",
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.w500, fontSize: 14),
          ),
          const Spacer(),
          //  Lottie.asset("assets/animations/swipe_left.json")
        ],
      ),
    );
  }
}
