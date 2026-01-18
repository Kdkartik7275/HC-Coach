import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hicoach_coach/core/constants/app_apis.dart';
import 'package:hicoach_coach/core/constants/localstorage_keys.dart';
import 'package:hicoach_coach/models/coach.dart';
import 'package:hicoach_coach/models/student.dart';
import 'package:hicoach_coach/models/timings.dart';
import 'package:http/http.dart' as http;

class ProfileService {
  Future<Coach?> createCoach(Coach newCoach, String authToken) async {
    try {
      final url = Uri.parse(AppApis.createCoach);

      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(newCoach.toMap()),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        final coach = Coach.fromMap(jsonDecode(response.body));
        return coach;
      }
    } catch (e) {
      throw e.toString();
    }
    return null;
  }

  Future<Coach?> getCoachById(String coachId) async {
    try {
      final url = Uri.parse(AppApis.coachById(coachId));
      final String authToken =
          await FlutterSecureStorage().read(key: LocalStorageKeys.token) ?? '';

      final response = await http.get(
        url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $authToken",
        },
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        final coach = Coach.fromMap(jsonDecode(response.body));
        return coach;
      }
    } catch (e) {
      throw e.toString();
    }
    return null;
  }

  Future<Coach?> updateCoach(
    Map<String, dynamic> data,
    String coachId,
    String authToken,
  ) async {
    try {
      final url = Uri.parse(AppApis.updateCoachById(coachId));

      final response = await http.put(
        url,
        headers: {"Content-Type": "application/json","Authorization" : "Bearer $authToken"},
        body: jsonEncode(data),
      );
      debugPrint(response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        return Coach.fromMap(jsonDecode(response.body));
      } else {
        throw jsonDecode(response.body)['message'];
      }
    } catch (e) {
      throw e.toString();
    }
  }

  Future<Coach?> updateCoachTimings(
    List<Timings> timings,
    String coachId,
  ) async {
    try {
      final url = Uri.parse(AppApis.updateCoachTimings(coachId));

      final List<Map<String, dynamic>> timingsData = timings
          .map((timing) => timing.toMap())
          .toList();

      final response = await http.put(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"timings": timingsData}),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        // print(jsonDecode(response.body)['timings']);
        return Coach.fromMap(jsonDecode(response.body));
      } else {
        return null;
      }
    } catch (e) {
      throw e.toString();
    }
  }

  Future<Student?> getStudentById(String studentId) async {
    try {
      final url = Uri.parse(AppApis.studentById(studentId));
      final String authToken =
          await FlutterSecureStorage().read(key: LocalStorageKeys.token) ?? '';
      final response = await http.get(
        url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $authToken",
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        // print(jsonDecode(response.body)['timings']);
        return Student.fromMap(jsonDecode(response.body));
      } else {
        return null;
      }
    } catch (e) {
      throw e.toString();
    }
  }
}
