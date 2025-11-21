import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hicoach_coach/common/dialogs/error_dialog.dart';
import 'package:hicoach_coach/common/dialogs/success_dialog.dart';
import 'package:hicoach_coach/models/training_program.dart';
import 'package:hicoach_coach/services/storage/storage_services.dart';
import 'package:hicoach_coach/services/training_program/training_program_services.dart';

class CreateTrainingProgramController extends GetxController {

  /// -------------------------
  /// OBSERVABLES VARIABLES
  /// -------------------------
  RxBool creating = RxBool(false);


  /// -------------------------
  /// BASIC INFORMATION
  /// -------------------------
  final titleC = TextEditingController();
  final sportC = TextEditingController();
  final level = "Beginner".obs;

  /// -------------------------
  /// DURATION & SCHEDULE
  /// -------------------------
  final durationDays = 30.obs;
  final sessionsC = TextEditingController();
  final frequencyC = TextEditingController();
  final slots = <String>[].obs;
  final slotInput = TextEditingController();

  /// -------------------------
  /// PRICING
  /// -------------------------
  final priceC = TextEditingController();

  /// -------------------------
  /// ABOUT PROGRAM
  /// -------------------------
  final descriptionC = TextEditingController();
  var thumbnail = Rx<File?>(null);

  /// -------------------------
  /// LEARNING OUTCOMES
  /// -------------------------
  final learningPoints = <String>[].obs;
  final learningInput = TextEditingController();

  /// -------------------------
  /// REQUIREMENTS
  /// -------------------------
  final requirements = <String>[].obs;
  final reqInput = TextEditingController();

  // -------------------------
  // Services
  // -------------------------
  final _services = TrainingProgramServices();
  final _storage = StorageServices();

  @override
  void onClose() {
    titleC.dispose();
    sportC.dispose();
    sessionsC.dispose();
    frequencyC.dispose();
    priceC.dispose();
    descriptionC.dispose();
    learningInput.dispose();
    reqInput.dispose();
    slotInput.dispose();
    super.onClose();
  }

  // ---------------------------------------------------------------------------
  // VALIDATION METHOD
  // ---------------------------------------------------------------------------
  bool validateForm() {
    if (titleC.text.trim().isEmpty) {
      _error("Please enter a program title");
      return false;
    }

    if (sportC.text.trim().isEmpty) {
      _error("Please enter a sport name");
      return false;
    }

    if (sessionsC.text.trim().isEmpty || int.tryParse(sessionsC.text) == null) {
      _error("Please enter valid total sessions");
      return false;
    }

    if (frequencyC.text.trim().isEmpty) {
      _error("Please enter frequency (e.g. 3 sessions/week)");
      return false;
    }

    if (priceC.text.trim().isEmpty || double.tryParse(priceC.text) == null) {
      _error("Please enter a valid price");
      return false;
    }

    if (slots.isEmpty) {
      _error("Please add at least one slot");
      return false;
    }

    if (learningPoints.isEmpty) {
      _error("Please add at least one learning outcome");
      return false;
    }

    if (descriptionC.text.trim().isEmpty) {
      _error("Please enter a description");
      return false;
    }

    return true;
  }

  void _error(String msg) {
    showErrorDialog(msg);
  }

  // ---------------------------------------------------------------------------
  // CREATE PROGRAM
  // ---------------------------------------------------------------------------
  Future<void> createTrainingProgram(String coachId) async {
    if (!validateForm()) return;

    try {
      creating.value = true;
      // Upload Thumbnail
      String? thumbnailUrl;
      if (thumbnail.value != null) {
        thumbnailUrl = await _storage.uploadFileData(thumbnail.value!);
      }

      TrainingProgram newTrainingProgram = TrainingProgram(
        title: titleC.text.trim(),
        sport: sportC.text.trim(),
        level: level.value,
        durationDays: durationDays.value,
        totalSessions: int.parse(sessionsC.text.trim()),
        frequency: int.parse(frequencyC.text.trim()),
        price: double.parse(priceC.text.trim()),
        slots: List<String>.from(slots),
        learningOutcomes: List<String>.from(learningPoints),
        requirements: List<String>.from(requirements),
        description: descriptionC.text.trim(),
        thumbnailUrl: thumbnailUrl,
        coachId: coachId,
      );

      await _services.createTrainingProgram(newTrainingProgram);

      showSuccessDialog("Training Program Created Successfully!");

      resetForm();
    } catch (e) {
      _error("Something went wrong. Try again.");
    }
    finally{
      creating.value = false;
    }
  }

  // ---------------------------------------------------------------------------
  // RESET METHOD
  // ---------------------------------------------------------------------------
  void resetForm() {
    titleC.clear();
    sportC.clear();
    sessionsC.clear();
    frequencyC.clear();
    priceC.clear();
    descriptionC.clear();

    level.value = "Beginner";
    durationDays.value = 30;
    thumbnail.value = null;

    slots.clear();
    learningPoints.clear();
    requirements.clear();

    slotInput.clear();
    learningInput.clear();
    reqInput.clear();
  }
}
