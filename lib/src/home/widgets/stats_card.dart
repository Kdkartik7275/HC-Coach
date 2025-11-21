import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hicoach_coach/core/constants/colors.dart';

class StatsCard extends StatelessWidget {
  final TextTheme theme;

  const StatsCard({required this.theme, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.primary,
            AppColors.primary.withOpacity(0.8),
          ],
        ),
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.3),
            blurRadius: 12,
          ),
        ],
      ),
      child: Row(
        children: [
          _statItem("8", "Programs", CupertinoIcons.book_fill),
          _divider(),
          _statItem("24", "Students", CupertinoIcons.person_2_fill),
          _divider(),
          _statItem("156", "Sessions", CupertinoIcons.checkmark_seal_fill),
        ],
      ),
    );
  }

  Widget _divider() => Container(
        width: 1,
        height: 40.h,
        color: Colors.white.withOpacity(0.3),
      );

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
          Text(
            label,
            style: theme.titleSmall?.copyWith(
              color: Colors.white70,
            ),
          ),
        ],
      ),
    );
  }
}
