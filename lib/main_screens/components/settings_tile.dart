import 'package:flutter/material.dart';

class SettingsTile extends StatelessWidget {
  SettingsTile(
      {super.key,
      required this.title,
      required this.imagePath,
      required this.onPressed});
  String title;
  String imagePath;
  VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      trailing: const Icon(
        Icons.arrow_forward_ios,
        color: Colors.black,
      ),
      leading: Image.asset(imagePath),
      onTap: onPressed,
    );
  }
}
