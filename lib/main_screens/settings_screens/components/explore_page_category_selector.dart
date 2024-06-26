import 'package:flutter/material.dart';

class ExplorePageCategorySelector extends StatefulWidget {
  const ExplorePageCategorySelector({Key? key}) : super(key: key);

  @override
  _ExplorePageCategorySelectorState createState() =>
      _ExplorePageCategorySelectorState();
}

class _ExplorePageCategorySelectorState
    extends State<ExplorePageCategorySelector> {
  List categories = [
    "Sports",
    "Movies",
    "Biology",
    "Music",
    "Sports",
    "Movies",
    "Biology",
    "Music",
  ];
  int selectedCategoryIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 10),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
            children: List.generate(categories.length, (index) {
          String category = categories[index];
          bool isSelected = index == selectedCategoryIndex;
          return GestureDetector(
            onTap: () {
              setState(() {
                selectedCategoryIndex = index;
              });
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 150),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: isSelected ? Colors.black : Colors.white),
              padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 15),
              margin: const EdgeInsets.symmetric(horizontal: 2),
              child: Text(
                category,
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
