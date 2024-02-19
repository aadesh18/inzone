import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:inzone/data/inzone_category.dart';

import '../../custom_icons.dart';

class CategorySelector extends StatefulWidget {
  final InZoneCategory category;
  Function(String) onTap;

   CategorySelector({
    super.key,
    required this.category,
    required this.onTap
  });

  @override
  State<CategorySelector> createState() => _CategorySelectorState();
}

class _CategorySelectorState extends State<CategorySelector> {
  TextEditingController controller = TextEditingController();
  _getSvg(String? iconPath){
    print(iconPath);
    if (iconPath == null){
      return SizedBox();
    } else {
      try {
        return SvgPicture.asset(
          iconPath,
          height: 25,
          width: 25,
        );
      } catch (e){
        return SvgPicture.asset(
          "icons/humor_and_memes.svg",
          height: 25,
          width: 25,
        );
      }
    }

  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
onTap: (){
  String? value = widget.category.categoryName;
  widget.onTap(value);

},
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4.0),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [widget.category.getStartColor(), widget.category.getEndColor()],
              )),
          child: Row(
            children: [
          SvgPicture.asset(
            widget.category.categoryIconPath!,
            height: 25,
            width: 25,
          ),
              const SizedBox(
                width: 2,
              ),
              Text(
                widget.category.getCategoryName(),
                style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                    color: Colors.white),
              ),
               SizedBox(
                height: 10,
              )
            ],
          ),
        ),
      ),
    );
  }
}
