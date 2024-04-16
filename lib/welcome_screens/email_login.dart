import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:inzone/backend/database.dart';
import 'package:inzone/constants.dart';
import 'package:inzone/data/inzone_current_user.dart';
import 'package:inzone/main_screens/root_app.dart';
import 'package:sign_button/sign_button.dart';

class EmailLogInPage extends StatefulWidget {
  EmailLogInPage({super.key});

  @override
  State<EmailLogInPage> createState() => _EmailLogInPageState();
}

class _EmailLogInPageState extends State<EmailLogInPage> {
  String? email;

  String? password;

  String? errorMessage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Icon(
                Icons.arrow_back_ios_rounded,
                size: 25,
                color: Colors.black,
              ),
            ),
            const Text(
              "Welcome Back",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            const SizedBox(
              width: 20,
            )
          ],
        ),
        backgroundColor: backgroundColor,
        elevation: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Center(
                  child: Text(
                    "Let's get you back InZone",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18, color: Colors.black),
                  ),
                ),
                const Text(
                  "E-mail",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 10,
                ),
                 TextField(
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      labelText: 'E-mail',
                      hintText: 'something@example.com'),
                  onChanged: (value) {
                    setState(() {
                      email = value;
                    });

                  },
                ),
                const SizedBox(
                  height: 30,
                ),
                const Text("Password",
                    style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(
                  height: 10,
                ),
                 TextField(
                  obscureText: true,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      labelText: "Password",
                      hintText: "Password"),
                  onChanged: (value) {
                    setState(() {
                      password = value;
                    });

                  },
                ),
                const SizedBox(
                  height: 30,
                ),
                Center(
                  child: ElevatedButton(
                      onPressed: () async {
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => PhoneNumberPage()));
                        if (email == null  || password == null){
                          setState(() {
                            errorMessage = "Please fill all fields!";
                          });
                        }  else {
                          try {
                            final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
                              email: email!,
                              password: password!,
                            ).then((value) async {
                              InZoneCurrentUser? curr = await InZoneDatabase.getUserData(email!);
                              currentUser = curr!;
                              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => RootApp()));
                            });
                          } on FirebaseAuthException catch (e) {

                              errorMessage = e.message;

                          }
                        }

                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          elevation: 10,
                          //elevation of button
                          shape: RoundedRectangleBorder(
                              //to set border radius to button
                              side: const BorderSide(
                                  width: 1, color: Colors.blue),
                              borderRadius: BorderRadius.circular(30)),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 120,
                              vertical: 20) //content padding inside button
                          ),
                      child: const Text(
                        "Log in",
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      )),
                ),
                const SizedBox(
                  height: 30,
                ),
                errorMessage == null ? SizedBox() : Text(errorMessage!, style: TextStyle(color: Colors.red, fontSize: 15, ),)
                // const Padding(
                //   padding: EdgeInsets.all(8.0),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.center,
                //     children: [
                //       Expanded(
                //           child: Divider(
                //         thickness: 1.2,
                //         color: Colors.black,
                //       )),
                //       Padding(
                //         padding: EdgeInsets.all(8.0),
                //         child: Text("or", style: TextStyle(fontSize: 18)),
                //       ),
                //       Expanded(
                //           child: Divider(
                //         thickness: 1.2,
                //         color: Colors.black,
                //       ))
                //     ],
                //   ),
                // ),
                // const SizedBox(
                //   height: 20,
                // ),
                // Row(
                //   crossAxisAlignment: CrossAxisAlignment.center,
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     SignInButton.mini(
                //       buttonType: ButtonType.facebook,
                //       buttonSize: ButtonSize.large,
                //       onPressed: () {},
                //     ),
                //     SignInButton.mini(
                //       buttonType: ButtonType.google,
                //       buttonSize: ButtonSize.large,
                //       onPressed: () {},
                //     ),
                //     SignInButton.mini(
                //       buttonType: ButtonType.twitter,
                //       buttonSize: ButtonSize.large,
                //       onPressed: () {},
                //     ),
                //   ],
                // )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
