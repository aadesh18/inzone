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
import 'package:inzone/main_screens/me_screen.dart';
import 'package:inzone/main_screens/post_screen.dart';
import 'package:sliding_sheet2/sliding_sheet2.dart';

class RootApp extends StatefulWidget {
  const RootApp({Key? key}) : super(key: key);

  @override
  _RootAppState createState() => _RootAppState();
}

class _RootAppState extends State<RootApp> with SingleTickerProviderStateMixin {
  late int currentPage;
  late TabController tabController;

  List<String> appBarNames = ["InZone", "", "Chats", "Profile" ];
  List<DropdownMenuItem<String>> get dropdownItems {
    List<DropdownMenuItem<String>> menuItems = const [
       DropdownMenuItem(
          value: "Focus",
          child: Text(
            "Focus",
            style: TextStyle(
                color: Colors.blue, fontWeight: FontWeight.bold, fontSize: 20),
          )),
      DropdownMenuItem(
          value: "Fall Back",
          child:  Text(
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
    ];
    return menuItems;
  }

  String selectedValue = "Fall Back";


  @override
  void initState() {
    currentPage = 0;
    tabController = TabController(length: 4, vsync: this);
    tabController.animation?.addListener(
      () {
        final value = tabController.animation!.value.round();
        if (value != currentPage && mounted) {
          changePage(value);
        }
      },
    );
    super.initState();
  }

  void changePage(int newPage) {
    setState(() {
      currentPage = newPage;
    });
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FloatingDraggableWidget(
      floatingWidgetHeight: 60,
      floatingWidgetWidth: 60,
      dy: screenHeight! * 0.80,
      dx: screenWidth! * 0.82,
      widgetWhenDragging: FloatingActionButton(
        backgroundColor: backgroundColor.withOpacity(1) ,
        shape: const CircleBorder(),
        foregroundColor: const Color(0xff16202a),

        child: const Icon(Icons.add),
        onPressed: (){},


      ),

      autoAlign: true,
      floatingWidget: FloatingActionButton(
        backgroundColor: backgroundColor.withOpacity(0.5) ,
        shape: const CircleBorder(),
        foregroundColor: const Color(0xff16202a),

        child: const Icon(Icons.add),
        onPressed: (){
          showSlidingBottomSheet(context,
              builder: (context) => SlidingSheetDialog(
                cornerRadius: 30,
backdropColor:backgroundColor.withOpacity(0.6),
duration: Duration(seconds: 1),
                snapSpec: const SnapSpec(snappings: [0.7, 0.9]),
                builder: (context, state) {
                  return const PostScreen();
                },
              ));
        },


      ),
      mainScreenWidget: Scaffold(
        appBar: PreferredSize(
          preferredSize:
              currentPage == 1 ? const Size.fromHeight(0) : const Size.fromHeight(50),
          child: AppBar(
            elevation: 0,
            automaticallyImplyLeading: false,
            backgroundColor: backgroundColor,
            title: currentPage == 0
                ? Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(appBarNames[currentPage],
                          style: const TextStyle(
                              fontSize: 26, fontWeight: FontWeight.w700)),
                      const Spacer(),

                      DropdownButton(
                        elevation: 0,

                        isDense: true,
                        //alignment: Alignment.bottomCenter,
                        underline: const SizedBox(),
                        padding: EdgeInsets.zero,

                        // icon: Icon(
                        //   Icons.keyboard_arrow_down,
                        //   color: Colors.black,
                        // ),
                        icon: const SizedBox.shrink(),
                        value: selectedValue,
                        items: dropdownItems,
                        onChanged: (value) {
                          if (value != null) {
                            setState(() {
                              selectedValue = value;
                            });
                          }
                        },
                      )
                      // Row(
                      //   children: [
                      //     const Text(
                      //       "Focus",
                      //       style: TextStyle(
                      //           color: Colors.blue,
                      //           fontWeight: FontWeight.bold,
                      //           fontSize: 20),
                      //     ),
                      //     Icon(
                      //       Icons.keyboard_arrow_down,
                      //       color: Colors.black,
                      //       size: 12,
                      //     )
                      //   ],
                      // ),
                    ],
                  )
                : Text(appBarNames[currentPage],
                    style: const TextStyle(
                        fontSize: 26, fontWeight: FontWeight.w700)),
          ),
        ),
        backgroundColor: backgroundColor,
        body: BottomBar(
          clip: Clip.none,
          fit: StackFit.expand,
          icon: (width, height) => const Center(
            child: IconButton(
              padding: EdgeInsets.zero,
              onPressed: null,
              icon: Icon(
                Icons.arrow_upward_rounded,
                color: Colors.pink,
                size: 200,
              ),
            ),
          ),
          borderRadius: BorderRadius.circular(500),
          duration: const Duration(milliseconds: 500),
          curve: Curves.decelerate,
          showIcon: true,
          width: MediaQuery.of(context).size.width * 0.8,
          barColor: barColor,
          start: 2,
          end: 0,
          offset: 10,
          barAlignment: Alignment.bottomCenter,
          iconHeight: 30,
          iconWidth: 30,
          reverse: false,
          barDecoration: BoxDecoration(
            color: barSelectedColor,
            borderRadius: BorderRadius.circular(500),
          ),
          iconDecoration: BoxDecoration(
            color: barSelectedColor,
            borderRadius: BorderRadius.circular(500),
          ),
          hideOnScroll: true,
          scrollOpposite: false,
          onBottomBarHidden: () {},
          onBottomBarShown: () {},
          body: (context, controller) => TabBarView(
              controller: tabController,
              dragStartBehavior: DragStartBehavior.down,
              physics: const BouncingScrollPhysics(),
              children: const [
                HomeScreen(),
                ExploreScreen(),
                AllChatsScreen(),
                MeScreen(),
              ]),
          child: Stack(
            alignment: Alignment.center,
            clipBehavior: Clip.none,
            children: [
              TabBar(
                indicatorPadding: const EdgeInsets.fromLTRB(6, 0, 6, 0),
                controller: tabController,
                indicator: UnderlineTabIndicator(
                    borderSide: BorderSide(
                      color: currentPage <= 4
                          ? barSelectedColor
                          : barUnselectedColor,
                      width: 4,
                    ),
                    insets: const EdgeInsets.fromLTRB(16, 0, 16, 8)),
                tabs: [
                  SizedBox(
                    height: 70,
                    width: 40,
                    child: Center(
                        child: currentPage == 0
                            ? SvgPicture.asset(CustomIcons.homeSelected)
                            : SvgPicture.asset(CustomIcons.homeUnselected)),
                  ),
                  SizedBox(
                    height: 70,
                    width: 40,
                    child: Center(
                        child: currentPage == 1
                            ? SvgPicture.asset(CustomIcons.exploreUnselected)
                            : SvgPicture.asset(CustomIcons.exploreUnselected)),
                  ),
                  SizedBox(
                    height: 70,
                    width: 40,
                    child: Center(
                        child: currentPage == 2
                            ? SvgPicture.asset(CustomIcons.message)
                            : SvgPicture.asset(CustomIcons.message)),
                  ),
                  SizedBox(
                    height: 70,
                    width: 40,
                    child: Center(
                        child: currentPage == 3
                            ? SvgPicture.asset(CustomIcons.me)
                            : SvgPicture.asset(CustomIcons.meUnselected)),
                  ),

                ],
              ),
              // Positioned(
              //   right: 10,
              //   child: FloatingActionButton(
              //     onPressed: () {
              //       tabController.index = 4;
              //     },
              //     child: Icon(Icons.add),
              //   ),
              // )
            ],
          ),
        ),
      ),
    );
  }
}
