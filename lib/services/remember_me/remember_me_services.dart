import 'package:hicoach_coach/core/constants/localstorage_keys.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RememberMeService {
  static Future<void> saveUserCredentials(String email, String password) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(SharedPrefKeys.email, email);
    await prefs.setString(SharedPrefKeys.password, password);
    await prefs.setBool(SharedPrefKeys.rememberMe, true);
  }

  static Future<Map<String, dynamic>> getUserCredentials() async {
    final prefs = await SharedPreferences.getInstance();
    final rememberMe = prefs.getBool(SharedPrefKeys.rememberMe) ?? false;
    if (!rememberMe) return {};
    return {
      'email': prefs.getString(SharedPrefKeys.email),
      'password': prefs.getString(SharedPrefKeys.password),
    };
  }

  static Future<void> clearUserCredentials() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(SharedPrefKeys.email);
    await prefs.remove(SharedPrefKeys.password);
    await prefs.setBool(SharedPrefKeys.rememberMe, false);
  }
}
