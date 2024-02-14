import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:inzone/data/inzone_category.dart';

class CategorySelector extends StatelessWidget {
  final InZoneCategory category;

  const CategorySelector({
    super.key,
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [category.startColor!, category.endColor!],
            )),
        child: Row(
          children: [
            category.categoryIconPath == null
                ? const SizedBox()
                : SvgPicture.asset(category.categoryIconPath!),
            const SizedBox(
              width: 2,
            ),
            Text(
              category.getCategoryName(),
              style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                  color: Colors.white),
            ),
            const SizedBox(
              height: 10,
            )
          ],
        ),
      ),
    );
  }
}
