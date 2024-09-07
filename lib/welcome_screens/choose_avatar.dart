import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttermoji/fluttermojiCircleAvatar.dart';
import 'package:inzone/constants.dart';
import 'package:inzone/main.dart';
import 'package:lottie/lottie.dart';
import 'package:random_avatar/random_avatar.dart';

class ChooseAvatarScreen extends StatefulWidget {
  const ChooseAvatarScreen({super.key});

  @override
  State<ChooseAvatarScreen> createState() => _ChooseAvatarScreenState();
}

class _ChooseAvatarScreenState extends State<ChooseAvatarScreen> {
  String? username;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Choose from the following 6 avatars", style: TextStyle(fontWeight: FontWeight.bold),),
              const SizedBox(height: 30,),
              Wrap(
                spacing: 20.0,
                runSpacing: 80.0,
                children: [
                  GestureDetector(
                    onTap: (){
pictureName = "1";
ScaffoldMessenger.of(context).showSnackBar(
  SnackBar(
    content: Text('Selected!'),
  ),
);
                    },
                    child: Container(
                      height: 120, width: 120,
                        child: SvgPicture.asset('assets/1.svg')),
                  ),
                  GestureDetector(
                    onTap: (){
                      pictureName = "2";
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Selected!'),
                        ),
                      );
                    },
                    child: Container(
                        height: 120, width: 120,
                        child: SvgPicture.asset('assets/2.svg')),
                  ),
                  GestureDetector(
                    onTap: (){
                      pictureName = "3";
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Selected!'),
                        ),
                      );
                    },
                    child: Container(
                        height: 120, width: 120,
                        child: SvgPicture.asset('assets/3.svg')),
                  ),
                  GestureDetector(
                    onTap: (){
                      pictureName = "4";
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Selected!'),
                        ),
                      );
                    },
                    child: Container(
                        height: 120, width: 120,
                        child: SvgPicture.asset('assets/4.svg')),
                  ),     GestureDetector(
                    onTap: (){
                      pictureName = "5";
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Selected!'),
                        ),
                      );
                    },
                    child: Container(
                        height: 120, width: 120,
                        child: SvgPicture.asset('assets/5.svg')),
                  ),
                  GestureDetector(
                    onTap: (){
                      pictureName = "6";
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Selected!'),
                        ),
                      );
                    },
                    child: Container(
                        height: 120, width: 120,
                        child: SvgPicture.asset('assets/6.svg')),
                  ),

                ],
              )
            ],
            // children: [
            //   const SizedBox(
            //     height: 50,
            //   ),
            //   Center(
            //     child: RandomAvatar(
            //         username == null
            //             ? " "
            //             : username!.isEmpty
            //                 ? " "
            //                 : username!,
            //         height: 250,
            //         width: 250),
            //   ),
            //   const SizedBox(
            //     height: 50,
            //   ),
            //   Container(
            //     padding: const EdgeInsets.only(left: 10),
            //     decoration: BoxDecoration(
            //       borderRadius: BorderRadius.circular(10.0),
            //       color: Colors.white,
            //       boxShadow: [
            //         BoxShadow(
            //           color: Colors.grey.withOpacity(0.5),
            //           spreadRadius: 1,
            //           blurRadius: 3,
            //           offset: const Offset(
            //               0, 0), // Changes the position of the shadow
            //         ),
            //       ],
            //     ),
            //     child: TextField(
            //       decoration: InputDecoration(
            //         hintText: currentUser.getUserName() ?? 'Enter Username',
            //         border: InputBorder.none,
            //       ),
            //       onChanged: (value) {
            //         setState(() {
            //           username = value;
            //         });
            //
            //         currentUser.setUserName(value);
            //       },
            //     ),
            //   ),
            //   Container(
            //     height: screenHeight! / 4,
            //     child:         Center(child: Lottie.asset("assets/animations/avatar.json")),
            //   )
            // ],
          ),
        ),
      ),
    );
  }
}
