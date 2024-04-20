import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'comment_model.dart';

//button widget...
class ButtonWidget extends StatelessWidget {
  final Function()? onPressed;
  final String text;
  final double width;
  final double height;
  final double elevation;
  final double fontSize;
  final Color btnColor;
  final Color textColor;
  final Color borderColor;
  final double borderRadius;
  final double padding;
  final FontWeight fontWeight;

  const ButtonWidget({
    Key? key,
    required this.text,
    this.width = double.infinity,
    this.height = 56,
    this.elevation = 0,
    this.fontSize = 18,
    this.onPressed,
    this.btnColor = Colors.blue,
    this.textColor = Colors.white,
    this.borderColor = Colors.blue,
    this.borderRadius = 25,
    this.padding = 0,
    this.fontWeight = FontWeight.w700,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: MaterialButton(
        onPressed: onPressed,
        height: height,
        minWidth: width,
        elevation: elevation,
        color: btnColor,
        disabledColor: borderColor,
        padding: EdgeInsets.all(padding),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          side: BorderSide(
            color: borderColor,
            width: 1,
          ),
        ),
        child: Center(
          child: Text(
            text,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: textColor,
              fontSize: fontSize,
              fontWeight: fontWeight,
              overflow: TextOverflow.ellipsis,
              letterSpacing: -0.3,
            ),
          ),
        ),
      ),
    );
  }
}

//comment list items widget...
class CommentListItemsWidget extends StatelessWidget {
  final String image, name, comment, reply, like, time;
  final bool isShowReply;
  final Function()? onCommentPressed;

  const CommentListItemsWidget({
    Key? key,
    required this.image,
    required this.comment,
    required this.name,
    required this.reply,
    required this.like,
    this.isShowReply = true,
    required this.time,
    this.onCommentPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 20, bottom: 20),
      // margin: const EdgeInsets.only(bottom: 20),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Color(0xFFD9D9D9),
            width: 0.5,
          ),
        ),
      ),
      child: Center(
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Column(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: AssetImage(image),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  if (isShowReply)
                    Flexible(
                      flex: 3,
                      child: Container(
                        width: 0.5,
                        color: const Color(0xFFD9D9D9),
                        margin: const EdgeInsets.symmetric(vertical: 10),
                      ),
                    ),
                  if (isShowReply)
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Container(
                          height: 20,
                          width: 20,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: AssetImage(image),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Container(
                          height: 20,
                          width: 20,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: AssetImage(image),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ],
                    ),
                ],
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Text(
                            name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Text(
                          time,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        IconButtonWidget(
                          icon: SvgPicture.asset(
                            "assets/app_icons/menu.svg",
                            height: 26,
                            width: 26,
                            colorFilter: const ColorFilter.mode(
                              Colors.black,
                              BlendMode.srcIn,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      comment,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        IconButtonWidget(
                          icon: SvgPicture.asset(
                            "assets/app_icons/heart.svg",
                            height: 26,
                            width: 26,
                            colorFilter: const ColorFilter.mode(
                              Colors.black,
                              BlendMode.srcIn,
                            ),
                          ),
                        ),
                        IconButtonWidget(
                          onPressed: onCommentPressed,
                          icon: SvgPicture.asset(
                            "assets/app_icons/message.svg",
                            height: 26,
                            width: 26,
                            colorFilter: const ColorFilter.mode(
                              Colors.black,
                              BlendMode.srcIn,
                            ),
                          ),
                        ),
                        IconButtonWidget(
                          icon: SvgPicture.asset(
                            "assets/app_icons/repeat.svg",
                            height: 26,
                            width: 26,
                            colorFilter: const ColorFilter.mode(
                              Colors.black,
                              BlendMode.srcIn,
                            ),
                          ),
                        ),
                        IconButtonWidget(
                          icon: SvgPicture.asset(
                            "assets/app_icons/send.svg",
                            height: 26,
                            width: 26,
                            colorFilter: const ColorFilter.mode(
                              Colors.black,
                              BlendMode.srcIn,
                            ),
                          ),
                        ),
                      ],
                    ),
                    if (isShowReply)
                      InkWell(
                        onTap: onCommentPressed,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Text(
                              "$reply replies",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Container(
                              height: 3,
                              width: 3,
                              color: const Color(0xFFD9D9D9),
                              margin: const EdgeInsets.symmetric(horizontal: 5),
                            ),
                            Text(
                              "$like likes",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

//icon button widget...
class IconButtonWidget extends StatelessWidget {
  final Function()? onPressed;
  final Widget icon;

  const IconButtonWidget({
    Key? key,
    this.onPressed,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      hoverColor: Colors.transparent,
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      icon: icon,
    );
  }
}
