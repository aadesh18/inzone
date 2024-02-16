import 'package:flutter/material.dart';
import 'package:inzone/data/inzone_current_user.dart';
import 'package:inzone/data/inzone_user.dart';

const Color backgroundColor = Color(0xffdaf5ff);
double? screenHeight;
double? screenWidth;
const Color barColor = Color(0xff16202a);
const Color barSelectedColor = Color(0xff0180da);
const Color barUnselectedColor = Color(0xff819ebe);
InZoneCurrentUser currentUser = InZoneCurrentUser();

PreferredSizeWidget commonAppBar(title, height) {
  return PreferredSize(
    preferredSize: Size.fromHeight(height),
    child: AppBar(
      elevation: 0,
      automaticallyImplyLeading: false,
      backgroundColor: backgroundColor,
      title: Text(title,
          style: const TextStyle(fontSize: 26, fontWeight: FontWeight.w700)),
    ),
  );
}
