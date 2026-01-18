import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hicoach_coach/common/animation/animated_wrapper.dart';
import 'package:hicoach_coach/core/constants/app_images.dart';
import 'package:hicoach_coach/core/constants/colors.dart';
import 'package:hicoach_coach/core/constants/strings.dart';
import 'package:hicoach_coach/src/chats/controller/chats_controller.dart';
import 'package:hicoach_coach/src/navbar/controller/bottom_navbar_controller.dart';

class CoachTabs extends StatefulWidget {
  const CoachTabs({super.key});

  @override
  State<CoachTabs> createState() => _CoachTabsState();
}

class _CoachTabsState extends State<CoachTabs> {
  late BottomNavBarController controller;
  late ChatController chatController;

  @override
  void initState() {
    super.initState();
    controller = Get.put(BottomNavBarController());
    chatController = Get.put(ChatController());
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: AppBar(
          title: Text(
            AppStrings.appName,
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
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
                icon: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Image.asset(AppIcons.messages, height: 30.h, width: 30.w),
                    if(chatController.unreadChatsCount >0)
                    Positioned(
                      right:chatController.unreadChatsCount > 4?  -5 : 0,
                      top: -12,
                      child: Container(
                        padding: EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                        child: Text(
                          chatController.unreadChatsCount > 4
                              ? "4+"
                              : chatController.unreadChatsCount.toString(),
                          style: Theme.of(context).textTheme.titleSmall!
                              .copyWith(
                                color: AppColors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 10.sp,
                              ),
                        ),
                      ),
                    ),
                  ],
                ),
                activeIcon: Image.asset(
                  AppIcons.messages,
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
