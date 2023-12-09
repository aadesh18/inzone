import 'package:flutter/material.dart';

class InZoneCategory {
  final String categoryName;
  final String? categoryIconPath;
  final Color? startColor;
  final Color? endColor;

  const InZoneCategory(
      {required this.categoryName,
      this.categoryIconPath,
      required this.startColor,
      required this.endColor});

  String getCategoryName() => categoryName;
  String? getIconPath() => categoryIconPath;
  Color? getStartColor() => startColor;
  Color? getEndColor() => endColor;
}
