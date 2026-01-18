import 'dart:convert';

import 'package:flutter/rendering.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hicoach_coach/core/constants/app_apis.dart';
import 'package:hicoach_coach/models/enrollment_model.dart';
import 'package:hicoach_coach/models/session.dart';
import 'package:http/http.dart' as http;
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';

class EnrollmentsService {
  Future<List<EnrollmentModel>> getEnrollments(
    String coachId,
    String authToken, {
    String? status,
  }) async {
    try {
      final uri = Uri.parse(
        AppApis.coachEnrollments(coachId),
      ).replace(queryParameters: status != null ? {"status": status} : null);

      final response = await http.get(
        uri,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $authToken",
        },
      );
      debugPrint('Enrollments response: ${jsonDecode(response.body)['data']}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(response.body)['data'] as List;
        return data.map((e) => EnrollmentModel.fromJson(e)).toList();
      }

      return [];
    } catch (e) {
      throw e.toString();
    }
  }

  Future<void> sendAttendanceOtpEmail({
    required String email,
    required String otp,
    required String programName,
    required String sessionDate,
  }) async {
    try {
      final username = dotenv.env['SMTP_USERNAME']!;
      final password = dotenv.env['SMTP_PASSWORD']!;

      final smtpServer = gmail(username, password);

      final message = Message()
        ..from = Address(username, 'HiCoach Support')
        ..recipients.add(email)
        ..subject = 'HiCoach Attendance Verification Code'
        ..text =
            '''
Hello,

Your coach has started a training session for:

📘 Program: $programName  
📅 Session Date: $sessionDate  

To confirm your attendance, please enter the verification code below in the HiCoach app:

🔐 OTP: $otp

This code is valid for a limited time.
If you are not attending this session, you can ignore this email.

Thank you,  
HiCoach Team
''';

      await send(message, smtpServer);
    } on MailerException catch (e) {
      debugPrint(e.toString());
      throw Exception(e.toString());
    } catch (e) {
      debugPrint(e.toString());
      throw Exception(e.toString());
    }
  }

  Future<SessionModel?> markAttendance({
    required String enrollmentId,
    required String sessionId,
    required String authToken,
  }) async {
    try {
      final uri = Uri.parse(AppApis.markAttendance(enrollmentId, sessionId));

      final response = await http.patch(
        uri,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $authToken",
        },
      );

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw Exception('Failed to mark attendance');
      } else {
        final data = jsonDecode(response.body)['session'];
        return SessionModel.fromJson(data);
      }
    } catch (e) {
      throw e.toString();
    }
  }

  Future<EnrollmentModel?> coachDecisionOnEnrollment({
    required String enrollmentId,
    required String decision,
    String? reason,
    required String authToken,
  }) async {
    try {
      final uri = Uri.parse(AppApis.coachEnrollmentDecision(enrollmentId));

      final body = {
        "decision": decision,
        if (decision == "reject") "reason": reason,
      };

      final response = await http.patch(
        uri,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $authToken",
        },
        body: jsonEncode(body),
      );

      print("STATUS: ${response.statusCode}");
      print("BODY: ${response.body}");

      if (response.statusCode != 200 && response.statusCode != 201) {
        final data = jsonDecode(response.body);
        throw Exception(data["message"] ?? "Failed to update enrollment");
      }

      final data = jsonDecode(response.body)["data"];
      return EnrollmentModel.fromJson(data);
    } catch (e) {
      print("ERROR: $e");
      rethrow;
    }
  }
}
