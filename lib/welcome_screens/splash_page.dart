import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inzone/constants.dart';
import 'package:inzone/main_screens/root_app.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Setting the constants present in the constants file for the screen size
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return AnimatedSplashScreen(
      duration: 2000,
      splash: Column(
        children: [
          Text("InZone",
              style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold, fontSize: 35, height: 1.2)),
          // const SizedBox(
          //   height: 3,
          // ),
          // const Text(
          //   "Curate your digital world with ease",
          //   style: TextStyle(fontSize: 20),
          // )
        ],
      ),
      backgroundColor: backgroundColor,
      nextScreen: const RootApp(),
    );
  }
}
