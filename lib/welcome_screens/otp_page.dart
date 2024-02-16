// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:inzone/backend/phone_auth_backend.dart';
import 'package:inzone/constants.dart';
import 'package:inzone/main_screens/root_app.dart';
import 'package:pinput/pinput.dart';

class OTPPage extends StatefulWidget {
  static String phoneNumber = "";
  String? errorMessage;

  OTPPage({super.key, String? this.errorMessage});

  @override
  _OTPPageState createState() => _OTPPageState();
}

class _OTPPageState extends State<OTPPage> {
  //FirebaseMethods firebaseMethods = FirebaseMethods();
  String codeEntered = "", verificationCode = "";
  PinTheme defaultPinTheme = PinTheme(
    width: 56,
    height: 56,
    textStyle: const TextStyle(
        fontSize: 20, color: Colors.black, fontWeight: FontWeight.w600),
    decoration: BoxDecoration(
      color: Colors.black.withOpacity(0.2),
      borderRadius: const BorderRadius.all(Radius.circular(20)),
    ),
  );

  late PinTheme focusedPinTheme = defaultPinTheme.copyDecorationWith(
    border: Border.all(color: Colors.indigo.shade500),
    borderRadius: BorderRadius.circular(8),
  );

  late PinTheme submittedPinTheme = defaultPinTheme.copyWith(
    decoration: defaultPinTheme.decoration?.copyWith(
      color: const Color(0xffDFF6FF),
    ),
  );

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back_ios,
            size: 30,
            color: Colors.black,
          ),
        ),
        title: const Text(
          "Verify phone",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: backgroundColor,
          ),
        ),
        backgroundColor: backgroundColor,
        elevation: 0,
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Container(
                color: backgroundColor,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 8.0),
                      child: Text(
                       widget.errorMessage == null? "Text code is sent to ${OTPPage.phoneNumber}" : widget.errorMessage!,
                        style:  widget.errorMessage == null? const TextStyle(
                          fontSize: 22,
                          color: Color(0xff818181),
                        ) : const TextStyle(
                          fontSize: 22,
                          color: Colors.red,
                        )
                      ),
                    ),
                    Expanded(
                        child: Pinput(
                      length: 6,
                      defaultPinTheme: defaultPinTheme,
                      focusedPinTheme: focusedPinTheme,
                      submittedPinTheme: submittedPinTheme,
                      showCursor: true,
                      autofocus: true,
                      onChanged: (pin){
                        codeEntered = pin;
                      },

                    )),
                    const Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 14, horizontal: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "New Code will be sent in: ",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0xff818181),
                            ),
                          ),
                          Text(
                            "60 seconds",
                            textAlign: TextAlign.center,
                            style: TextStyle(),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.13,
              decoration: const BoxDecoration(
                  color: backgroundColor,
                  borderRadius: BorderRadius.all(Radius.circular(25))),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Expanded(
                        child: GestureDetector(
                      onTap: () {
                        // Navigator.push(context,
                        //     MaterialPageRoute(builder: (context) => const RootApp()));
                        // await firebaseMethods
                        //     .otpManualVerification(
                        //         Future<String>.value, codeEntered)
                        //     .then((value) {
                        //   if (value == Future<bool>.value(true)) {
                        //     print("LOGGED IN");
                        //     Navigator.push(
                        //         context,
                        //         MaterialPageRoute(
                        //             builder: (context) => RegisterPage()));
                        //   } else {
                        //     print("Not proceeding forward");
                        //   }
                        // });
                        PhoneAuthBackEnd.of(context)!.triggerOTPEntered(codeEntered);
                      },
                      child: Container(
                        decoration: const BoxDecoration(
                            color: Colors.blue,
                            borderRadius:
                                BorderRadius.all(Radius.circular(15))),
                        child: const Center(
                          child: Text(
                            "Verify and Create Account",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ))
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget codeBox(codeNumber) {
  //   TextEditingController _controller = TextEditingController();
  //   return Container(
  //     height: 50,
  //     width: 50,
  //     margin: EdgeInsets.only(right: 8),
  //     decoration: BoxDecoration(
  //       color: Colors.white,
  //       borderRadius: BorderRadius.all(Radius.circular(15)),
  //       boxShadow: <BoxShadow>[
  //         BoxShadow(
  //           color: Colors.black26,
  //           blurRadius: 15.0,
  //           spreadRadius: 1,
  //           offset: Offset(0.0, 0.75),
  //         )
  //       ],
  //     ),
  //     child: TextField(
  //       controller: _controller,
  //       showCursor: true,
  //       maxLength: 1,
  //       autofocus: true,
  //       textAlign: TextAlign.center,
  //       textInputAction: TextInputAction.next,
  //       decoration: InputDecoration(
  //         fillColor: Colors.white,
  //         border: InputBorder.none,
  //         counterText: "",
  //       ),
  //       keyboardType: TextInputType.number,
  //       onChanged: (value) {
  //         _controller.addListener(() {});
  //         // FocusScope.of(context).nextFocus();
  //       },
  //       style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
  //     ),
  //   );
  // }

  // Widget buildCodeNumberBox() {
  //   return Padding(
  //     padding: EdgeInsets.symmetric(horizontal: 6.0),
  //     child: SizedBox(
  //       width: MediaQuery.of(context).size.width / 8,
  //       height: 60,
  //       child: Container(
  //           decoration: BoxDecoration(
  //             color: Color(0xfff6f5fa),
  //             borderRadius: BorderRadius.all(Radius.circular(15)),
  //             boxShadow: <BoxShadow>[
  //               BoxShadow(
  //                 color: Colors.black26,
  //                 blurRadius: 25.0,
  //                 spreadRadius: 1,
  //                 offset: Offset(0.0, 0.75),
  //               )
  //             ],
  //           ),
  //           child: TextFieldWithOnlyHintText(
  //             hintText: "",
  //           )),
  //     ),
  //   );
  // }
}
