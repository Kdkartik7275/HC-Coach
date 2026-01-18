// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:hicoach_coach/core/constants/colors.dart';
import 'package:hicoach_coach/models/enrollment_model.dart';

class StatsCard extends StatelessWidget {
  final TextTheme theme;
  final List<EnrollmentModel> enrollments;

  const StatsCard({super.key, required this.theme, required this.enrollments});

  @override
  Widget build(BuildContext context) {
    final completedSessions = enrollments
        .expand((enrollment) => enrollment.sessions)
        .where((session) => session.status == "completed")
        .length;
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.8),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Row(
        children: [
          _statItem(
            "${enrollments.length}",
            "Programs",
            CupertinoIcons.book_fill,
          ),
          _divider(),
          _statItem(
            enrollments.length.toString(),
            "Students",
            CupertinoIcons.person_2_fill,
          ),
          _divider(),
          _statItem(
            "$completedSessions",
            "Sessions",
            CupertinoIcons.checkmark_seal_fill,
          ),
        ],
      ),
    );
  }

  Widget _divider() => Container(width: 1, height: 40.h, color: Colors.white);

  Widget _statItem(String value, String label, IconData icon) {
    return Expanded(
      child: Column(
        children: [
          Icon(icon, color: Colors.white, size: 24.sp),
          SizedBox(height: 8.h),
          Text(
            value,
            style: theme.titleLarge?.copyWith(
              color: Colors.white,
              fontSize: 20.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          Text(label, style: theme.titleSmall?.copyWith(color: Colors.white)),
        ],
      ),
    );
  }
}
