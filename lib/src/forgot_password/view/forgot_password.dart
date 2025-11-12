import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hicoach_coach/common/indicators/progress_indicators.dart';
import 'package:hicoach_coach/core/constants/colors.dart';
import 'package:hicoach_coach/src/forgot_password/controller/forgot_password_controller.dart';
import 'package:loading_overlay/loading_overlay.dart';

class ForgotPasswordView extends GetView<ForgotPasswordController> {
  const ForgotPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(),
      body: Obx(
        () => LoadingOverlay(
          isLoading: controller.isLoading.value,
          progressIndicator: circularProgress(context),
          color: Colors.transparent,
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  controller.step.value == 1
                      ? "Reset your password"
                      : controller.step.value == 2
                      ? "Verify OTP"
                      : "Create new password",
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  controller.step.value == 1
                      ? "Enter your registered email to receive an OTP."
                      : controller.step.value == 2
                      ? "We’ve sent a 6-digit OTP to your email."
                      : "Enter and confirm your new password below.",
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: AppColors.textLighter,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                SizedBox(height: 35.h),

                /// Step 1 - Email Input
                if (controller.step.value == 1)
                  _EmailInput(controller: controller),

                /// Step 2 - OTP Input
                if (controller.step.value == 2)
                  _OtpInput(controller: controller),

                /// Step 3 - New Password Input
                if (controller.step.value == 3)
                  _PasswordInput(controller: controller),

                SizedBox(height: 40.h),

                // Continue Button
                SizedBox(
                  width: double.infinity,
                  height: 48.h,
                  child: ElevatedButton(
                    onPressed: controller.handleNext,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                    child: Text(
                      controller.step.value == 1
                          ? "Send OTP"
                          : controller.step.value == 2
                          ? "Verify OTP"
                          : "Reset Password",
                      style: TextStyle(fontSize: 16.sp, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

//
// -------------------- INPUT WIDGETS --------------------
//

class _EmailInput extends StatelessWidget {
  final ForgotPasswordController controller;
  const _EmailInput({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Email Address",
          style: TextStyle(fontSize: 14.sp, color: Colors.black87),
        ),
        SizedBox(height: 8.h),
        TextField(
          controller: controller.emailController,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            hintText: "Enter your registered email",
            prefixIcon: const Icon(Icons.email_outlined),

            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          ),
        ),
      ],
    );
  }
}

class _OtpInput extends StatelessWidget {
  final ForgotPasswordController controller;
  const _OtpInput({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Enter OTP",
          style: TextStyle(fontSize: 14.sp, color: Colors.black87),
        ),
        SizedBox(height: 8.h),
        TextField(
          controller: controller.otpController,
          keyboardType: TextInputType.number,
          maxLength: 6,
          textAlign: TextAlign.center,
          decoration: InputDecoration(
            counterText: "",
            hintText: "6-digit code",
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          ),
        ),
        SizedBox(height: 10.h),
        Align(
          alignment: Alignment.centerRight,
          child: TextButton(
            onPressed: () => controller.handleNext(),
            child: Text(
              "Resend OTP",
              style: TextStyle(
                color: AppColors.primary,
                fontWeight: FontWeight.w500,
                fontSize: 14.sp,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _PasswordInput extends StatelessWidget {
  final ForgotPasswordController controller;
  const _PasswordInput({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        children: [
          TextField(
            controller: controller.newPasswordController,
            obscureText: controller.hidePassword.value,
            decoration: InputDecoration(
              hintText: "New Password",
              prefixIcon: const Icon(Icons.lock_outline),
              suffixIcon: IconButton(
                icon: Icon(
                  controller.hidePassword.value
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                ),
                onPressed: controller.togglePasswordVisibility,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          SizedBox(height: 15.h),
          TextField(
            controller: controller.confirmPasswordController,
            obscureText: controller.hidePassword.value,
            decoration: InputDecoration(
              hintText: "Confirm Password",
              prefixIcon: const Icon(Icons.lock),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
