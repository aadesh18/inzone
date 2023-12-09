class InZoneUser {
  String? _firstName;
  String? _lastName;
  bool? _adult;
  String? _email;
  List<dynamic>? _family;
  String? _userName;

  InZoneUser(
      {String? firstName,
      String? lastName,
      bool? adult,
      String? email,
      List<dynamic>? family,
      String? userName})
      : _userName = userName,
        _family = family,
        _email = email,
        _adult = adult,
        _lastName = lastName,
        _firstName = firstName;

  InZoneUser.noUser() {
    _userName = null;
    _family = null;
    _email = null;
    _adult = null;
    _lastName = null;
    _firstName = null;
  }

  String toEnglish() {
    return "First Name: $_firstName\nLast Name: $_lastName\nUsername: $_userName\nE-Mail: $_email\nAdult: $_adult\nFamily Members: $_family";
  }

  String? getFirstName() {
    return _firstName;
  }

  String? getLastName() {
    return _lastName;
  }

  bool? getAdult() {
    return _adult;
  }

  String? getEmail() {
    return _email;
  }

  List<dynamic>? getFamily() {
    return _family;
  }

  String? getUserName() {
    return _userName;
  }

  setfirstName(String firstName) {
    _firstName = firstName;
  }

  setLastName(String lastName) {
    _lastName = lastName;
  }

  setAdult(bool adult) {
    _adult = adult;
  }

  setEmail(String email) {
    _email = email;
  }

  setFamily(List<dynamic> familyList) {
    _family = familyList;
  }

  setUserName(String userName) {
    _userName = userName;
  }
}
