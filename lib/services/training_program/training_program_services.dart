import 'dart:convert';

import 'package:hicoach_coach/core/constants/app_apis.dart';
import 'package:hicoach_coach/models/training_program.dart';
import 'package:http/http.dart' as http;

class TrainingProgramServices {
  Future<TrainingProgram?> createTrainingProgram(
    TrainingProgram newTrainingProgram,
  ) async {
    try {
      final url = Uri.parse(AppApis.createTrainingProgram);

      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(newTrainingProgram.toJson()),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        final trainingProgram = TrainingProgram.fromJson(
          jsonDecode(response.body)['data'],
        );
        return trainingProgram;
      }
      return null;
    } catch (e) {
      throw e.toString();
    }
  }
}
