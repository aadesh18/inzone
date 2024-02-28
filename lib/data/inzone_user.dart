import 'package:inzone/data/inzone_enums.dart';

class InZoneUser {
  String? _firstName;
  String? _lastName;
  bool? _adult;
  String? _email;
  List<dynamic>? _family;
  String? _userName;
  String? _parentEmail;
  int? _age;
  InZoneEnums? _gender;
  List<Map<InZoneEnums, List<String>>>? _focusTopics;
  List<Map<InZoneEnums, List<String>>>? _fallbackTopics;
  List<Map<InZoneEnums,  List<String>>>?_customTopics;

  InZoneUser(
      {String? firstName,
      String? lastName,
      bool? adult,
      String? email,
        InZoneEnums? gender,
        String? parentEmail,
      List<dynamic>? family,
        int? age,
      String? userName,
        List<Map<InZoneEnums, List<String>>>?focusTopics,
        List<Map<InZoneEnums, List<String>>>?fallbackTopics,
        List<Map<InZoneEnums, List<String>>>? customTopics})
      : _userName = userName,
        _family = family,
        _email = email,
  _parentEmail = parentEmail,
        _adult = adult,
  _age = age,
_gender = gender,
        _lastName = lastName,
        _focusTopics = focusTopics,
   _fallbackTopics = fallbackTopics,
  _customTopics = customTopics,
        _firstName = firstName;

  InZoneUser.noUser() {
    _userName = null;
    _family = null;
    _email = null;
    _adult = null;
    _lastName = null;
    _gender = null;
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
  int? getAge() {
    return _age;
  }

  InZoneEnums? getGender(

      ) {
    return _gender;
  }

  String? getParentEmail() {
    return _parentEmail;
  }
  List<Map<InZoneEnums,  List<String>>>? getFocusTopics() {
    return _focusTopics;
  }
  List<Map<InZoneEnums,  List<String>>>? getFallbackTopics() {
    return _fallbackTopics;
  }
  List<Map<InZoneEnums,  List<String>>>? getCustomTopics() {
    return _customTopics;
  }

  setGender(InZoneEnums gender){
    _gender = gender;

  }



  setParentEmail(String? email) {
    _parentEmail = email;
  }
  setAge(int age) {
    _age = age;
  }

  setfirstName(String firstName) {
    _firstName = firstName;
  }

  setLastName(String lastName) {
    _lastName = lastName;
  }

  setName(String name){
    if (name.split(' ').length >1){
      setfirstName(name.split(' ').elementAt(0));
      setLastName(name.split(' ').elementAt(1));
    } else {
      setfirstName(name);
    }

  }

  setAdult(bool adult) {
    _adult = adult;
  }

  setEmail(String? email) {
    _email = email;
  }

  setFamily(List<dynamic> familyList) {
    _family = familyList;
  }

  setUserName(String userName) {
    _userName = userName;
  }

  setCustomTopics( List<Map<InZoneEnums,  List<String>>>topics){
    _customTopics = topics;
  }
  setFallbackTopics( List<Map<InZoneEnums,  List<String>>>topics){
    _fallbackTopics = topics;
  }
  setFocusTopics( List<Map<InZoneEnums, List<String>>>topics){
    _focusTopics = topics;
  }
}
