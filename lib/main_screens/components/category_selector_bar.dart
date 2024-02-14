import 'package:flutter/material.dart';
import 'package:inzone/data/inzone_category_list.dart';
import 'package:inzone/main_screens/components/category_selector.dart';

class CategorySelectorBar extends StatelessWidget {
  const CategorySelectorBar({
    super.key,
  });

  List<Widget> _getCategoryList() {
    List<CategorySelector> categorySelectorList = [];
    for (var element in inzone_category_list) {
      categorySelectorList.add(CategorySelector(category: element));
    }
    return categorySelectorList;
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
