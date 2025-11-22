import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hicoach_coach/common/dialogs/error_dialog.dart';
import 'package:hicoach_coach/models/training_program_model.dart';
import 'package:hicoach_coach/services/training_program/training_program_services.dart';

class TrainingProgramsController extends GetxController {
  var isLoading = false.obs;
  var deleting = false.obs;

  RxList<TrainingProgram> trainingPrograms = RxList([]);

  final _service = TrainingProgramServices();

  Future<void> getTrainingPrograms(String coachId) async {
    try {
      isLoading.value = true;

      final programs = await _service.fetchTrainingProgram(coachId);
      debugPrint("$programs");

      trainingPrograms.value = programs;
    } catch (e) {
      showErrorDialog(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  void updateTrainingProgram(TrainingProgram updatedProgram) {
    final index = trainingPrograms.indexWhere(
      (pr) => pr.id == updatedProgram.id,
    );

    if (index != -1) {
      trainingPrograms[index] = updatedProgram;

      trainingPrograms.refresh();
    } else {
      debugPrint("⚠ Program with ID ${updatedProgram.id} not found!");
    }
  }

  void deleteTrainingProgram(String programId) async {
    try {
      deleting.value = true;

      await _service.deleteTrainingProgram(programId);
      trainingPrograms.removeWhere((program) => program.id == programId);
      trainingPrograms.refresh();
    

      Get.back();
    } catch (e) {
      showErrorDialog(e.toString());
    } finally {
      deleting.value = false;
    }
  }
}
