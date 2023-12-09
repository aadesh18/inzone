import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BottomNavItem extends StatelessWidget {
  final String sourceSelected, sourceUnselected, title;
  final bool selected;
  final VoidCallback onTap;
  const BottomNavItem(
      {super.key,
      required this.onTap,
      required this.title,
      required this.sourceSelected,
      required this.sourceUnselected,
      required this.selected});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: SvgPicture.asset(
            selected ? sourceSelected : sourceUnselected,
            width: 40,
            height: 40,
          ),
        ),
        Text(title)
      ],
    );
  }
}
