import 'package:flutter/material.dart';
import 'package:inzone/data/inzone_category.dart';
import 'package:inzone/main_screens/custom_icons.dart';

final List<InZoneCategory> inzone_category_list = [
  InZoneCategory(
      categoryName: "Movies",
      categoryIconPath: CustomIcons.sports,
      startColor: Color(0xff8674ED),
      endColor: Color(0xff6048DA)),
  InZoneCategory(
      categoryName: "Humor & Memes",
      categoryIconPath: CustomIcons.humorAndMemes,
      startColor: Color(0xff26DD90),
      endColor: Color(0xff0EB16D)),
  InZoneCategory(
      categoryName: "Games",
      categoryIconPath: CustomIcons.games,
      startColor: Color(0xffFFCB8D),
      endColor: Color(0xffFFB26A)),
  const InZoneCategory(
      categoryName: "Memes",
      startColor: Color(0xff8674ED),
      endColor: Color(0xff6048DA)),
  const InZoneCategory(
      categoryName: "Biology",
      startColor: Color(0xff8674ED),
      endColor: Color(0xff6048DA)),
  const InZoneCategory(
      categoryName: "Entertainment",
      startColor: Color(0xff26DD90),
      endColor: Color(0xff0EB16D)),
  const InZoneCategory(
      categoryName: "Actors",
      startColor: Color(0xffFFCB8D),
      endColor: Color(0xffFFB26A))
];
