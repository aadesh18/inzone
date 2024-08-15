import 'package:cool_dropdown/controllers/dropdown_controller.dart';
import 'package:cool_dropdown/cool_dropdown.dart';
import 'package:cool_dropdown/models/cool_dropdown_item.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:floating_draggable_widget/floating_draggable_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:flutter_floating_bottom_bar/flutter_floating_bottom_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:inzone/constants.dart';
import 'package:inzone/main_screens/all_chats_screen.dart';
import 'package:inzone/custom_icons.dart';
import 'package:inzone/main_screens/explore_screen.dart';
import 'package:inzone/main_screens/home_screen.dart';
import 'package:inzone/main_screens/post_screen.dart';
import 'package:inzone/main_screens/settings_screen.dart';
import 'package:inzone/shared_preferences_helper_class.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sliding_sheet2/sliding_sheet2.dart';

import '../models/inbox/inbox.dart';
import 'dart:async';
class RootApp extends StatefulWidget {
  const RootApp({Key? key}) : super(key: key);

  @override
  _RootAppState createState() => _RootAppState();
}

class _RootAppState extends State<RootApp> with SingleTickerProviderStateMixin {
  List<String> modes = [
    'Focus',
    'Fall Back',
    'Custom',
    'Setting',
  ];

  final modeDropdownController = DropdownController();
  List<CoolDropdownItem<String>> modeDropdownItems = [
    CoolDropdownItem<String>(
        label: 'Focus',
        icon: Container(
          height: 21,
          width: 21,
          child: SvgPicture.asset(
            CustomIcons.focus,
          ),
        ),
        value: 'Focus'),
    CoolDropdownItem<String>(
        label: 'Fall Back',
        icon: Container(
          height: 21,
          width: 21,
          child: SvgPicture.asset(
            CustomIcons.fallback,
          ),
        ),
        value: 'Fall Back'),
    CoolDropdownItem<String>(
        label: 'Custom',
        icon: Container(
          height: 21,
          width: 21,
          child: SvgPicture.asset(
            CustomIcons.custom,
          ),
        ),
        value: 'Custom'),
    CoolDropdownItem<String>(
        label: 'Setting',
        icon: Container(
          height: 21,
          width: 21,
          child: Icon(Icons.settings),
        ),
        value: 'Setting')
  ];

