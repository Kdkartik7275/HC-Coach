// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/state_manager.dart';

import 'package:hicoach_coach/core/constants/colors.dart';
import 'package:hicoach_coach/models/enrollment_model.dart';
import 'package:hicoach_coach/models/student.dart';
import 'package:hicoach_coach/src/enrollments/controller/enrollments_controller.dart';
import 'package:hicoach_coach/src/enrollments/view/mark_attendance_page.dart';

class ActiveEnrollmentCard extends GetView<EnrollmentsController> {
  final TextTheme theme;
  final EnrollmentModel enrollment;

  const ActiveEnrollmentCard({
    super.key,
    required this.theme,
    required this.enrollment,
  });

  double get progress {
    if (enrollment.sessions.isEmpty) return 0;
    final completed = enrollment.sessions
        .where((s) => s.status == "completed")
        .length;
    return completed / enrollment.sessions.length;
  }

  int get completed =>
      enrollment.sessions.where((s) => s.status == "completed").length;

  void openAttendanceSheet(BuildContext context,Student student) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: Colors.transparent,
      builder: (_) =>
          MarkAttendanceBottomSheet(enrollment: enrollment, student: student),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
       () {
        final student = controller.studentsCache[enrollment.studentId];
        return Container(
          margin: EdgeInsets.symmetric(vertical: 6.h),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(16.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 14,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Padding(
            padding: EdgeInsets.all(14.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// HEADER: AVATAR + NAME + STATUS
                Row(
                  children: [
                    _Avatar(student: student),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            student?.fullName ?? "Student Name",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: theme.titleSmall?.copyWith(
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(height: 2.h),
                          Text(
                            enrollment.program.title,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: theme.titleSmall?.copyWith(
                              color: AppColors.textLighter,
                              fontSize: 12.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                    _StatusBadge(),
                  ],
                ),
        
                SizedBox(height: 14.h),
        
                /// TIME + SESSION COUNT
                Row(
                  children: [
                    Icon(
                      CupertinoIcons.clock,
                      size: 14.sp,
                      color: AppColors.textLighter,
                    ),
                    SizedBox(width: 6.w),
                    Text(
                      enrollment.sessions.first.slot,
                      style: theme.titleSmall?.copyWith(
                        color: AppColors.textLighter,
                        fontSize: 12.sp,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      "$completed / ${enrollment.sessions.length} sessions",
                      style: theme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w500,
                        fontSize: 12.sp,
                        color: AppColors.textLighter,
                      ),
                    ),
                  ],
                ),
        
                SizedBox(height: 10.h),
        
                /// PROGRESS
                ClipRRect(
                  borderRadius: BorderRadius.circular(6.r),
                  child: LinearProgressIndicator(
                    value: progress,
                    minHeight: 6.h,
                    backgroundColor: AppColors.filled,
                    valueColor: AlwaysStoppedAnimation(AppColors.primary),
                  ),
                ),
        
                SizedBox(height: 16.h),
        
                /// CTA
                InkWell(
                  borderRadius: BorderRadius.circular(10.r),
                  onTap: () => openAttendanceSheet(context,student!),
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(vertical: 11.h),
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: Text(
                      "Mark Attendance",
                      textAlign: TextAlign.center,
                      style: theme.titleSmall?.copyWith(
                        color: Colors.white,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }
    );
  }
}

class _Avatar extends StatelessWidget {
  final Student? student;

  const _Avatar({this.student});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 44.w,
      height: 44.w,
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12.r),
        child: student?.profileUrls?.isNotEmpty == true
            ? Image.network(student!.profileUrls!.first, fit: BoxFit.cover)
            : Icon(
                CupertinoIcons.person_fill,
                size: 22.sp,
                color: AppColors.primary,
              ),
      ),
    );
  }
}

class _StatusBadge extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: Colors.green.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Text(
        "Active",
        style: Theme.of(context).textTheme.titleSmall?.copyWith(
          color: Colors.green.shade700,
          fontWeight: FontWeight.normal,
          fontSize: 12.sp,
        ),
      ),
    );
  }
}

class MarkAttendanceBottomSheet extends StatelessWidget {
  final EnrollmentModel enrollment;
  final Student? student;

  const MarkAttendanceBottomSheet({
    super.key,
    required this.enrollment,
    this.student,
  });

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.8,
      minChildSize: 0.4,
      maxChildSize: 0.95,
      expand: false,
      builder: (_, scrollController) {
        return Container(
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
          ),
          child: SingleChildScrollView(
            controller: scrollController,
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: MarkAttendanceContent(
              enrollment: enrollment,
              student: student,
            ),
          ),
        );
      },
    );
  }
}
