import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:firebase_auth_platform_interface/src/providers/phone_auth.dart' hide PhoneAuthProvider;
import 'package:firebase_ui_auth/src/providers/phone_auth_provider.dart' as PhoneAuthP;
import 'package:flutter/material.dart';
import 'package:inzone/main_screens/root_app.dart';
import 'package:inzone/welcome_screens/otp_page.dart';
import 'package:inzone/welcome_screens/phone_number_page.dart';

class PhoneAuthBackEnd extends StatefulWidget {
  const PhoneAuthBackEnd({super.key});

  @override
  State<PhoneAuthBackEnd> createState() => PhoneAuthBackEndState();

  static PhoneAuthBackEndState? of(BuildContext context) =>
      context.findAncestorStateOfType<PhoneAuthBackEndState>();
}

class PhoneAuthBackEndState extends State<PhoneAuthBackEnd> implements PhoneAuthListener {



  setPhoneNumber(String value) {
    provider.sendVerificationCode(phoneNumber: value);
    print("Set Phone Number to value $value");
  }
  setOtp(String value) {
    print("Set OTP to value $value");
    otp = value;
  }

  Widget child = PhoneNumberPage();

  String? verificationId;
  ConfirmationResult? confirmationResult;

  @override
  void onCodeSent(String verificationId, [int? forceResendToken]) {
    this.verificationId = verificationId;
    print("On Code sent $verificationId");

  }

  @override
  void onConfirmationRequested(ConfirmationResult result) {
    print("On Confirmation Requested $result");
    this.confirmationResult = result;
  }


  @override
  void onSMSCodeRequested(String phoneNumber) {
    //smsRequested(phoneNumber);
    print("On SMS Code Requested $phoneNumber");

    print("OTP: $otp");


    provider.verifySMSCode(action: AuthAction.signIn, code: otp!);
  }

  @override

  void onVerificationCompleted(PhoneAuthCredential credential) {
    print("On Verification Complete $credential");
    provider.onCredentialReceived(credential, AuthAction.signIn);

  }


  @override
  void onBeforeCredentialLinked(AuthCredential credential) {
    print("Before Credential Linked $credential");
    setState(() {
      child = CircularProgressIndicator();
    });
  }

  @override
  void onBeforeProvidersForEmailFetch() {
    print("Before Providers for Email Fetch");
    setState(() {
      child = CircularProgressIndicator();
    });
  }

  @override
  void onBeforeSignIn() {
    print("Before Sign In ");
    setState(() {
      child = CircularProgressIndicator();
    });
  }

  @override
  void onCanceled() {
    print("On Canceled");
    setState(() {
      child = Text("Phone verification cancelled");
    });
  }

  @override
  void onCredentialLinked(AuthCredential credential) {
    print("On Credential Linked $credential");
   // Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => RootApp()));
  }

  // @override
  // void onDifferentProvidersFound(
  //     String email, List<String> providers, AuthCredential? credential) {
  //   // showDifferentMethodSignInDialog(
  //   //   context: context,
  //   //   availableProviders: providers,
  //   //   providers: FirebaseUIAuth.providersFor(FirebaseAuth.instance.app),
  //   // );
  // }




  final auth = FirebaseAuth.instance;
  late final PhoneAuthP.PhoneAuthProvider provider = PhoneAuthP.PhoneAuthProvider()..authListener = this;

  String? otp;
  String? verificationId;
  ConfirmationResult? confirmationResult;
  late Widget child = PhoneNumberPage();

  late Widget child = PhoneInput(
    initialCountryCode: 'US',
    onSubmit: (phoneNumber) {
      provider.sendVerificationCode(phoneNumber, AuthAction.signIn);
    },
  );

  @override
  void onCodeSent(String verificationId, [int? forceResendToken]) {
    this.verificationId = verificationId;
  }

  @override
  void onConfirmationRequested(ConfirmationResult result) {
    this.confirmationResult = result;
  }


  @override
  void onSMSCodeRequested(String phoneNumber) {
    setState(() {
      child = OTPPage();
    });
  }

  @override
  void onVerificationCompleted(PhoneAuthCredential credential) {
    provider.onCredentialReceived(credential, AuthAction.signIn);
  }

  @override
  Widget build(BuildContext context) {
    return child;
  }

  @override
  void onBeforeCredentialLinked(AuthCredential credential) {
    setState(() {
      child = CircularProgressIndicator();
    });
  }

  @override
  void onBeforeProvidersForEmailFetch() {
    setState(() {
      child = CircularProgressIndicator();
    });
  }

  @override
  void onBeforeSignIn() {
    setState(() {
      child = CircularProgressIndicator();
    });
  }

  @override
  void onCanceled() {
    setState(() {
      child = Text("Phone verification cancelled");
    });
  }

  @override
  void onCredentialLinked(AuthCredential credential) {
    Navigator.of(context).pushReplacementNamed('/profile');
  }

  @override
  void onDifferentProvidersFound(
      String email, List<String> providers, AuthCredential? credential) {
    showDifferentMethodSignInDialog(
      context: context,
      availableProviders: providers,
      providers: FirebaseUIAuth.providersFor(FirebaseAuth.instance.app),
    );
  }

  @override
  void onError(Object error) {
    try {
      // tries default recovery strategy
      defaultOnAuthError(provider, error);
    } catch (err) {
      setState(() {
        print(err);
      });
    }
  }

  @override
  void onSignedIn(UserCredential credential) {
    Navigator.of(context).pushReplacementNamed('/profile');
  }


  Widget _getChild(BuildContext context) {
    return child;
  }


  @override
  Widget build(BuildContext context) {
    return _getChild(context);
  }


}



