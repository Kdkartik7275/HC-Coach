import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:hicoach_coach/core/constants/app_apis.dart';
import 'package:hicoach_coach/core/constants/localstorage_keys.dart';
import 'package:hicoach_coach/services/shared_prefs/shared_pref_service.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LoginServices {
  final storage = const FlutterSecureStorage();

  Future<Map<String, dynamic>?> loginWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final response = await http.post(
        Uri.parse(AppApis.login),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"email": email, "password": password}),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(response.body);
        await storage.write(key: LocalStorageKeys.token, value: data["token"]);
        SharedPrefService.saveUserId(data['user']['userId']);

        return data;
      } else {
        final error = jsonDecode(response.body);
        throw error["message"] ?? "Login failed";
      }
    } on SocketException {
      throw "Unable to connect to server. Please check your internet or server status.";
    } on TimeoutException {
      throw "The connection timed out. Please try again.";
    } on http.ClientException {
      throw "Network error. Please try again later.";
    } catch (e) {
      throw "Something went wrong. Please try again.";
    }
  }

  Future<void> logoutUser() async {
    await storage.delete(key: "token");
  }

  Future<bool> isAuthenticated() async {
    final token = await storage.read(key: LocalStorageKeys.token);
    return token != null;
  }

  Future<Map<String, dynamic>> verifyToken() async {
    try {
      final token = await storage.read(key: LocalStorageKeys.token);

      if (token == null) {
        throw "No token found. Please log in.";
      }

      final response = await http.get(
        Uri.parse(AppApis.verifyToken),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data;
      } else {
        final error = jsonDecode(response.body);
        throw error["message"] ?? "Token verification failed";
      }
    } catch (e) {
      print(e.toString());
      throw "$e";
    }
  }
}
