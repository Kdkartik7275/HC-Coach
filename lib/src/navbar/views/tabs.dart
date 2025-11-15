import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hicoach_coach/common/animation/animated_wrapper.dart';
import 'package:hicoach_coach/core/constants/app_images.dart';
import 'package:hicoach_coach/core/constants/colors.dart';
import 'package:hicoach_coach/core/constants/strings.dart';
import 'package:hicoach_coach/src/navbar/controller/bottom_navbar_controller.dart';

class CoachTabs extends GetView<BottomNavBarController> {
  const CoachTabs({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: AppBar(title:  Text(AppStrings.appName,style: Theme.of(context).textTheme.titleMedium)),
        body: AnimatedScreenWrapper(
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 400),
            transitionBuilder: (child, animation) {
              return SlideTransition(
                position:
                    Tween<Offset>(
                      begin: const Offset(1.0, 0.0),
                      end: Offset.zero,
                    ).animate(
                      CurvedAnimation(
                        parent: animation,
                        curve: Curves.easeInOutCubic,
                      ),
                    ),
                child: child,
              );
            },
            child: KeyedSubtree(
              key: ValueKey(controller.selectedIndex.value),
              child: controller.studentPages[controller.selectedIndex.value],
            ),
          ),
        ),

        bottomNavigationBar: Theme(
          data: Theme.of(context).copyWith(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
          ),
          child: BottomNavigationBar(
            backgroundColor: AppColors.white,

            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Image.asset(AppIcons.home, height: 30.h, width: 30.w),
                activeIcon: Image.asset(
                  AppIcons.home,
                  height: 30.h,
                  width: 30.w,
                  color: AppColors.primary,
                ),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Image.asset(
                  AppIcons.favourite,
                  height: 30.h,
                  width: 30.w,
                ),
                activeIcon: Image.asset(
                  AppIcons.favourite_fill,
                  height: 30.h,
                  width: 30.w,
                  color: AppColors.primary,
                ),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Image.asset(
                  AppIcons.calender_fill,
                  height: 30.h,
                  width: 30.w,
                ),
                activeIcon: Image.asset(
                  AppIcons.calender_fill,
                  height: 30.h,
                  width: 30.w,
                  color: AppColors.primary,
                ),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Image.asset(
                  AppIcons.notifications,
                  height: 30.h,
                  width: 30.w,
                ),
                activeIcon: Image.asset(
                  AppIcons.notifications_fill,
                  height: 30.h,
                  width: 30.w,
                  color: AppColors.primary,
                ),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Image.asset(AppIcons.profile, height: 30.h, width: 30.w),
                activeIcon: Image.asset(
                  AppIcons.profile,
                  height: 30.h,
                  width: 30.w,
                  color: AppColors.primary,
                ),
                label: '',
              ),
            ],
            currentIndex: controller.selectedIndex.value,
            selectedItemColor: AppColors.primary,
            unselectedItemColor: AppColors.border,
            onTap: controller.onItemTapped,
            elevation: 0,
            type: BottomNavigationBarType.fixed,
          ),
        ),
      ),
    );
  }
}
