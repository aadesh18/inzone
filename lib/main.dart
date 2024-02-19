import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inzone/firebase_options.dart';
import 'package:inzone/welcome_screens/splash_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'InZone',
      theme: ThemeData(
        textTheme: GoogleFonts.latoTextTheme(textTheme),
        primarySwatch: Colors.blue,
      ),
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return SplashPage(loggedIn: true
              ,);
          } else {
            return SplashPage(loggedIn: false,);
          }
        },
      ),
    );
  }
}
//
// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key, required this.title});
//   final String title;
//
//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//   @override
//   Widget build(BuildContext context) {
//     final textTheme = Theme.of(context).textTheme;
//     return MaterialApp(
//       // To-do - Add Permitted orientations
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//           scaffoldBackgroundColor: backgroundColor,
//           visualDensity: VisualDensity.adaptivePlatformDensity,
//           textTheme: GoogleFonts.latoTextTheme(textTheme).copyWith(
//               bodyMedium: GoogleFonts.lato(
//                   textStyle: const TextStyle(color: Colors.black)))),
//       home: SplashPage(),
//     );
//   }
// }
