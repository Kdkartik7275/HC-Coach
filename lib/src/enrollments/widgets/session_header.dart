import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hicoach_coach/core/constants/colors.dart';
import 'package:hicoach_coach/models/enrollment_model.dart';
import 'package:hicoach_coach/models/student.dart';

class SessionHeader extends StatelessWidget {
  final EnrollmentModel enrollment;
  final Student? student;

  const SessionHeader({super.key, required this.enrollment, this.student});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;

    return Container(
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(14.r),
      ),
      child: Row(
        children: [
          Container(
            width: 42.w,
            height: 42.w,
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha:  0.12),
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: student?.profileUrls?.firstOrNull != null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(8.r),
                    child: Image.network(
                      student!.profileUrls!.first,
                      fit: BoxFit.cover,
                      errorBuilder: (_, _, _) => Icon(
                        CupertinoIcons.person_fill,
                        color: AppColors.primary,
                      ),
                    ),
                  )
                : Icon(CupertinoIcons.person_fill, color: AppColors.primary),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  student?.fullName ?? "Student Name",
                  style: theme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  enrollment.program.title,
                  style: theme.labelSmall?.copyWith(
                    color: AppColors.textLighter,
                  ),
                ),
                SizedBox(height: 4.h),
                Row(
                  children: [
                    Icon(
                      CupertinoIcons.clock,
                      size: 13.sp,
                      color: AppColors.textLighter,
                    ),
                    SizedBox(width: 4.w),
                    Text(enrollment.sessions.first.slot),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
