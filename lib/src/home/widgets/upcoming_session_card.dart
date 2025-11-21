import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hicoach_coach/core/constants/colors.dart';

class UpcomingSessionCard extends StatelessWidget {
  final TextTheme theme;
  final String day;
  final String date;
  final String time;
  final String studentName;
  final String programName;
  final String sessionNumber;

  const UpcomingSessionCard({
    required this.theme,
    required this.day,
    required this.date,
    required this.time,
    required this.studentName,
    required this.programName,
    required this.sessionNumber,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColors.border.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          Container(
            width: 56.w,
            padding: EdgeInsets.symmetric(vertical: 10.h),
            decoration: BoxDecoration(
              color: AppColors.filled,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Column(
              children: [
                Text(
                  date.split(' ')[1],
                  style: theme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                    fontSize: 18.sp,
                  ),
                ),
                Text(
                  date.split(' ')[0],
                  style: theme.titleSmall?.copyWith(
                    color: AppColors.textLighter,
                  ),
                ),
              ],
            ),
          ),

          SizedBox(width: 14.w),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(day, style: theme.titleMedium),
                    SizedBox(width: 8.w),
                    Container(
                        width: 4.w,
                        height: 4.w,
                        decoration: BoxDecoration(
                            color: AppColors.textLighter,
                            shape: BoxShape.circle)),
                    SizedBox(width: 8.w),
                    Text(time,
                        style: theme.titleSmall
                            ?.copyWith(color: AppColors.textLighter)),
                  ],
                ),

                SizedBox(height: 6.h),

                Text(
                  studentName,
                  style: theme.titleSmall
                      ?.copyWith(fontWeight: FontWeight.w600),
                ),

                SizedBox(height: 2.h),

                Row(
                  children: [
                    Icon(CupertinoIcons.book,
                        size: 12.sp, color: AppColors.textLighter),
                    SizedBox(width: 4.w),
                    Expanded(
                      child: Text(
                        programName,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: theme.titleSmall
                            ?.copyWith(color: AppColors.textLighter),
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Text(
                      sessionNumber,
                      style: theme.titleSmall?.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          Icon(CupertinoIcons.chevron_right,
              size: 18.sp, color: AppColors.textLighter),
        ],
      ),
    );
  }
}