  List<DropdownMenuItem<String>> get dropdownItems {
    List<DropdownMenuItem<String>> menuItems = [
      DropdownMenuItem(
          value: "Focus",
          child: Text(
            "Focus",
            style: TextStyle(
                color: Colors.blue, fontWeight: FontWeight.bold, fontSize: 20),
          )),
      DropdownMenuItem(
          value: "Fall Back",
          child: Text(
            "Fall Back",
            style: TextStyle(
                color: Colors.blue, fontWeight: FontWeight.bold, fontSize: 20),
          )),
      DropdownMenuItem(
          value: "Custom",
          child: Text(
            "Custom",
            style: TextStyle(
                color: Colors.blue, fontWeight: FontWeight.bold, fontSize: 20),
          )),
      DropdownMenuItem(
          value: "Setting",
          child: GestureDetector(
            onTap: () async {
              //  await FirebaseAuth.instance.signOut();
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SettingsScreen()));
            },
            child: Text(
              "Setting",
              style: TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            ),
          )),
    ];
    return menuItems;
  }

  String selectedValue = "Fall Back";


  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  final _key = GlobalKey<ExpandableFabState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _key,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: AppBar(
              elevation: 0,
              automaticallyImplyLeading: false,
              surfaceTintColor: Colors.transparent,
              backgroundColor: backgroundColor,
              title: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text("InZone",
                      style:
                          TextStyle(fontSize: 26, fontWeight: FontWeight.w700)),

                  Center(
                    child: CoolDropdown<String>(
                      controller: modeDropdownController,
                      dropdownList: modeDropdownItems,
                      defaultItem: modeDropdownItems.first,
                      onChange: (a) async {
                        modeDropdownController.close();
                        if (a == "Setting") {
                          //  await FirebaseAuth.instance.signOut();
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SettingsScreen()));
                        }
                      },
                      resultOptions: ResultOptions(
                        width: 70,
                        height: 70,
                        render: ResultRender.icon,
                        boxDecoration: BoxDecoration(
                          color: backgroundColor,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        openBoxDecoration: BoxDecoration(
                          color: backgroundColor,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        icon: const SizedBox(),
                      ),
                      dropdownOptions: const DropdownOptions(
                        width: 140,
                      ),
                      dropdownItemOptions: const DropdownItemOptions(
                        textStyle: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.w300),
                        selectedTextStyle: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.w300),
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        boxDecoration: BoxDecoration(
                          color: backgroundColor,
                        ),
                        selectedPadding: EdgeInsets.symmetric(horizontal: 10),
                        selectedBoxDecoration: BoxDecoration(
                          color: backgroundColor,
                        ),
                      ),
                    ),
                  ),
                  // DropdownButton(
                  //   elevation: 0,
                  //
                  //   isDense: true,
                  //   //alignment: Alignment.bottomCenter,
                  //   underline: const SizedBox(),
                  //   padding: EdgeInsets.zero,
                  //
                  //   // icon: Icon(
                  //   //   Icons.keyboard_arrow_down,
                  //   //   color: Colors.black,
                  //   // ),
                  //   icon: const Icon(Icons.keyboard_arrow_down_sharp, color: Colors.grey,),
                  //   value: selectedValue,
                  //   items: dropdownItems,
                  //   onChanged: (value) {
                  //     if (value != null) {
                  //       setState(() {
                  //         selectedValue = value;
                  //       });
                  //     }
                  //   },
                  // ),

                  const Spacer(),

                  GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ExploreScreen()));
                      },
                      child: Icon(
                        Icons.search,
                        color: Colors.black,
                      )),
                  SizedBox(
                    width: 10,
                  ),
                  GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const AllChatsScreen()));
                      },
                      child: const Icon(
                        Icons.bubble_chart_outlined,
                        color: Colors.black,
                      )),
                  // DropdownButton(
                  //   elevation: 0,
                  //
                  //   isDense: true,
                  //   //alignment: Alignment.bottomCenter,
                  //   underline: const SizedBox(),
                  //   padding: EdgeInsets.zero,
                  //
                  //   // icon: Icon(
                  //   //   Icons.keyboard_arrow_down,
                  //   //   color: Colors.black,
                  //   // ),
                  //   icon: const SizedBox.shrink(),
                  //   value: selectedValue,
                  //   items: dropdownItems,
                  //   onChanged: (value) {
                  //     if (value != null) {
                  //       setState(() {
                  //         selectedValue = value;
                  //       });
                  //     }
                  //   },
                  // )
                ],
              )),
        ),
        floatingActionButtonLocation: ExpandableFab.location,
        floatingActionButton: ExpandableFab(
          openButtonBuilder: RotateFloatingActionButtonBuilder(
            child: const Icon(Icons.add),
            fabSize: ExpandableFabSize.regular,
            foregroundColor: Colors.black,
            backgroundColor: backgroundColor,
          ),
          overlayStyle: ExpandableFabOverlayStyle(
            color: Colors.black.withOpacity(0.5),
            blur: 5,
          ),
          onOpen: () {
            debugPrint('onOpen');
          },
          afterOpen: () {
            debugPrint('afterOpen');
            final state = _key.currentState;
            if (state != null) {
              debugPrint('isOpen:${state.isOpen}');
              state.toggle();
            }
          },
          onClose: () {
            debugPrint('onClose');
          },
          afterClose: () {
            debugPrint('afterClose');
          },
          children: [
            FloatingActionButton.small(
              // shape: const CircleBorder(),
              heroTag: null,
              child: const Icon(Icons.person_add),
              foregroundColor: Colors.black,
              backgroundColor: backgroundColor,
              onPressed: () {
                showSlidingBottomSheet(context,
                    builder: (context) => SlidingSheetDialog(
                      cornerRadius: 30,
                      backdropColor: backgroundColor.withOpacity(0.6),
                      duration: const Duration(seconds: 1),
                      snapSpec: const SnapSpec(snappings: [0.9]),
                      builder: (context, state) {
                        return const CharacterCreationPage();
                      },
                    ));
              },
            ),
            FloatingActionButton.small(
              // shape: const CircleBorder(),
              heroTag: null,
              child: const Icon(Icons.add),
              foregroundColor: Colors.black,
              backgroundColor: backgroundColor,
              onPressed: () {
                // const SnackBar snackBar = SnackBar(
                //   content: Text("SnackBar"),
                // );
                showSlidingBottomSheet(context,
                    builder: (context) => SlidingSheetDialog(
                          cornerRadius: 30,
                          backdropColor: backgroundColor.withOpacity(0.6),
                          duration: const Duration(seconds: 1),
                          snapSpec: const SnapSpec(snappings: [0.9]),
                          builder: (context, state) {
                            return const PostScreen();
                          },
                        ));
              },
            ),

            // FloatingActionButton.small(
            //   // shape: const CircleBorder(),
            //   heroTag: null,
            //   child: const Icon(Icons.person),
            //   foregroundColor: Colors.black,
            //   backgroundColor: backgroundColor,
            //   onPressed: () {},
            // ),
          ],
        ),
        backgroundColor: backgroundColor,
        body: HomeScreen());
  }
}

