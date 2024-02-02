import 'package:flutter/material.dart';
import 'package:inzone/constants.dart';
import 'package:sign_button/sign_button.dart';

class EmailLogInPage extends StatelessWidget {
  const EmailLogInPage({super.key});

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
                const TextField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      labelText: 'E-mail',
                      hintText: 'something@example.com'),
                ),
                const SizedBox(
                  height: 30,
                ),
                const Text("Password",
                    style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(
                  height: 10,
                ),
                const TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      labelText: "Password",
                      hintText: "Password"),
                ),
                const SizedBox(
                  height: 30,
                ),
                Center(
                  child: ElevatedButton(
                      onPressed: () {
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => PhoneNumberPage()));
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
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Expanded(
                          child: Divider(
                        thickness: 1.2,
                        color: Colors.black,
                      )),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text("or", style: TextStyle(fontSize: 18)),
                      ),
                      Expanded(
                          child: Divider(
                        thickness: 1.2,
                        color: Colors.black,
                      ))
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SignInButton.mini(
                      buttonType: ButtonType.facebook,
                      buttonSize: ButtonSize.large,
                      onPressed: () {},
                    ),
                    SignInButton.mini(
                      buttonType: ButtonType.google,
                      buttonSize: ButtonSize.large,
                      onPressed: () {},
                    ),
                    SignInButton.mini(
                      buttonType: ButtonType.twitter,
                      buttonSize: ButtonSize.large,
                      onPressed: () {},
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
