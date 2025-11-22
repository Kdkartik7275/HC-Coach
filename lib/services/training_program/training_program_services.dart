import 'dart:convert';

import 'package:hicoach_coach/common/dialogs/success_dialog.dart';
import 'package:hicoach_coach/core/constants/app_apis.dart';
import 'package:hicoach_coach/models/training_program_model.dart';
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

  Future<List<TrainingProgram>> fetchTrainingProgram(String coachId) async {
    try {
      final url = Uri.parse(AppApis.programsByCoachId(coachId));

      final response = await http.get(
        url,
        headers: {"Content-Type": "application/json"},
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(response.body)['data'] as List;
        final trainingPrograms = data
            .map((tr) => TrainingProgram.fromJson(tr))
            .toList();
        return trainingPrograms;
      }
      return [];
    } catch (e) {
      throw e.toString();
    }
  }

  Future<TrainingProgram?> updateTrainingProgram(
    String programId,
    Map<String, dynamic> data,
  ) async {
    try {
      final url = Uri.parse(AppApis.updateTrainingProgram(programId));

      final response = await http.put(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(data),
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

  Future<void> deleteTrainingProgram(String programId) async {
    try {
      final url = Uri.parse(AppApis.deleteTrainingProgram(programId));

      final response = await http.delete(
        url,
        headers: {"Content-Type": "application/json"},
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        showSuccessDialog(jsonDecode(response.body)['message']);
      }
    } catch (e) {
      throw e.toString();
    }
  }
}
