import 'package:cool_dropdown/controllers/dropdown_controller.dart';
import 'package:cool_dropdown/cool_dropdown.dart';
import 'package:cool_dropdown/models/cool_dropdown_item.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:floating_draggable_widget/floating_draggable_widget.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_floating_bottom_bar/flutter_floating_bottom_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:inzone/constants.dart';
import 'package:inzone/main_screens/all_chats_screen.dart';
import 'package:inzone/custom_icons.dart';
import 'package:inzone/main_screens/explore_screen.dart';
import 'package:inzone/main_screens/home_screen.dart';
import 'package:inzone/main_screens/post_screen.dart';
import 'package:inzone/main_screens/settings_screen.dart';
import 'package:sliding_sheet2/sliding_sheet2.dart';

import '../models/inbox/inbox.dart';

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

  @override
  Widget build(BuildContext context) {
    return FloatingDraggableWidget(
      floatingWidgetHeight: 60,
      floatingWidgetWidth: 60,
      dy: screenHeight! * 0.80,
      dx: screenWidth! * 0.80,
      widgetWhenDragging: FloatingActionButton(
        backgroundColor: backgroundColor.withOpacity(1),
        shape: const CircleBorder(),
        foregroundColor: const Color(0xff16202a),
        child: const Icon(Icons.add),
        onPressed: () {},
      ),
      autoAlign: true,
      
      floatingWidget: FloatingActionButton(
        backgroundColor: backgroundColor.withOpacity(0.5),
        shape: const CircleBorder(),
        foregroundColor: const Color(0xff16202a),
        child: const Icon(Icons.add),
        onPressed: () {
          showSlidingBottomSheet(context,
              builder: (context) => SlidingSheetDialog(
                    cornerRadius: 30,
                    backdropColor: backgroundColor.withOpacity(0.6),
                    duration: const Duration(seconds: 1),
                    snapSpec: const SnapSpec(snappings: [ 0.9]),
                    builder: (context, state) {
                      return const PostScreen();
                    },
                  ));
        },
      ),
      mainScreenWidget: Scaffold(
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
                        style:  TextStyle(
                            fontSize: 26, fontWeight: FontWeight.w700)),

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
          backgroundColor: backgroundColor,
          body: HomeScreen()),
    );
  }
}
