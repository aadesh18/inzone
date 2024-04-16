import 'package:flutter/material.dart';
import 'package:inzone/data/string_extension.dart';
class InZoneCategory {
  final String categoryName;
  String? categoryIconPath;
  final Color? startColor;
  final Color? endColor;
  final int index;
  final List<Color> startColorList = [
    const Color(0xff8674ED),
    const Color(0xff26DD90),
    const Color(0xffFFCB8D),
    const Color(0xff8674ED),
    const Color(0xff8674ED),
    const Color(0xff26DD90),
    const Color(0xffFFCB8D),
  ];
  final List<Color> endColorList = [
    const Color(0xff6048DA),
    const Color(0xff0EB16D),
    const Color(0xffFFB26A),
    const Color(0xff6048DA),
    const Color(0xff6048DA),
    const Color(0xff0EB16D),
    const Color(0xffFFB26A)
  ];

  InZoneCategory(
      {required this.categoryName,
      required this.index,
      this.categoryIconPath,
      this.startColor,
      this.endColor});

  String replaceAndCapitalize(String text) {
    // Split the text into words based on underscores.
    if (text.contains("_")){
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
  String getCategoryName() {
    return replaceAndCapitalize(categoryName);
  }

  String? getIconPath() => categoryIconPath;
  Color getStartColor() {
    try {
      print("get stat color");
      print(index);
      return startColorList.elementAt(index);
    } catch (e){
      return startColorList.elementAt(0);
    }

  }

  Color getEndColor() {
    try {
      return endColorList.elementAt(index);
    } catch (e){
      return endColorList.elementAt(0);
    }
  }
}
