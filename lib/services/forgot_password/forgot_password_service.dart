import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hicoach_coach/core/constants/app_apis.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:http/http.dart' as http;

class ForgotPasswordService {
  Future<void> sendOtpEmail(String email, String otp) async {
    try {
      final username = dotenv.env['SMTP_USERNAME']!;
      final password = dotenv.env['SMTP_PASSWORD']!;

      final smtpServer = gmail(username, password);

      final message = Message()
        ..from = Address(username, 'HiCoach Support')
        ..recipients.add(email)
        ..subject = 'HiCoach Password Reset Verification Code'
        ..text =
            '''
Hello,

We received a request to reset your HiCoach account password.
Your verification code (OTP) is:

🔐 $otp

Please enter this code in the app to verify your identity.
If you didn’t request this, you can safely ignore this email.

Thank you,  
The HiCoach Team
''';

      await send(message, smtpServer);
    } on MailerException catch (e) {
      throw e.toString();
    } catch (e) {
      throw e.toString();
    }
  }

  Future<Map<String, dynamic>> resetPassword(
    String email,
    String newPassword,
  ) async {
    try {
      final response = await http.post(
        Uri.parse(AppApis.forgotPassword),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"email": email, "newPassword": newPassword}),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(response.body);

        return data;
      } else {
        final error = jsonDecode(response.body);
        throw error["message"] ?? "Login failed";
      }
    } catch (e) {
      throw e.toString();
    }
  }
}
