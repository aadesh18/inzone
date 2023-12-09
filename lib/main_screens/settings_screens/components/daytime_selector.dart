import 'package:flutter_util_widgets/flutter_util_widgets.dart';
import 'package:flutter/material.dart';
import 'package:inzone/constants.dart';
import 'package:inzone/main_screens/settings_screens/components/days_selector.dart';

class DayTimeSelector extends StatefulWidget {
  final String title;
  final String subtitle;
  double startValue;
  double endValue;

  DayTimeSelector(
      {super.key,
      required this.title,
      required this.subtitle,
      required this.startValue,
      required this.endValue});

  @override
  State<DayTimeSelector> createState() => _DayTimeSelectorState();
}

class _DayTimeSelectorState extends State<DayTimeSelector> {
  List<String> days = [];
  double _startValue = 0.0;
  double _endValue = 24.0;

  setCustomTiming() {
    _startValue = widget.startValue;
    _endValue = widget.endValue;
  }

  String timeCoverter(double hrs) {
    String convertedTime = "";
    int roundedHrs = hrs.floor();
    if (roundedHrs == 0) {
      convertedTime = "${roundedHrs + 12} a.m.";
    } else if (roundedHrs >= 1 && roundedHrs <= 11) {
      convertedTime = "$roundedHrs a.m.";
    } else if (roundedHrs == 12) {
      convertedTime = "$roundedHrs p.m.";
    } else if (roundedHrs >= 13 && roundedHrs <= 23) {
      convertedTime = "${roundedHrs - 12} p.m.";
    } else {
      convertedTime = "12 a.m.";
    }

    return convertedTime;
  }

  @override
  Widget build(BuildContext context) {
    setCustomTiming();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.title,
            style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 23,
                color: Colors.transparent,
                decorationColor: Colors.black,
                shadows: [Shadow(color: Colors.black, offset: Offset(0, -4))],
                decoration: TextDecoration.underline,
                decorationThickness: 1),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(widget.subtitle),
          const SizedBox(
            height: 20,
          ),
          Container(
            height: 110,
            padding: const EdgeInsets.all(8.0),
            width: double.infinity,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: Colors.blue),
                boxShadow: const [
                  BoxShadow(
                      color: Colors.grey,
                      blurRadius: 2,
                      spreadRadius: 2,
                      offset: Offset(6, 6))
                ]),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                DaysSelector.rect(
                  height: 1,
                  optionWidth: 60,
                  multiple: true,
                  values: days,
                  options: const [
                    "Sun",
                    "Mon",
                    "Tue",
                    "Wed",
                    "Thu",
                    "Fri",
                    "Sat",
                  ],
                  activeColor: Colors.amber,
                  disabledColor: backgroundColor,
                  valueLabelStyle: const TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                  toggleOptionOnTap: true,
                  separatorWidth: 10.0,
                  allCurved: true,
                  contentPadding: const EdgeInsets.all(1),
                  onValuesChanged: (List<String> values) {
                    setState(() {
                      days = values;
                    });
                  },
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    const SizedBox(
                      width: 3,
                    ),
                    Text(
                      timeCoverter(_startValue),
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Expanded(
                      child: RangeSlider(
                        min: 0.0,
                        max: 24.0,
                        activeColor: Colors.blue,
                        inactiveColor: Colors.grey,
                        values: RangeValues(_startValue, _endValue),
                        onChanged: (values) {
                          setState(() {
                            _startValue = values.start;
                            _endValue = values.end;
                          });
                        },
                      ),
                    ),
                    Text(
                      timeCoverter(_endValue),
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
