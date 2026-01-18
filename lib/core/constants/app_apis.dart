// ignore_for_file: constant_identifier_names

import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppApis {
  static String baseurl = dotenv.env['API_BASE_URL']!;

  // -------------------- Authentication --------------------
  static final String register = "$baseurl/auth/signup";
  static final String login = "$baseurl/auth/login";
  static final String verifyToken = "$baseurl/auth/verify-token";
  static final String forgotPassword = "$baseurl/auth/forgot-password";

  // ------------------------ Profile ------------------------
  static String createCoach = "$baseurl/coaches/";
  static String coachById(String coachId) => "$baseurl/coaches/$coachId";
  static String updateCoachById(String coachId) => "$baseurl/coaches/$coachId";
  static String updateCoachTimings(String coachId) =>
      "$baseurl/coaches/timings/$coachId";

  // ------------------ Training Programs --------------------
  static String createTrainingProgram = "$baseurl/training-program/create";

  static String updateTrainingProgram(String programId) =>
      "$baseurl/training-program/$programId";

  static String deleteTrainingProgram(String programId) =>
      "$baseurl/training-program/$programId";

  static String programsByCoachId(String coachId) =>
      "$baseurl/training-program/coach/$coachId";

  static String coachEnrollments(String coachId) =>
      "$baseurl/booking/coach/$coachId";

  static String coachEnrollmentDecision(String enrollmentId) =>
      "$baseurl/booking/$enrollmentId/decision";

  static String markAttendance(String enrollmentId, String sessionId) =>
      "$baseurl/booking/$enrollmentId/sessions/$sessionId/attendance";

  static String studentById(String studentId) => "$baseurl/students/$studentId";

  static String getChatList(String userId) => "$baseurl/chats/$userId";
  static String createChatRoom = "$baseurl/chats/create";

  // ---------------- Messages ------------------------
  static String getChatMessages(String chatRoomId) =>
      "$baseurl/messages/$chatRoomId";
}
