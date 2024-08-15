import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelperClass {
  static const String _keyStringList = 'character_list';
  static const String _string = 'character_svg';

  // Save a list of strings
  static Future<void> saveStringList(List<String> list) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(_keyStringList, list);
  }

  static Future<void> saveString(String string) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_string, string);
  }
  static Future<String?> getString() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_string);
  }
  // Retrieve the list of strings
  static Future<List<String>?> getStringList() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(_keyStringList);
  }
}
