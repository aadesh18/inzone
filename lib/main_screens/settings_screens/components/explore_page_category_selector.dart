import 'package:flutter/material.dart';
import 'package:inzone/data/string_extension.dart';


class ExplorePageCategorySelector extends StatefulWidget {
List<String> categoryList = [];
Function(String) onTap;
   ExplorePageCategorySelector({super.key, required this.categoryList, required this.onTap}) ;

  @override
  _ExplorePageCategorySelectorState createState() =>
      _ExplorePageCategorySelectorState();
}


class _ExplorePageCategorySelectorState
    extends State<ExplorePageCategorySelector> {


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

  @override
  void initState() {
    // TODO: implement initState
    widget.categoryList = [...{...widget.categoryList}];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 10),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
            children: List.generate(widget.categoryList.length, (index) {
          String category = widget.categoryList[index];
          bool isSelected = index == selectedCategoryIndex;
          return GestureDetector(
            onTap: () {
              setState(() {
                selectedCategoryIndex = index;
              });
              widget.onTap(widget.categoryList[index]);
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 150),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: isSelected ? Colors.black : Colors.white),
              padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 15),
              margin: const EdgeInsets.symmetric(horizontal: 2),
              child: Text(
                replaceAndCapitalize(category),
                style: TextStyle(
                    fontSize: 15,
                    color: isSelected ? Colors.white : Colors.black),
              ),
            ),
          );
        })),
      ),
    );
  }
}
