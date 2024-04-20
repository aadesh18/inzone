// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_ui_auth/firebase_ui_auth.dart';
// import 'package:firebase_auth_platform_interface/src/providers/phone_auth.dart' hide PhoneAuthProvider;
// import 'package:firebase_ui_auth/src/providers/phone_auth_provider.dart' as PhoneAuthP;
// import 'package:flutter/material.dart';
// import 'package:inzone/main_screens/root_app.dart';
// import 'package:inzone/welcome_screens/otp_page.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:inzone/welcome_screens/phone_number_page.dart';
//
// class PhoneAuthBackEnd extends StatefulWidget {
//   const PhoneAuthBackEnd({super.key});
//
//   @override
//   State<PhoneAuthBackEnd> createState() => PhoneAuthBackEndState(auth: FirebaseAuth.instance);
//
//   static PhoneAuthBackEndState? of(BuildContext context) =>
//       context.findAncestorStateOfType<PhoneAuthBackEndState>();
// }
//
// class PhoneAuthBackEndState extends State<PhoneAuthBackEnd> implements PhoneAuthListener {
//   @override
//   final FirebaseAuth auth;
//
//   PhoneAuthBackEndState({required this.auth});
//
// @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
// print(auth);
//   }
//   @override
//   // TODO: implement provider
//   PhoneAuthP.PhoneAuthProvider get provider => PhoneAuthP.PhoneAuthProvider()..authListener = this;
//
//
//
//   String? otp;
//   String? verificationId;
//   ConfirmationResult? confirmationResult;
//
//   setPhoneNumber(String value) {
//     print("Set Phone Number to value $value");
//     provider.sendVerificationCode(phoneNumber: value, action: AuthAction.signIn);
//
//   }
//
//   setOtp(String value) {
//     print("Set OTP to value $value");
//
//     provider.verifySMSCode(action: AuthAction.signIn, code: value);
//   }
//   late Widget child = PhoneNumberPage();
//
//
//   @override
//   void onCodeSent(String verificationId, [int? forceResendToken]) {
//     this.verificationId = verificationId;
//     setState(() {
//       child = OTPPage();
//     });
//
//   }
//
//   @override
//   void onConfirmationRequested(ConfirmationResult result) {
//     this.confirmationResult = result;
//   }
//
//
//   @override
//   void onSMSCodeRequested(String phoneNumber) {
// setState(() {
//   child = CircularProgressIndicator();
// });
//   }
//
//
//   @override
//   void onVerificationCompleted(PhoneAuthCredential credential) {
//     provider.onCredentialReceived(credential, AuthAction.signIn);
//     print("Verification Completed");
//   }
//
//
//
//   @override
//   void onBeforeCredentialLinked(AuthCredential credential) {
//     setState(() {
//       child = CircularProgressIndicator();
//     });
//   }
//
//   @override
//   void onBeforeProvidersForEmailFetch() {
//     setState(() {
//       child = CircularProgressIndicator();
//     });
//   }
//
//   @override
//   void onBeforeSignIn() {
//     setState(() {
//       child = CircularProgressIndicator();
//     });
//   }
//
//   @override
//   void onCanceled() {
//     setState(() {
//       child = Text("Phone verification cancelled");
//     });
//   }
//
//   @override
//   void onCredentialLinked(AuthCredential credential) {
//     Navigator.of(context).pushReplacementNamed('/profile');
//   }
//
//   @override
//   void onDifferentProvidersFound(
//       String email, List<String> providers, AuthCredential? credential) {
//     showDifferentMethodSignInDialog(
//       context: context,
//       availableProviders: providers,
//       providers: FirebaseUIAuth.providersFor(FirebaseAuth.instance.app),
//     );
//   }
//
//   @override
//   void onError(Object error) {
//     try {
//       // tries default recovery strategy
//       defaultOnAuthError(provider, error);
//     } catch (err) {
//       setState(() {
//         print(err);
//       });
//     }
//   }
//
//   @override
//   void onSignedIn(UserCredential credential) {
//     print("On Signed In $credential");
//     //Navigator.of(context).pushReplacementNamed('/profile');
//   }
//
//
//   Widget _getChild(BuildContext context) {
//     return child;
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//     return _getChild(context);
//   }
//
//   @override
//   void onCredentialReceived(AuthCredential credential) {
//     print("On Credential Recevied $credential");
//     // TODO: implement onCredentialReceived
//   }
//
//   @override
//   void onMFARequired(MultiFactorResolver resolver) {
//     print("On MFA Required $resolver ");
//     // TODO: implement onMFARequired
//   }
//
//
//
//
//
//
//   //
//   //
//   // late final PhoneAuthP.PhoneAuthProvider provider = PhoneAuthP.PhoneAuthProvider()..authListener = this;
//
// }
//
//
//


import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:inzone/main_screens/root_app.dart';
import 'package:inzone/welcome_screens/otp_page.dart';
import 'package:inzone/welcome_screens/phone_number_page.dart';

class PhoneAuthBackEnd extends StatefulWidget {
  String? verificationId;
  int? resendToken;
  PhoneAuthBackEnd({super.key, this.verificationId, this.resendToken});

  @override
  State<PhoneAuthBackEnd> createState() => PhoneAuthBackEndState();

  static PhoneAuthBackEndState? of(BuildContext context) =>
      context.findAncestorStateOfType<PhoneAuthBackEndState>();
}

class PhoneAuthBackEndState extends State<PhoneAuthBackEnd> {
  FirebaseAuth auth = FirebaseAuth.instance;

  Widget child = PhoneNumberPage();
  String? verificationId;
  int? resendToken;

  setValues(String verificationId, int? resendToken){
    widget.verificationId = verificationId;
    widget.resendToken = resendToken;
  }

  triggerPhoneNumberEntered(String phoneNumber) {
    phoneNumberEntered(phoneNumber);
  }
  triggerOTPEntered(String otp) {
    print("OTP: $otp");
    OTPEntered(otp);
  }
  Widget _getChild(){
    return child;
  }

  void phoneNumberEntered(String phoneNumber)async{
    OTPPage.phoneNumber = phoneNumber;
    print(phoneNumber);
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) async {
        await auth.signInWithCredential(credential);
      },
      verificationFailed: (FirebaseAuthException e) {


      },
      codeSent: (String verificationId, int? resendToken) {

        setState(() {
          child = OTPPage();
          setValues(verificationId, resendToken);
        });
      },
      codeAutoRetrievalTimeout: (String verificationId) {

      },
    );
  }

  void OTPEntered(String smsCode) async {

      while(widget.verificationId == null){
        print("NULL");
      }
      PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: widget.verificationId!, smsCode: smsCode);
try {
  await auth.signInWithCredential(credential);
  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => RootApp()));
}  on FirebaseAuthException catch (e ){
  setState(() {
    child = OTPPage(errorMessage: e.message);
  });
  print(e.message);
}



  }

  @override
  Widget build(BuildContext context) {
    return _getChild();
  }
}
