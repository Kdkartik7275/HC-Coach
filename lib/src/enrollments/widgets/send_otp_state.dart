import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hicoach_coach/core/constants/colors.dart';
import 'package:hicoach_coach/models/student.dart';
import 'package:hicoach_coach/src/enrollments/controller/enrollments_controller.dart';
import 'package:hicoach_coach/src/enrollments/widgets/otp_method_selector.dart';
import 'package:hicoach_coach/src/enrollments/widgets/primary_button.dart';

class SendOtpState extends StatelessWidget {
  final VoidCallback onSend;
  final Student? student;

  const SendOtpState({super.key, required this.onSend, this.student});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<EnrollmentsController>();

    return Column(
      children: [
        Icon(CupertinoIcons.lock_shield, size: 48.sp, color: AppColors.primary),
        SizedBox(height: 12.h),
        const Text(
          "Verify Student Presence",
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
        SizedBox(height: 6.h),
        Text(
          "Send an OTP to the student to confirm attendance",
          textAlign: TextAlign.center,
          style: Theme.of(
            context,
          ).textTheme.labelSmall?.copyWith(color: AppColors.textLighter),
        ),
        SizedBox(height: 20.h),
        OtpMethodSelector(key, student),
        SizedBox(height: 20.h),
        PrimaryButton(label: "Send OTP", onTap: onSend, controller: controller),
      ],
    );
  }
}
