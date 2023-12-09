import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_floating_bottom_bar/flutter_floating_bottom_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:inzone/constants.dart';
import 'package:inzone/main_screens/all_chats_screen.dart';
import 'package:inzone/main_screens/custom_icons.dart';
import 'package:inzone/main_screens/explore_screen.dart';
import 'package:inzone/main_screens/home_screen.dart';
import 'package:inzone/main_screens/me_screen.dart';
import 'package:inzone/main_screens/post_screen.dart';

class RootApp extends StatefulWidget {
  RootApp({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _RootAppState createState() => _RootAppState();
}

class _RootAppState extends State<RootApp> with SingleTickerProviderStateMixin {
  late int currentPage;
  late TabController tabController;

  @override
  void initState() {
    currentPage = 0;
    tabController = TabController(length: 5, vsync: this);
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
    return SafeArea(
      child: Scaffold(
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
          duration: Duration(milliseconds: 500),
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
                PostScreen()
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
                    insets: EdgeInsets.fromLTRB(16, 0, 16, 8)),
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
                  SizedBox(
                    height: 70,
                    width: 40,
                  ),
                ],
              ),
              Positioned(
                right: 10,
                child: FloatingActionButton(
                  onPressed: () {
                    tabController.index = 4;
                  },
                  child: Icon(Icons.add),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
