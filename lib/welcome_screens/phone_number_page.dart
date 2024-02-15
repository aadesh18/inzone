import 'package:flutter/material.dart';
import 'package:inzone/constants.dart';
import 'package:inzone/welcome_screens/email_login.dart';
import 'package:inzone/welcome_screens/otp_page.dart';
import 'package:lottie/lottie.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:firebase_ui_auth/src/providers/phone_auth_provider.dart' as PhoneAuthP;

import '../backend/phone_auth_backend.dart';

class PhoneNumberPage extends StatefulWidget {
  PhoneNumberPage({super.key});

  @override
  _PhoneNumberPageState createState() => _PhoneNumberPageState();
}

class _PhoneNumberPageState extends State<PhoneNumberPage> {
  String phoneNumber = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: Container(
        color: backgroundColor,
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                "Let's get you back InZone",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, color: Colors.black),
              ),
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(color: backgroundColor),
                  child: Column(
                    children: [
                      SizedBox(
                          height: 160,
                          width: 160,
                          child: Lottie.asset(
                              "assets/animations/otp_animation.json")),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 64, vertical: 14),
                        child: Text(
                          "You will receive a 6 digit code to verify next",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: MediaQuery.of(context).size.height / 45,
                              color: const Color(0xff818181)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const EmailLogInPage()));
                },
                child: const Text(
                  "Use e-mail or username",
                  style: TextStyle(
                      fontSize: 17, decoration: TextDecoration.underline),
                ),
              ),
              const SizedBox(
                height: 13,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.13,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                "Enter your phone number",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey,
                                ),
                              ),
                              const SizedBox(width: 8),
                              InternationalPhoneNumberInput(
                                  inputBorder: InputBorder.none,
                                  initialValue: PhoneNumber(isoCode: "US"),
                                  keyboardAction: TextInputAction.next,
                                  autoFocus: true,
                                  //scrollPadding: const EdgeInsets.all(8),
                                  selectorConfig: const SelectorConfig(
                                      selectorType:
                                          PhoneInputSelectorType.BOTTOM_SHEET,
                                      leadingPadding: 0,
                                      showFlags: false,
                                      trailingSpace: false),
                                  spaceBetweenSelectorAndTextField: 1,
                                  hintText: "1234567890",
                                  autoValidateMode: AutovalidateMode.disabled,
                                  ignoreBlank: false,

                                  onInputChanged: (value) {
                                    print(value);
                                    phoneNumber = value.phoneNumber!;

                                  })
                              // TextFieldWithOnlyHintText(hintText: "+911234567890")
                            ],
                          ),
                        ),
                        // SizedBox(
                        //   width: 8,
                        // ),
                        Expanded(
                          flex: 1,
                          child: GestureDetector(
                            onTap: () {
                              OTPPage.phoneNumber = phoneNumber;
                              print(phoneNumber);
                              PhoneAuthBackEnd.of(context)!.setPhoneNumber(phoneNumber);
                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: (context) => const OTPPage()));
                            },
                            child: Container(
                              decoration: const BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15))),
                              child: const Center(
                                child: Text(
                                  "Continue",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
