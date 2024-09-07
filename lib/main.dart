import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inzone/character_temp.dart';
import 'package:inzone/constants.dart';
import 'package:inzone/firebase_options.dart';
import 'package:inzone/welcome_screens/splash_page.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

String pictureName = "0";

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'InZone',
      theme: ThemeData(
        textTheme: GoogleFonts.figtreeTextTheme(textTheme),
        primarySwatch: Colors.blue,
        primaryColor: backgroundColor,

      ),
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return SplashPage(
              loggedIn: true,
            );
          } else {
            return SplashPage(
              loggedIn: false,
            );

          }
        },
      ),
    );
  }
}
