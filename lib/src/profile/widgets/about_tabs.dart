import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hicoach_coach/src/profile/controller/profile_controller.dart';
import 'package:hicoach_coach/src/profile/widgets/info_text.dart';

class CoachAboutTabs extends StatelessWidget {
  const CoachAboutTabs({super.key, required this.controller});

  final ProfileController controller;

  @override
  Widget build(BuildContext context) {
    final selectedIndex = controller.coachInfoSelectedIndex.value;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
      child: Container(
        height: 45.h,
        padding: EdgeInsets.all(4.w),
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(14.r),
        ),
        child: LayoutBuilder(
          builder: (context, constraints) {
            double tabWidth = constraints.maxWidth / 3;

            return Stack(
              children: [
                // 🔹 Sliding highlight background
                AnimatedPositioned(
                  duration: const Duration(milliseconds: 220),
                  curve: Curves.fastOutSlowIn,
                  left: tabWidth * selectedIndex,
                  child: Container(
                    width: tabWidth,
                    height: 37.h,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12.r),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 6,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                  ),
                ),

                Row(
                  children: [
                    InfoText(
                      label: "Resume",
                      index: 0,
                      selectedIndex: selectedIndex,
                      controller: controller,
                    ),
                    InfoText(
                      controller: controller,
                      label: "Programs",
                      index: 1,
                      selectedIndex: selectedIndex,
                    ),
                    InfoText(
                      controller: controller,
                      label: "Reviews",
                      index: 2,
                      selectedIndex: selectedIndex,
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
