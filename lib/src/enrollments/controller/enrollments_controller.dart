import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:hicoach_coach/common/dialogs/error_dialog.dart';
import 'package:hicoach_coach/common/dialogs/success_dialog.dart';
import 'package:hicoach_coach/core/constants/localstorage_keys.dart';
import 'package:hicoach_coach/models/enrollment_model.dart';
import 'package:hicoach_coach/models/student.dart';
import 'package:hicoach_coach/services/enrollments/enrollments_service.dart';
import 'package:hicoach_coach/services/profile/profile_service.dart';

enum OtpSendMethod { phone, email }

class EnrollmentsController extends GetxController {
  final activeEnrollments = <EnrollmentModel>[].obs;
  final newEnrollments = <EnrollmentModel>[].obs;
  final isLoading = false.obs;
  final updatingDecision = false.obs;

  final service = EnrollmentsService();
  final localStorage = FlutterSecureStorage();
  final profileService = ProfileService();

  final otp = ''.obs;
  final isOtpSending = false.obs;
  final isOtpSent = false.obs;
  final isVerifying = false.obs;
  final isVerified = false.obs;

  final studentsCache = <String, Student>{}.obs;

  final selectedOtpMethod = OtpSendMethod.phone.obs;

  void setOtpMethod(OtpSendMethod method) {
    selectedOtpMethod.value = method;
  }

  Future<void> fetchActiveEnrollments(String coachId) async {
    try {
      isLoading.value = true;
      final authToken =
          await localStorage.read(key: LocalStorageKeys.token) ?? '';
      final data = await service.getEnrollments(
        coachId,
        authToken,
        status: 'active',
      );
      activeEnrollments.assignAll(data);
      for (var enrollment in activeEnrollments) {
        if (!studentsCache.containsKey(enrollment.studentId)) {
          await getStudentById(enrollment.studentId);
        }
      }
      debugPrint('Enrollments fetched: ${activeEnrollments.length}');
    } catch (e) {
      debugPrint('Error fetching enrollments: $e');
      showErrorDialog(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchNewEnrollments(String coachId) async {
    try {
      isLoading.value = true;
      final authToken =
          await localStorage.read(key: LocalStorageKeys.token) ?? '';
      final data = await service.getEnrollments(
        coachId,
        authToken,
        status: 'pending',
      );
      newEnrollments.assignAll(data);
      for (var enrollment in newEnrollments) {
        if (!studentsCache.containsKey(enrollment.studentId)) {
          await getStudentById(enrollment.studentId);
        }
      }
      debugPrint('New Enrollments fetched: ${newEnrollments.length}');
    } catch (e) {
      showErrorDialog(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> sendAttendanceOtpEmail({
    required String email,
    required String programName,
    required String sessionDate,
  }) async {
    try {
      isOtpSending.value = true;
      otp.value = _generateOtp();

      await service.sendAttendanceOtpEmail(
        email: email,
        otp: otp.value,
        programName: programName,
        sessionDate: sessionDate,
      );

      isOtpSent.value = true;
      debugPrint('Attendance OTP email sent to $email');
    } catch (e) {
      showErrorDialog(e.toString());
    } finally {
      isOtpSending.value = false;
    }
  }

  // ================= VERIFY OTP =================
  Future<void> verifyAttendanceOtp(
    String enteredOtp,
    String enrollmentId,
  ) async {
    try {
      isVerifying.value = true;
      await Future.delayed(const Duration(seconds: 1));

      if (enteredOtp != otp.value) {
        throw "Invalid OTP";
      }
      await markAttendance(enrollmentId: enrollmentId);
      isVerified.value = true;
      Get.back(); // Close the Mark Attendance Page
    } catch (e) {
      showErrorDialog(e.toString());
    } finally {
      isVerifying.value = false;
    }
  }

  Future<void> markAttendance({required String enrollmentId}) async {
    try {
      final authToken =
          await localStorage.read(key: LocalStorageKeys.token) ?? '';

      final enrollmentIndex = activeEnrollments.indexWhere(
        (e) => e.id == enrollmentId,
      );

      if (enrollmentIndex == -1) {
        throw "Enrollment not found";
      }

      final enrollment = activeEnrollments[enrollmentIndex];

      final nextSession = enrollment.sessions.firstWhere(
        (s) => s.status != "completed" && s.attendance == null,
        orElse: () => throw "All sessions are already completed",
      );

      final sessionId = nextSession.id;

      final response = await service.markAttendance(
        enrollmentId: enrollmentId,
        sessionId: sessionId,
        authToken: authToken,
      );

      if (response != null) {
        final sessionIndex = enrollment.sessions.indexWhere(
          (s) => s.id == sessionId,
        );

        if (sessionIndex != -1) {
          enrollment.sessions[sessionIndex] = response;

          activeEnrollments[enrollmentIndex] = enrollment;
        }
      }
    } catch (e) {
      showErrorDialog(e.toString());
    }
  }

  Future<void> acceptOrRejectEnrollment({
    required String decision,
    required String enrollmentId,
    String? reason,
  }) async {
    try {
      updatingDecision.value = true;
      final authToken =
          await localStorage.read(key: LocalStorageKeys.token) ?? '';
      final result = await service.coachDecisionOnEnrollment(
        enrollmentId: enrollmentId,
        decision: decision,
        authToken: authToken,
        reason: reason,
      );

      if (result != null) {
        if (decision == 'accept') {
          activeEnrollments.add(result);
          newEnrollments.removeWhere((e) => e.id == enrollmentId);
          showSuccessDialog('Booking Confirmed');
        } else {
          newEnrollments.removeWhere((e) => e.id == enrollmentId);
          showSuccessDialog('Booking Rejected');
        }
        update();
      }
    } catch (e) {
      showErrorDialog(e.toString());
    } finally {
      updatingDecision.value = false;
    }
  }

  // ================= HELPERS =================
  String _generateOtp() {
    final random = Random.secure();
    return (100000 + random.nextInt(900000)).toString();
  }

  Future<Student?> getStudentById(String studentId) async {
    try {
      Student? student = await profileService.getStudentById(studentId);
      if (student != null) {
        studentsCache[studentId] = student;
      }
      debugPrint(student.toString());
      return student;
    } catch (e) {
      throw e.toString();
    }
  }

  void resetAttendanceFlow() {
    otp.value = '';
    isOtpSent.value = false;
    isVerifying.value = false;
    isVerified.value = false;
  }
}
