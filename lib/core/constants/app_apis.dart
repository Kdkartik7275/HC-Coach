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
}
