import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hicoach_coach/core/constants/colors.dart';

class TodaySessionCard extends StatelessWidget {
  final TextTheme theme;
  final String time;
  final String studentName;
  final String programName;
  final String sessionNumber;
  final String level;
  final Color color;

  const TodaySessionCard({
    required this.theme,
    required this.time,
    required this.studentName,
    required this.programName,
    required this.sessionNumber,
    required this.level,
    required this.color,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
          ),
        ],
      ),
      child: Column(
        children: [
          // TIME + LEVEL
          Row(
            children: [
              Container(
                padding:
                    EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Row(
                  children: [
                    Icon(CupertinoIcons.clock_fill,
                        size: 14.sp, color: color),
                    SizedBox(width: 6.w),
                    Text(
                      time,
                      style: theme.titleSmall?.copyWith(
                        color: color,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
              Spacer(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: AppColors.filled,
                  borderRadius: BorderRadius.circular(6.r),
                ),
                child: Text(
                  level,
                  style: theme.titleSmall
                      ?.copyWith(color: AppColors.textLighter),
                ),
              ),
            ],
          ),

          SizedBox(height: 14.h),

          // STUDENT INFO
          Row(
            children: [
              Container(
                width: 40.w,
                height: 40.w,
                decoration: BoxDecoration(
                  color: color.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Icon(CupertinoIcons.person_fill,
                    color: color, size: 20.sp),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(studentName,
                        style: theme.titleMedium?.copyWith(fontSize: 15.sp)),
                    SizedBox(height: 2.h),
                    Text(
                      programName,
                      style: theme.titleSmall?.copyWith(
                        color: AppColors.textLighter,
                        fontSize: 12.sp,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          SizedBox(height: 12.h),

          // PROGRESS + ACTION
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Progress",
                        style: theme.titleSmall
                            ?.copyWith(color: AppColors.textLighter)),
                    SizedBox(height: 6.h),
                    Row(
                      children: [
                        Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(4.r),
                            child: LinearProgressIndicator(
                              value: 0.4,
                              backgroundColor: AppColors.filled,
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(color),
                              minHeight: 6.h,
                            ),
                          ),
                        ),
                        SizedBox(width: 8.w),
                        Text(
                          sessionNumber,
                          style: theme.titleSmall
                              ?.copyWith(fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              InkWell(
                borderRadius: BorderRadius.circular(10.r),
                onTap: () {},
                child: Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: 16.w, vertical: 8.h),
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Text("Start",
                      style: theme.titleSmall
                          ?.copyWith(color: Colors.white)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
