import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hicoach_coach/core/constants/colors.dart';
import 'package:hicoach_coach/src/enrollments/controller/enrollments_controller.dart';
import 'package:hicoach_coach/src/enrollments/widgets/primary_button.dart';

class VerifyOtpState extends StatelessWidget {
  final TextEditingController controller;
  final bool isVerifying;
  final VoidCallback onVerify;

  const VerifyOtpState({
    super.key,
    required this.controller,
    required this.isVerifying,
    required this.onVerify,
  });

  @override
  Widget build(BuildContext context) {
    final enrollmentController = Get.find<EnrollmentsController>();

    return Column(
      children: [
        const Text(
          "Enter OTP",
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
        SizedBox(height: 6.h),
        Text(
          "Ask the student for the 6-digit code",
          style: Theme.of(context)
              .textTheme
              .labelSmall
              ?.copyWith(color: AppColors.textLighter),
        ),
        SizedBox(height: 20.h),
        OtpInput(controller: controller),
        SizedBox(height: 24.h),
        PrimaryButton(
          label: isVerifying
              ? "Verifying..."
              : "Confirm Attendance",
          controller: enrollmentController,
          onTap: onVerify,
        ),
      ],
    );
  }
}

class OtpInput extends StatelessWidget {
  final TextEditingController controller;

  const OtpInput({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      maxLength: 6,
      textAlign: TextAlign.center,
      keyboardType: TextInputType.number,
      style: TextStyle(
        fontSize: 16.sp,
        fontWeight: FontWeight.w500,
        letterSpacing: 20.w,
      ),
      decoration: InputDecoration(
        counterText: "",
        hintText: "••••••",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14.r),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}

class SuccessState extends StatelessWidget {
  const SuccessState({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(
          CupertinoIcons.check_mark_circled_solid,
          size: 64.sp,
          color: Colors.green,
        ),
        SizedBox(height: 12.h),
        const Text(
          "Attendance Confirmed",
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
        const Text("Student marked present for this session"),
      ],
    );
  }
}
