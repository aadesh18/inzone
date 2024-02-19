import 'package:flutter/material.dart';
import 'package:inzone/data/inzone_category_list.dart';
import 'package:inzone/data/inzone_current_user.dart';
import 'package:inzone/main_screens/components/category_selector.dart';

class CategorySelectorBar extends StatefulWidget {


  List<Widget>  categories = [];
   CategorySelectorBar({
    super.key,
     required this.categories
  });

  @override
  State<CategorySelectorBar> createState() => _CategorySelectorBarState();
}

class _CategorySelectorBarState extends State<CategorySelectorBar> {
  // List<Widget>  categories = [];
  // List<Widget> _getCategoryList() {
  //   List<CategorySelector> categorySelectorList = [];
  //   for (var element in InZoneCurrentUser.subCategories) {
  //     print(element.categoryName);
  //     element.categoryIconPath = "icons/category_icons/${element.categoryName}.svg";
  //     //element.categoryIconPath = "icons/category_icons/artoons.svg";
  //     categorySelectorList.add(CategorySelector(category: element, ));
  //   }
  //   setState(() {
  //     categories.reversed;
  //   });
  //   return categorySelectorList;
  // }

  @override
  void initState() {
    // TODO: implement initState
   // categories = _getCategoryList();
    super.initState();
  }

  // temp(){
  //   categories = _getCategoryList();
  //   setState(() {
  //     categories.reversed;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    // categories.clear();
    // temp();

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
          children: widget.categories),
    );
  }
}
