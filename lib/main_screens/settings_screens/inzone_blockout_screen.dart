import 'package:flutter/material.dart';
import 'package:inzone/main_screens/settings_screens/components/settings_page_skeleton.dart';
import 'package:roundcheckbox/roundcheckbox.dart';

class InZoneBlockOutScreen extends StatelessWidget {
  const InZoneBlockOutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SettingsPageSkeleton(
            title: "Content BlockOut",
            subtitle:
                "Choose from this list of some of the most intriguing topics on social media",
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                BlockOutOption(
                  title: "Suicide",
                  description:
                      "This setting will block suicide content form your selected social media platforms",
                  color: Colors.blue,
                ),
                const SizedBox(
                  height: 20,
                ),
                BlockOutOption(
                  title: "Rap",
                  description:
                      "This setting will block suicide content form your selected social media platforms",
                  color: Colors.pink,
                ),
                const SizedBox(
                  height: 20,
                ),
                BlockOutOption(
                  title: "Porn/Soft Porn",
                  description:
                      "This setting will block suicide content form your selected social media platforms",
                  color: Colors.blue,
                ),
                const SizedBox(
                  height: 20,
                ),
                BlockOutOption(
                  title: "PTSD",
                  description:
                      "This setting will block suicide content form your selected social media platforms",
                  color: Colors.orange,
                ),
                const SizedBox(
                  height: 20,
                ),
                BlockOutOption(
                  title: "Suicide",
                  description:
                      "This setting will block suicide content form your selected social media platforms",
                  color: Colors.purple,
                ),
              ],
            )));
  }
}

class BlockOutOption extends StatelessWidget {
  BlockOutOption({
    super.key,
    required this.title,
    required this.description,
    required this.color,
  });
  String title;
  String description;
  Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: color,
              offset: const Offset(
                5.0,
                5.0,
              ),
              blurRadius: 5.0,
              spreadRadius: 2.0,
            ), //BoxShadow
            const BoxShadow(
              color: Colors.white,
              offset: Offset(0.0, 0.0),
              blurRadius: 0.0,
              spreadRadius: 0.0,
            ), //BoxShadow
          ],
          border: Border.all(color: color)),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                title,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const Spacer(),
              RoundCheckBox(
                size: 30,
                onTap: (selected) {},
              ),
              const SizedBox(
                width: 20,
              )
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            description,
            style: const TextStyle(fontWeight: FontWeight.normal),
          ),
        ],
      ),
    );
  }
}



