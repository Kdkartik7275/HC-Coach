// ignore_for_file: constant_identifier_names

import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppApis {
  // static const String baseurl = "https://hi-coach-server.onrender.com/api";
  static String baseurl = dotenv.env['API_BASE_URL']!;
  //static const String baseurl = "http://192.168.29.172:5000/api";

  // ---------------- Authentication --------------------
  static final String register = "$baseurl/auth/signup";
  static final String login = "$baseurl/auth/login";
  static final String verifyToken = "$baseurl/auth/verify-token";
  static final String forgotPassword = "$baseurl/auth/forgot-password";

  // ------------------ Profile -------------------------------

  static String createCoach = "$baseurl/coaches/";
  static String coachById(String coachId) => "$baseurl/coaches/$coachId";
  static String updateCoachById(String coachId) => "$baseurl/coaches/$coachId";
  static String updateCoachTimings(String coachId) =>
      "$baseurl/coaches/timings/$coachId";
}
