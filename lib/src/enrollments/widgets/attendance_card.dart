import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hicoach_coach/common/dialogs/info_dialog.dart';
import 'package:hicoach_coach/core/constants/colors.dart';
import 'package:hicoach_coach/models/enrollment_model.dart';
import 'package:hicoach_coach/models/student.dart';
import 'package:hicoach_coach/src/enrollments/controller/enrollments_controller.dart';
import 'package:hicoach_coach/src/enrollments/widgets/send_otp_state.dart';
import 'package:hicoach_coach/src/enrollments/widgets/verify_otp.dart';
import 'package:intl/intl.dart';

class AttendanceCard extends StatelessWidget {
  final EnrollmentModel enrollment;
  final Student? student;
  final TextEditingController otpController;

  const AttendanceCard({
    super.key,
    required this.enrollment,
    required this.student,
    required this.otpController,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<EnrollmentsController>();

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha:  0.06),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Obx(() {
        if (controller.isVerified.value) {
          return SuccessState();
        }

        if (!controller.isOtpSent.value) {
          return SendOtpState(
            student: student,
            onSend: () {
              if(controller.selectedOtpMethod.value == OtpSendMethod.email) {
                 controller.sendAttendanceOtpEmail(
              email: student?.email ?? '',
              programName: enrollment.program.title,
              sessionDate:
                  DateFormat('dd MMM yyyy').format(DateTime.now()),
            );
                return;
              }
              showInfoDialog("Phone OTP is not implemented yet.");
            }
          );
        }

        return VerifyOtpState(
          controller: otpController,
          isVerifying: controller.isVerifying.value,
          onVerify: () => controller.verifyAttendanceOtp(
            otpController.text.trim(),
            enrollment.id,
          ),
        );
      }),
    );
  }
}
