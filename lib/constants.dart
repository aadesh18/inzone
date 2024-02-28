import 'package:flutter/material.dart';
import 'package:inzone/data/inzone_current_user.dart';
import 'package:inzone/data/inzone_user.dart';

const Color backgroundColor = Color(0xffdaf5ff);
double? screenHeight;
double? screenWidth;
const Color barColor = Color(0xff16202a);
const Color barSelectedColor = Color(0xff0180da);
const Color barUnselectedColor = Color(0xff819ebe);
InZoneCurrentUser currentUser = InZoneCurrentUser();

bool continueSignUp = false;

PreferredSizeWidget commonAppBar(title, height) {
  return PreferredSize(
    preferredSize: Size.fromHeight(height),
    child: AppBar(
      elevation: 0,
      automaticallyImplyLeading: false,
      backgroundColor: backgroundColor,
      title: Text(title,
          style: const TextStyle(fontSize: 26, fontWeight: FontWeight.w700)),
    ),
  );
}



String licenseAgreement = '''
1. Acknowledgement:
This End User License Agreement (EULA) is a binding agreement between you (the "End-User") and InZone, INC. ("We" or "Us"). This EULA governs your use of our Licensed Application. By downloading, installing, or using the Licensed Application, you agree to be bound by the terms of this EULA. This agreement is in place between you and us, not with Apple. We are solely responsible for the Licensed Application and its content, not Apple. This EULA adheres to the Apple Media Services Terms and Conditions.

2. Scope of License:
We grant you a non-transferable license to use the Licensed Application on Apple-branded products owned or controlled by you, as per the Usage Rules in the Apple Media Services Terms and Conditions. This includes access and use by other accounts via Family Sharing or volume purchasing.

3. Maintenance and Support:
We are solely responsible for providing maintenance and support services for the Licensed Application, as outlined in this EULA or as required by law. Apple has no obligation to provide maintenance or support services for the Licensed Application.

4. Warranty:
We are solely responsible for any product warranties, to the extent not effectively disclaimed by law. If the Licensed Application fails to conform to any applicable warranty, you may notify Apple, and Apple will refund the purchase price. To the maximum extent permitted by law, Apple will have no other warranty obligations.

5. Product Claims:
We, not Apple, are responsible for addressing any claims you or any third party may have concerning the Licensed Application, including product liability claims, legal or regulatory non-conformance claims, and claims under consumer protection, privacy, or similar legislation.

6. Intellectual Property Rights:
In the event of a third-party claim that the Licensed Application infringes intellectual property rights, we, not Apple, will be solely responsible for the investigation, defense, settlement, and discharge of any such claim.

7. Legal Compliance:
You represent and warrant that you are not located in a U.S. Government embargoed country or designated as a “terrorist supporting” country and that you are not listed on any U.S. Government list of prohibited or restricted parties.

8. Developer Name and Address:
For any questions, complaints, or claims concerning the Licensed Application, please contact InZone, INC. at 6505 59th Ave Riverdale, MD, +1 (240) 681-4298, contact@inzone.ai.

9. Third-Party Terms of Agreement:
You must comply with applicable third-party terms when using the Licensed Application. For example, if the Licensed Application is a VoIP app, you must not violate your wireless data service agreement.

10. Third Party Beneficiary:
Apple and Apple’s subsidiaries are third-party beneficiaries of this EULA. Upon your acceptance of the terms and conditions, Apple will have the right to enforce this EULA against you as a third-party beneficiary.

11. Content and Conduct:
We are dedicated to fostering healthier relationships with social media. There is zero tolerance for objectionable content or abusive behavior on the platform. Users are encouraged to report any such content for immediate review and action.

12. Protecting Young Users:
Information from users below 13 years of age is used solely for enhancing the InZone Parents Hub, making social media healthier for them by giving appropriate tools to their parents or guardians. We are committed to safeguarding the online experiences of our youngest users with the utmost care and in compliance with applicable laws.

By using the Licensed Application, you agree to abide by these terms and conditions. Your acceptance of this EULA constitutes your agreement to its terms.


''';