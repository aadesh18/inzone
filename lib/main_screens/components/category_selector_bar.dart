import 'package:flutter/material.dart';
import 'package:inzone/data/inzone_category_list.dart';
import 'package:inzone/main_screens/components/category_selector.dart';

class CategorySelectorBar extends StatelessWidget {
  CategorySelectorBar({
    super.key,
  });

  List<Widget> _getCategoryList() {
    List<CategorySelector> _categorySelectorList = [];
    inzone_category_list.forEach((element) {
      _categorySelectorList.add(CategorySelector(category: element));
    });
    return _categorySelectorList;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: _getCategoryList()),
    );
  }
}
