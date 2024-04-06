import 'package:inzone/data/inzone_category.dart';
import 'package:inzone/data/inzone_enums.dart';
import 'package:inzone/data/inzone_user.dart';

class InZoneCurrentUser extends InZoneUser {
  List<dynamic>? _followers;
  List<dynamic>? _following;
  String? _password;
  static List<InZoneCategory> subCategories = [];

  InZoneCurrentUser(
      {String? firstName,
      String? lastName,
      bool? adult,
      String? password,
      String? email,
      List<dynamic>? family,
      String? userName,
      List<dynamic>? followers,
      List<dynamic>? following})
      : _followers = followers,
        _password = password,
        _following = following,

        super(
            firstName: firstName,
            lastName: lastName,
            adult: adult,
            email: email,
            family: family,
            userName: userName);

  InZoneCurrentUser.newUser(
      String name,
      String male,
      int age,
      String email,
      String? parentEmail,
      String username,
      String password,
      List<Map<InZoneEnums, List<String>>> focusTopics,
      List<Map<InZoneEnums, List<String>>> fallbackTopics,
      List<Map<InZoneEnums, List<String>>> customTopics) {
    _followers = [];
    _following = [];
    setfirstName(name.split(' ').elementAt(0));
    setLastName(name.split(' ').elementAt(1));
    setAge(age);
    setEmail(email);
    setParentEmail(parentEmail);
    setUserName(username);
    setFocusTopics(focusTopics);
    setFallbackTopics(fallbackTopics);
    setCustomTopics(customTopics);
  }

  List<dynamic>? getFollowers() {
    return _followers;
  }

  List<dynamic>? getFollowing() {
    return _following;
  }

  setPassword(String password) {
    _password = password;
  }

  String? getPassword() {
    return _password;
  }
}
