import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:inzone/constants.dart';
import 'package:inzone/data/inzone_enums.dart';
import 'package:inzone/filter_list_package_inzone_altered/filter_list_dialog.dart';
import 'package:inzone/main_screens/settings_screens/content_selection_screen.dart';
import 'package:lottie/lottie.dart';
import 'package:inzone/data/string_extension.dart';
import 'package:inzone/constants.dart';

class FocusPage extends StatefulWidget {
  bool newUser = false;
  FocusPage({super.key, required this.newUser});

  @override
  State<FocusPage> createState() => _FocusPageState();
}

class _FocusPageState extends State<FocusPage> {
  List<String> focusTopicsList = [];
  List<String> fallBackTopicsList = [];
  List<String> customTopicsList = [];

  // onStart(int index) {
  //   lowList.add(focusContentList.elementAt(index).tittle);
  //   print(lowList);
  //   currentUser.setFocusTopics([
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
  //   highList.add(focusContentList.elementAt(index).tittle);
  //   print(highList);
  //   currentUser.setFocusTopics([
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
  List<ContentModel> selectedListFinal = [];

  
  
  // Fill it with false initially
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(40),
        color: Colors.white,
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                //height: 300,
                padding: EdgeInsets.only(left: 20, top: 20),
                child: const Text(
                  "Focus",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
                )),
        
            topicSelector(focusContentList, focusTopicsList, "focus"),
            Container(
              //height: 300,
                padding: EdgeInsets.only(left: 20, top: 20),
                child: const Text(
                  "Fall Back",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
                )),
            topicSelector(fallbackContentList, fallBackTopicsList, "fallback"),

            Container(
              //height: 300,
                padding: EdgeInsets.only(left: 20, top: 20),
                child: const Text(
                  "Custom",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
                )),

            topicSelector(customContentList, customTopicsList, "custom"),
            SizedBox(height: 30,)
            //       SizedBox(
            //         height: 290,
            //         child: ListView.builder(
            //           //   scrollDirection: Axis.vertical,
            //           itemCount: focusContentList.length,
            //           itemBuilder: (BuildContext context, int index) {
            //             return GestureDetector(
            //               onTap: () {
            //                 setState(() {
            //                   selectedFocus[index] = !selectedFocus[index];
            //                 });
            //                     lowList.add(focusContentList.elementAt(index).tittle);
            //                     currentUser.setFocusTopics(lowList);
            // // print(lowList);
            // // currentUser.setFocusTopics([
            // //   {InZoneEnums.lowVisibility: lowList.toSet().toList()},
            // //   {InZoneEnums.highVisibility: highList.toSet().toList()}
            // // ]);
            // //
            // //
            // //
            //
            //               },
            //               child: SizedBox(
            //                 height: index != focusContentList.length - 1 ? 60 : 100,
            //                 child: Stack(
            //                   children: [
            //                     Container(
            //                       margin: const EdgeInsets.only(
            //                           left: 10, right: 10, bottom: 5, top: 5),
            //                       decoration: BoxDecoration(
            //                         borderRadius: BorderRadius.circular(10.0),
            //                         color: selectedFocus[index]
            //                             ? backgroundColor
            //                             : Colors.white,
            //                         boxShadow: [
            //                           BoxShadow(
            //                             color: selectedFocus[index]
            //                                 ? backgroundColor
            //                                 : backgroundColor.withOpacity(0.5),
            //                             spreadRadius: 3,
            //                             blurRadius: 1,
            //                             offset: const Offset(
            //                                 0, 3), // Changes the position of the shadow
            //                           ),
            //                         ],
            //                       ),
            //                       child: ListTile(
            //                         title: Text(
            //                             replaceAndCapitalize(
            //                                 focusContentList[index].tittle),
            //                             style: const TextStyle(
            //                                 fontSize: 16, fontWeight: FontWeight.w700)),
            //                         leading: SvgPicture.asset(
            //                           "icons/category_icons/${focusContentList[index].tittle}.svg",
            //                           height: 25,
            //                           width: 25,
            //                         ),
            //                       ),
            //                     ),
            //                   ],
            //                 ),
            //               ),
            //             );
            //           },
            //         ),
            //       ),
        
        
          ],
        ),
      ),
    );
  }

  Widget topicSelector(List<ContentModel> list, List<String> selectedList, String word) {
    return Container(
      height: 350,
      child: FilterListWidget<ContentModel>(
        listData: list,
        selectedListData: selectedListFinal,
        hideCloseIcon: true,
        hideSearchField: true,
        hideSelectedTextCount: true,
        hideHeader: true,
applyButtonText: "Save",
onApplyButtonClick: (list){
          selectedList.clear();
          if (list != null){
            list.forEach((selected) {
              selectedList.add(replaceAndCapitalize(selected.tittle));
            });

            if (word == "focus"){
              currentUser.setFocusTopics(selectedList);
            } else if (word == "fallback"){
              currentUser.setFallbackTopics(selectedList);
            } else if (word == "custom"){
              currentUser.setCustomTopics(selectedList);
            }
          }

},
// choiceChipBuilder: (context, item, isSelected) {
//
//
//   return ChoiceChip(
//       label: Text(item!.tittle),
//       selected: isSelected!,
//       onSelected: (bool selected) {
//         if (selected) {
//           print('Clicked ${item.name}');
//         }
//       });
//           } ,

        controlButtons: [],
        // onApplyButtonClick: (list) {
        //   // list!.forEach((element){
        //   //   lowList.add(element.tittle);
        //   // });
        //   // currentUser.setFocusTopics(lowList);
        // },
        choiceChipLabel: (item) {
          /// Used to display text on chip
          return replaceAndCapitalize(item!.tittle);
        },
        validateSelectedItem: (list, val) {
          ///  identify if item is selected or not
          return list!.contains(val);
        },
        onItemSearch: (user, query) {
          /// When search query change in search bar then this method will be called
          ///
          /// Check if items contains query
          return user.tittle.contains(query.toLowerCase());
        },
      ),
    );
  }
}
