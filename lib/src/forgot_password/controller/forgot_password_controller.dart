import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hicoach_coach/common/dialogs/error_dialog.dart';
import 'package:hicoach_coach/common/dialogs/success_dialog.dart';
import 'package:hicoach_coach/core/utils/helpers/functions.dart';
import 'package:hicoach_coach/services/forgot_password/forgot_password_service.dart';

class ForgotPasswordController extends GetxController {
  final emailController = TextEditingController();
  final otpController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  var step = 1.obs;
  var hidePassword = true.obs;
  var tempOtp = ''.obs;

  var isLoading = false.obs;

  final _service = ForgotPasswordService();

  void togglePasswordVisibility() {
    hidePassword.value = !hidePassword.value;
  }

  Future<void> handleNext() async {
    if (step.value == 1) {
      if (emailController.text.isEmpty) {
        showErrorDialog("Please enter your email.");
        return;
      }

      tempOtp.value = generateOtp();
      isLoading.value = true;

      try {
        await _service.sendOtpEmail(emailController.text, tempOtp.value);
        showSuccessDialog("OTP sent to your email!");
        step.value = 2;
      } catch (e) {
        showErrorDialog("Failed to send OTP: $e");
      } finally {
        isLoading.value = false;
      }
    } else if (step.value == 2) {
      if (otpController.text.isEmpty) {
        showErrorDialog("Please enter OTP.");
        return;
      }
      if (otpController.text != tempOtp.value) {
        showErrorDialog("Invalid OTP. Please try again.");
        return;
      }

      showSuccessDialog("OTP verified!");
      step.value = 3;
    } else if (step.value == 3) {
      if (newPasswordController.text != confirmPasswordController.text) {
        showErrorDialog("Passwords do not match.");
        return;
      }

      isLoading.value = true;
      try {
        await _service.resetPassword(
          emailController.text,
          newPasswordController.text,
        );
        showSuccessDialog("Password reset successfully!");
        await Future.delayed(const Duration(seconds: 2));
        Get.back();
      } catch (e) {
        showErrorDialog("Failed to reset password: $e");
      } finally {
        isLoading.value = false;
      }
    }
  }
}