class CharacterCreationPage extends StatefulWidget {
  const CharacterCreationPage({super.key});

  @override
  State<CharacterCreationPage> createState() => _CharacterCreationPageState();
}

class _CharacterCreationPageState extends State<CharacterCreationPage> {
  late SharedPreferences _prefs;
  List<String> _savedList = [];

  @override
  void initState() {
    super.initState();
    _loadPreferences();
  }

  Future<void> _loadPreferences() async {
    List<String>? list = await SharedPreferencesHelperClass.getStringList();
    setState(() {
      _savedList = list ?? [];
    });
  }

  Future<void> _savePreferences(List<String> list) async {
    await SharedPreferencesHelperClass.saveStringList(list);
    setState(() {
      _savedList = list;
    });
  }

  bool nameSubmitted = false;
  bool success = false;
  TextEditingController nameController = TextEditingController();
  bool onLastPage = false;
  bool timerOver = false;

  void _handleTimerEnd() {
    setState(() {
      timerOver = true;
    });
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
            body: Padding(
                padding:
                    const EdgeInsets.only(bottom: 8.0, left: 8.0, right: 8.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(
                          left: 6.0,
                          right: 6.0,
                          top: 6.0,
                        ),
                        child: Center(
                          child: Text(

                               " Create a character!",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.blue,
                                fontSize: 28,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
// SizedBox(height: 10,),
                 SizedBox(height: 30,),
                      nameSubmitted
                          ? LottieWithTimer(onTimerEnd: _handleTimerEnd,)
                          : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Character Name", style: TextStyle(fontWeight: FontWeight.bold),),
                              SizedBox(height: 5,),
                              Container(
                                  width: screenWidth,
                                  height: 80,
                                  child: TextField(
                                    maxLines:
                                        1, // Set maxLines to null for multiline
                                    textInputAction: TextInputAction.send,
                                    controller: nameController,
                                    textAlign: TextAlign.left,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(18.0),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(18.0),
                                        borderSide:
                                            BorderSide(color: Colors.grey.shade900),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(18.0),
                                        borderSide: BorderSide(color: Colors.blue),
                                      ),
                                      contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 16.0,
                                        vertical: 8.0,
                                      ),
                                      // labelText: 'What do you want you talk about?',
                                      //
                                      // labelStyle: TextStyle(color: Colors.grey.shade900),
                                      hintText: 'Name your character',

                                      hintStyle: TextStyle(
                                        color: Colors.grey.shade700,
                                      ),
                                    ),
                                    onChanged: (value) {},
                                    onEditingComplete: () {},
                                    onSubmitted: (t) {
                                      setState(() {
                                        nameSubmitted = true;
                                      });
                                    },
                                    onTapOutside: (t) {},
                                    onTap: () {},
                                  ),
                                ),
                              Text("Character Description", style: TextStyle(fontWeight: FontWeight.bold),),
                              SizedBox(height: 5,),
                              Container(
                                width: screenWidth,
                                height: 150,
                                child: TextField(
                                  minLines: 1,
                                  maxLines:
                                  6, // Set maxLines to null for multiline
                                  textInputAction: TextInputAction.send,
                                  textAlign: TextAlign.left,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(18.0),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(18.0),
                                      borderSide:
                                      BorderSide(color: Colors.grey.shade900),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(18.0),
                                      borderSide: BorderSide(color: Colors.blue),
                                    ),
                                    contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 16.0,
                                      vertical: 8.0,
                                    ),
                                    // labelText: 'What do you want you talk about?',
                                    //
                                    // labelStyle: TextStyle(color: Colors.grey.shade900),
                                    hintText: 'Name: Junior\nGender: Male\nAge: 14\nEye Color: Hazel\nLikes: Sports, Streaming and Gaming',

                                    hintStyle: TextStyle(
                                      color: Colors.grey.shade700,



                                    ),
                                  ),
                                  onChanged: (value) {},
                                  onEditingComplete: () {},
                                  onSubmitted: (t) {
                                    setState(() {
                                      nameSubmitted = true;
                                    });
                                  },
                                  onTapOutside: (t) {},
                                  onTap: () {},
                                ),
                              ),
                            ],
                          ),
                      Spacer(flex: 2,),
                      timerOver ? Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                            
                                onPressed:  () {
                                  setState(() {
                            
                                  });
                            
                                } ,
                                style: ElevatedButton.styleFrom(
                                    elevation: 10,
                                    backgroundColor: Colors.blue,
                                    disabledBackgroundColor: Colors.blue,
                            //elevation of button
                                    shape: RoundedRectangleBorder(
                            //to set border radius to button
                                        borderRadius: BorderRadius.circular(60)),
                                    padding: const EdgeInsets.symmetric(
                                    vertical: 10)
                                ),
                                child:   const  Text(
                                  "Regenerate",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                )),
                          ),
                          SizedBox(width: 5,),
                          Expanded(
                            child: ElevatedButton(
                            
                                onPressed:  () {
                                  setState(() {
                            Navigator.pop(context);
                                  });
                            
                                } ,
                                style: ElevatedButton.styleFrom(
                                    elevation: 10,
                                    backgroundColor: Colors.blue,
                                    disabledBackgroundColor: Colors.blue,
                                    //elevation of button
                                    shape: RoundedRectangleBorder(
                                      //to set border radius to button
                                        borderRadius: BorderRadius.circular(60)),
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 10)
                                ),
                                child:   const  Text(
                                  "Save",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                )),
                          ),

                        ],
                      ): ElevatedButton(

                              onPressed: nameSubmitted ? null : () {
// Navigator.push(
//     context,
//     MaterialPageRoute(
//         builder: (context) => const InformationPages()));

        if (nameController.text.isNotEmpty) {
      _savedList.add(nameController.text);
      _savePreferences(_savedList);

      setState(() {
        nameSubmitted = true;
      });
    }


                              } ,
                              style: ElevatedButton.styleFrom(
                                  elevation: 10,
                                  backgroundColor: Colors.blue,
disabledBackgroundColor: Colors.grey,
//elevation of button
                                  shape: RoundedRectangleBorder(
//to set border radius to button
                                      borderRadius: BorderRadius.circular(60)),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 60, vertical: 20)),
                              child:    Text(
                                "Create my character" ,
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              )),
Spacer()
                    ]))));
  }
}




