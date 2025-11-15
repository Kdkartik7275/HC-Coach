import 'dart:convert';

import 'package:hicoach_coach/core/constants/app_apis.dart';
import 'package:hicoach_coach/models/coach.dart';
import 'package:hicoach_coach/models/timings.dart';
import 'package:http/http.dart' as http;

class ProfileService {
  Future<Coach?> createCoach(Coach newCoach) async {
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

      final response = await http.get(
        url,
        headers: {"Content-Type": "application/json"},
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

  Future<Coach?> updateCoach(Map<String, dynamic> data, String coachId) async {
    try {
      final url = Uri.parse(AppApis.updateCoachById(coachId));

      final response = await http.put(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(data),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return Coach.fromMap(jsonDecode(response.body));
      } else {
        return null;
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
}
