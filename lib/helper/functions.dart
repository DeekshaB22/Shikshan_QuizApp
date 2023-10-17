import 'package:shared_preferences/shared_preferences.dart';

class HelperFunctions{

  static String userLoggesInKey = "USERLOGGEDINKEY";

  static saveUserLoginInDetails({required bool isLoggedin}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(userLoggesInKey, isLoggedin);
  }

  static Future<bool?> getUserLoggedInDetails() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(userLoggesInKey);
  }
}