class LottieWithTimer extends StatefulWidget {
  final VoidCallback onTimerEnd;
  const LottieWithTimer({super.key, required this.onTimerEnd});

  @override
  State<LottieWithTimer> createState() => _LottieWithTimerState();
}

class _LottieWithTimerState extends State<LottieWithTimer> {
  bool showLottie = true;

  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      print("Timer over");
      setState(() {
        showLottie = false;
      });
      widget.onTimerEnd();

    });
  }

  @override
  Widget build(BuildContext context) {
    return showLottie ? Visibility(
      visible: showLottie,
      child:  Container(
        padding: const EdgeInsets.all(20),
        height: 500,
        width: 200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          gradient: RadialGradient(
            colors: [
              Colors.white.withOpacity(0.5),
              backgroundColor
            ],
            radius: 0.5,
            center: Alignment(0.0, 0.0),
            stops: [0.0, 1.0],
          ),
        ),
        child: Column(
          children: [
            Lottie.asset(
                'animations/animation_intro.json',
                height: 200,
                width: 200),
             Center(
              child: Text(

        "Designing a brand new character for you..." ,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color:Colors.blue,
                    fontSize: 14,
                    fontWeight: FontWeight.w500),
              ),
            ),
          ],
        ),
      )
    ) : Container(
      width:
      screenWidth! - 60,
      child: ClipRRect(
        borderRadius:
        BorderRadius.circular(8.0),
        child: Image.network(
          'https://plus.unsplash.com/premium_photo-1719986264183-d5efb55f4e01?q=80&w=1895&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
          fit: BoxFit.fitWidth,
          errorBuilder:
              (context, object, st) {
            return const Text(
                "error"
            );
          },
        ),
      ),
    );
  }
}