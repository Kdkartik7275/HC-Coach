import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hicoach_coach/core/constants/app_pages.dart';
import 'package:hicoach_coach/core/constants/colors.dart';
import 'package:hicoach_coach/src/home/widgets/draggable_floating_button.dart';

import '../widgets/stats_card.dart';
import '../widgets/section_header.dart';
import '../widgets/today_session_card.dart';
import '../widgets/upcoming_session_card.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;

    return Stack(
      children: [
        Scaffold(
          backgroundColor: AppColors.white,
          body: SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  
                  // HEADER
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Schedule", style: theme.headlineSmall),
                          SizedBox(height: 4.h),
                          Text(
                            "Manage your bookings & programs",
                            style: theme.titleSmall?.copyWith(
                              color: AppColors.textLighter,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        padding: EdgeInsets.all(10.w),
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(12.r),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.04),
                              blurRadius: 8,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Icon(CupertinoIcons.calendar, size: 22.sp),
                      ),
                    ],
                  ),
        
                  SizedBox(height: 24.h),
        
                  // STATS CARD
                  StatsCard(theme: theme),
        
                  SizedBox(height: 24.h),
        
                  // TODAY'S SESSIONS
                  SectionHeader(title: "Today's Sessions", count: "3 bookings"),
                  SizedBox(height: 12.h),
        
                  TodaySessionCard(
                    theme: theme,
                    time: "7:00 AM",
                    studentName: "Rahul Sharma",
                    programName: "Weight Loss Intensive",
                    sessionNumber: "Session 5/12",
                    level: "Intermediate",
                    color: AppColors.primary,
                  ),
        
                  SizedBox(height: 12.h),
        
                  TodaySessionCard(
                    theme: theme,
                    time: "10:00 AM",
                    studentName: "Priya Verma",
                    programName: "Strength & Conditioning",
                    sessionNumber: "Session 2/20",
                    level: "Beginner",
                    color: AppColors.green,
                  ),
        
                  SizedBox(height: 12.h),
        
                  TodaySessionCard(
                    theme: theme,
                    time: "4:00 PM",
                    studentName: "Amit Patel",
                    programName: "Athletic Performance",
                    sessionNumber: "Session 8/15",
                    level: "Advanced",
                    color: Color(0xFF6366F1),
                  ),
        
                  SizedBox(height: 28.h),
        
                  // UPCOMING SESSIONS
                  SectionHeader(title: "Upcoming Sessions", count: "5 scheduled"),
                  SizedBox(height: 12.h),
        
                  UpcomingSessionCard(
                    theme: theme,
                    day: "Tomorrow",
                    date: "Nov 22",
                    time: "6:00 AM",
                    studentName: "Mohit Kumar",
                    programName: "Cardio & HIIT Program",
                    sessionNumber: "3/16",
                  ),
                ],
              ),
            ),
          ),
        ),

         DraggableFAB(
      onPressed: () => Get.toNamed(Routes.CreateTrainingProgram),
      child: Row(
        children: [
          Icon(CupertinoIcons.add, color: Colors.white),
          SizedBox(width: 6),
          Text(
            "Create Program",
            style: Theme.of(context)
                .textTheme
                .titleSmall!
                .copyWith(color: Colors.white),
          ),
        ],
      ),
    ),
      ],
    );
  }
}
