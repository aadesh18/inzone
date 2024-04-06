import 'package:flutter/material.dart';
import 'package:inzone/constants.dart';

class PostSlider extends StatefulWidget {
  final String afterSlideText;
  final String beforeSlideText;
  const PostSlider({super.key, required this.afterSlideText, required this.beforeSlideText});
  @override
  State<PostSlider> createState() => _PostSliderState();
}

class _PostSliderState extends State<PostSlider> {
  double translateX = 0;
  double translateY = 0;
  double myWidth = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: Colors.lightBlue.withOpacity(0.4),
        borderRadius: BorderRadius.circular(50.00),
      ),
      height: 75,
      child: GestureDetector(
        onHorizontalDragUpdate: (event) async {
          if (event.primaryDelta! > 10) {
            _incTransXVal();
          }
        },
        child: Row(
          children: [
            postSuccessful(),
            myWidth == 0.0
                ? Expanded(
              child: Center(
                child: Text(
                  widget.beforeSlideText,
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            )
                : const SizedBox()
          ],
        ),
      ),
    );
  }

  Widget postSuccessful() => Transform.translate(
    offset: Offset(translateX, translateY),
    child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.linear,
        width: 100 + myWidth,
        height: 100,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: backgroundColor),
        child: myWidth > 0.0
            ? Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.check,
              color: Colors.black,
              size: 28,
            ),
            Flexible(
              child: Text(
                widget.afterSlideText,
                style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
            )
          ],
        )
            : const Icon(
          Icons.navigate_next,
          color: Colors.black,
          size: 28,
        )),
  );

  _incTransXVal() async {
    int canLoop = -1;
    for (var i = 0; canLoop == -1; i++) {
      await Future.delayed(const Duration(milliseconds: 1), () {
        setState(() {
          if (translateX + 1 <
              MediaQuery.of(context).size.width - (118 + myWidth)) {
            translateX += 1;
            myWidth = MediaQuery.of(context).size.width - (118 + myWidth);
          } else {
            canLoop = 1;
          }
        });
      });
    }
  }
}