import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hicoach_coach/core/constants/app_apis.dart';
import 'package:hicoach_coach/core/constants/localstorage_keys.dart';
import 'package:http/http.dart' as http;

class RegisterServices {
  final storage = const FlutterSecureStorage();

  Future<Map<String, dynamic>?> registerUser(Map<String, dynamic> data) async {
    try {
      final url = Uri.parse(AppApis.register);

      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(data),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(response.body);

        await storage.write(key: LocalStorageKeys.token, value: data["token"]);
        return jsonDecode(response.body);
      }
    } catch (e) {
      throw e.toString();
    }
    return null;
  }
}
