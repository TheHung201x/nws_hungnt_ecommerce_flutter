import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  static const _didOnboardKey = '_didOnboardKey';

  //Get onboard
  static Future<bool> isOnboardCompleted() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      return prefs.getBool(_didOnboardKey) ?? false;
    } catch (e) {
      return false;
    }
  }

  //Set onboard
  static Future<void> setOnboard({onBoard = true}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_didOnboardKey, onBoard ?? true);
  }
}
