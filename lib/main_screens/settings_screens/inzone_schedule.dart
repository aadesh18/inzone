import 'package:flutter/material.dart';
import 'package:inzone/main_screens/settings_screens/components/daytime_selector.dart';
import 'package:inzone/main_screens/settings_screens/components/settings_page_skeleton.dart';
class InZoneSchedule extends StatefulWidget {
  const InZoneSchedule({super.key});

  @override
  State<InZoneSchedule> createState() => _InZoneScheduleState();
}

class _InZoneScheduleState extends State<InZoneSchedule> {
  @override
  Widget build(BuildContext context) {
    return SettingsPageSkeleton(
        title: "InZone Schedule",
        subtitle: "Choose a mood, and set the days and the time for it ",
        child: Column(
          children: [
            DayTimeSelector(
              title: "Focus",
              subtitle:
                  "At work or at school, your social media should be a tool that boosts your performance rather than distracting you. ",
              startValue: 9.0,
              endValue: 17.0,
            ),
            SizedBox(
              height: 20,
            ),
            DayTimeSelector(
              title: "Fall Back",
              subtitle:
                  "After a long day, enjoy the most fun and distressing content on social media to recharge your batteries. You deserve it.",
              startValue: 17.0,
              endValue: 22.0,
            ),
            SizedBox(
              height: 20,
            ),
            DayTimeSelector(
              title: "Custom",
              subtitle:
                  "After a long day, enjoy the most fun and distressing content on social media to recharge your batteries. You deserve it.",
              startValue: 0.0,
              endValue: 24.0,
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ));
  }
}
