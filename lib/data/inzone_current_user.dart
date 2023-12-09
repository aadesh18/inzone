import 'package:inzone/data/inzone_user.dart';

class InZoneCurrentUser extends InZoneUser {
  final List<dynamic>? _followers;
  final List<dynamic>? _following;

  InZoneCurrentUser(
      {String? firstName,
      String? lastName,
      bool? adult,
      String? email,
      List<dynamic>? family,
      String? userName,
      List<dynamic>? followers,
      List<dynamic>? following})
      : _followers = followers,
        _following = following,
        super(
            firstName: firstName,
            lastName: lastName,
            adult: adult,
            email: email,
            family: family,
            userName: userName);

  List<dynamic>? getFollowers() {
    return _followers;
  }

  List<dynamic>? getFollowing() {
    return _following;
  }
}
