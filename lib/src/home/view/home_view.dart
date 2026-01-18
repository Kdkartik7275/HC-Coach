import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hicoach_coach/common/indicators/progress_indicators.dart';
import 'package:hicoach_coach/core/constants/app_pages.dart';
import 'package:hicoach_coach/core/constants/colors.dart';
import 'package:hicoach_coach/src/enrollments/controller/enrollments_controller.dart';
import 'package:hicoach_coach/src/enrollments/view/new_enrollments.dart';
import 'package:hicoach_coach/src/home/widgets/draggable_floating_button.dart';
import 'package:hicoach_coach/src/profile/controller/profile_controller.dart';
import 'package:loading_overlay/loading_overlay.dart';
import '../widgets/stats_card.dart';
import '../widgets/section_header.dart';
import '../widgets/active_enrollment_card.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late EnrollmentsController enrollmentsController;
  final coach = Get.find<ProfileController>().user;

  @override
  void initState() {
    super.initState();
    enrollmentsController = Get.put(EnrollmentsController());
    enrollmentsController.fetchActiveEnrollments(coach!.userId);
    enrollmentsController.fetchNewEnrollments(coach!.userId);
  }

  Future<void> _refreshData() async {
    await Future.wait([
      enrollmentsController.fetchActiveEnrollments(coach!.userId),
      enrollmentsController.fetchNewEnrollments(coach!.userId),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;

    return Stack(
      children: [
        Scaffold(
          backgroundColor: AppColors.white,
          body: Obx(() {
            final count = enrollmentsController.activeEnrollments.length;

            return LoadingOverlay(
              isLoading: enrollmentsController.isLoading.value,
              progressIndicator: circularProgress(context),
              color: Colors.black12,
              child: SafeArea(
                child: RefreshIndicator(
                  backgroundColor: AppColors.white,
                  color: AppColors.primary,
                  onRefresh: _refreshData,
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 16.h,
                    ),
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
                                Text("Schedule", style: theme.titleMedium),
                                Text(
                                  "Manage your bookings & programs",
                                  style: theme.titleSmall?.copyWith(
                                    color: AppColors.textLighter,
                                  ),
                                ),
                              ],
                            ),
                            GestureDetector(
                              onTap: () => Get.to(() => NewEnrollmentsPage()),
                              child: Stack(
                                clipBehavior: Clip.none,
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(10.w),
                                    decoration: BoxDecoration(
                                      color: AppColors.primary.withValues(
                                        alpha: 0.1,
                                      ),
                                      borderRadius: BorderRadius.circular(12.r),
                                    ),
                                    child: Icon(
                                      CupertinoIcons
                                          .person_crop_circle_badge_plus,
                                      size: 22.sp,
                                      color: AppColors.primary,
                                    ),
                                  ),

                                  /// BADGE
                                  if (enrollmentsController
                                      .newEnrollments
                                      .isNotEmpty)
                                    Positioned(
                                      top: -6,
                                      right: -6,
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 6.w,
                                          vertical: 2.h,
                                        ),
                                        decoration: BoxDecoration(
                                          color: Colors.redAccent,
                                          borderRadius: BorderRadius.circular(
                                            10.r,
                                          ),
                                        ),
                                        child: Text(
                                          enrollmentsController
                                              .newEnrollments
                                              .length
                                              .toString(),
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 10.sp,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: 24.h),

                        SectionHeader(
                          title: "Active Programs",
                          count:
                              "$count ${count == 1 ? 'booking' : 'bookings'}",
                        ),

                        SizedBox(height: 12.h),
                        // STATS CARD
                        StatsCard(
                          theme: theme,
                          enrollments: enrollmentsController.activeEnrollments,
                        ),

                        SizedBox(height: 24.h),

                        ListView.separated(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount:
                              enrollmentsController.activeEnrollments.length,
                          itemBuilder: (context, index) {
                            final enrollment =
                                enrollmentsController.activeEnrollments[index];
                            return ActiveEnrollmentCard(
                              theme: theme,
                              enrollment: enrollment,
                            );
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            return SizedBox(height: 16.h);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }),
        ),

        DraggableFAB(
          onPressed: () => Get.toNamed(Routes.CreateTrainingProgram),
          child: Row(
            children: [
              Icon(CupertinoIcons.add, color: Colors.white),
              SizedBox(width: 6),
              Text(
                "Create Program",
                style: Theme.of(
                  context,
                ).textTheme.titleSmall!.copyWith(color: Colors.white),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
