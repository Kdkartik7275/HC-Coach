import 'package:hicoach_coach/core/constants/localstorage_keys.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefService {
  static Future<void> saveUserId(String userId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(SharedPrefKeys.userId, userId);
  }

  static Future<String?> getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(SharedPrefKeys.userId);
  }
}
