import 'package:flutter/material.dart';
import 'package:inzone/data/inzone_category.dart';
import 'package:inzone/data/inzone_category_list.dart';
import 'package:inzone/data/inzone_current_user.dart';
import 'package:inzone/main_screens/components/category_selector.dart';
import 'package:inzone/data/string_extension.dart';

class CategorySelectorBar extends StatefulWidget {


  List<String>  categories = [];
  Function(String) onTap;
   CategorySelectorBar({
    super.key,
     required this.categories,
     required this.onTap
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
    Set<String> set = Set<String>.from(widget.categories);
    widget.categories = set.toList();
    super.initState();
  }

  // temp(){
  //   categories = _getCategoryList();
  //   setState(() {
  //     categories.reversed;
  //   });
  // }

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

  int selectedCategoryIndex = 0;
  int colorIndex = -1;

  @override
  Widget build(BuildContext context) {
    // categories.clear();
    // temp();



    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Container(
        padding: const EdgeInsets.only(left: 10),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
              children: List.generate(widget.categories.length, (index) {
                String category = widget.categories[index];
                bool isSelected = index == selectedCategoryIndex;
                if (colorIndex == 6){
                  colorIndex =0;
    }else {colorIndex++;
    }

                  return GestureDetector(
                      onTap: ()
                       {
                    setState(() {
                      selectedCategoryIndex = index;
                    });
                  },
                  child: CategorySelector(category: InZoneCategory(categoryName: replaceAndCapitalize(category), index: colorIndex, categoryIconPath: "icons/category_icons/${category}.svg"), onTap: widget.onTap,)
                );
              })),
        ),
      ),
    );
  }
}
