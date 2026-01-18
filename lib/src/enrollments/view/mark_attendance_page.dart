// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:hicoach_coach/models/enrollment_model.dart';
import 'package:hicoach_coach/models/student.dart';
import 'package:hicoach_coach/src/enrollments/controller/enrollments_controller.dart';
import 'package:hicoach_coach/src/enrollments/widgets/attendance_card.dart';
import 'package:hicoach_coach/src/enrollments/widgets/session_header.dart';
class MarkAttendanceContent extends StatefulWidget {
  final EnrollmentModel enrollment;
  final Student? student;

  const MarkAttendanceContent({
    super.key,
    required this.enrollment,
    this.student,
  });

  @override
  State<MarkAttendanceContent> createState() =>
      MarkAttendanceContentState();
}

class MarkAttendanceContentState
    extends State<MarkAttendanceContent> {
  final TextEditingController otpController = TextEditingController();
  final controller = Get.find<EnrollmentsController>();

  @override
  void dispose() {
    otpController.dispose();
    controller.resetAttendanceFlow();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;

    return Padding(
      padding: EdgeInsets.all(16.w),
      child: Column(
        children: [
        
          SizedBox(height: 12.h),
          Text(
            "Session Attendance",
            style: theme.titleMedium?.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 16.h),
          SessionHeader(
            enrollment: widget.enrollment,
            student: widget.student,
          ),
          SizedBox(height: 20.h),
          AttendanceCard(
            enrollment: widget.enrollment,
            student: widget.student,
            otpController: otpController,
          ),
          SizedBox(height: 24.h),
        ],
      ),
    );
  }
}
