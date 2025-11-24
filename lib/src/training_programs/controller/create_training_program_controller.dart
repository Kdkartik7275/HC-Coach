import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hicoach_coach/common/dialogs/error_dialog.dart';
import 'package:hicoach_coach/common/dialogs/success_dialog.dart';
import 'package:hicoach_coach/core/constants/app_pages.dart';
import 'package:hicoach_coach/models/training_program_model.dart';
import 'package:hicoach_coach/services/storage/storage_services.dart';
import 'package:hicoach_coach/services/training_program/training_program_services.dart';
import 'package:hicoach_coach/src/navbar/controller/bottom_navbar_controller.dart';
import 'package:hicoach_coach/src/training_programs/controller/training_programs_controller.dart';

class CreateTrainingProgramController extends GetxController {
  /// -------------------------
  /// OBSERVABLE VARIABLES
  /// -------------------------
  RxBool creating = false.obs;

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
  final thumbnail = Rx<File?>(null);

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

  // ---------------------------------------------------------------------------
  // CLEANUP
  // ---------------------------------------------------------------------------
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
  // VALIDATION
  // ---------------------------------------------------------------------------
  bool validateForm() {
    if (titleC.text.trim().isEmpty) {
      return _error("Please enter a program title");
    }
    if (sportC.text.trim().isEmpty) return _error("Please enter a sport");
    if (int.tryParse(sessionsC.text) == null) {
      return _error("Enter valid sessions");
    }
    if (frequencyC.text.trim().isEmpty) return _error("Enter frequency");
    if (double.tryParse(priceC.text) == null) {
      return _error("Enter valid price");
    }
    if (slots.isEmpty) return _error("Add at least one slot");
    if (learningPoints.isEmpty) {
      return _error("Add at least one learning outcome");
    }
    if (descriptionC.text.trim().isEmpty) return _error("Enter description");

    return true;
  }

  bool _error(String msg) {
    showErrorDialog(msg);
    return false;
  }

  // ---------------------------------------------------------------------------
  // CREATE PROGRAM
  // ---------------------------------------------------------------------------
  Future<void> createTrainingProgram(String coachId, String coachName) async {
    if (!validateForm()) return;

    try {
      creating.value = true;

      String? thumbnailUrl;
      if (thumbnail.value != null) {
        thumbnailUrl = await _storage.uploadFileData(thumbnail.value!);
      }

      TrainingProgram program = TrainingProgram(
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
        coachName: coachName,
      );

      final res = await _services.createTrainingProgram(program);

      if (res != null) {
        showSuccessDialog("Training Program Created Successfully!");
        resetForm();
        Get.find<TrainingProgramsController>().updateTrainingProgram(res);
        Get.back();
      }
    } catch (e) {
      _error("Something went wrong. Try again.");
    } finally {
      creating.value = false;
    }
  }

  // ---------------------------------------------------------------------------
  // LOAD PROGRAM INTO FORM (EDIT MODE)
  // ---------------------------------------------------------------------------
  void loadProgram(TrainingProgram program) {
    titleC.text = program.title;
    sportC.text = program.sport;
    level.value = program.level;

    durationDays.value = program.durationDays;
    sessionsC.text = program.totalSessions.toString();
    frequencyC.text = program.frequency.toString();
    priceC.text = program.price.toStringAsFixed(0);

    descriptionC.text = program.description;

    thumbnail.value = null; // Don’t auto convert URL → File

    slots.assignAll(program.slots);
    learningPoints.assignAll(program.learningOutcomes);
    requirements.assignAll(program.requirements);
  }

  // ---------------------------------------------------------------------------
  // UPDATE PROGRAM
  // ---------------------------------------------------------------------------
  Future<void> updateTrainingProgram(String programId) async {
    try {
      creating.value = true;

      String? thumbnailUrl;
      if (thumbnail.value != null) {
        thumbnailUrl = await _storage.uploadFileData(thumbnail.value!);
      }
      final data = {
        "title": titleC.text.trim(),
        "sport": sportC.text.trim(),
        "level": level.value,
        "durationDays": durationDays.value,
        "totalSessions": int.parse(sessionsC.text.trim()),
        "frequency": int.parse(frequencyC.text.trim()),
        "price": double.parse(priceC.text.trim()),
        "slots": List<String>.from(slots),
        "learningOutcomes": List<String>.from(learningPoints),
        "requirements": List<String>.from(requirements),
        "description": descriptionC.text.trim(),
        if (thumbnail.value != null) "thumbnailUrl": thumbnailUrl,
      };

      final updated = await _services.updateTrainingProgram(programId, data);

      if (updated != null) {
        showSuccessDialog("Training Program Updated Successfully!");
        Get.find<TrainingProgramsController>().updateTrainingProgram(updated);

        Get.until((route) => Get.currentRoute == Routes.BottomNavBar);

        Get.find<BottomNavBarController>().onItemTapped(4);
      }
    } catch (e) {
      showErrorDialog("Update failed: $e");
    } finally {
      creating.value = false;
    }
  }

  // ---------------------------------------------------------------------------
  // RESET FORM
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
