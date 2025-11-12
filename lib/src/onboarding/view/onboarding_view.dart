import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hicoach_coach/core/constants/colors.dart';
import 'package:hicoach_coach/src/onboarding/controller/onboarding_controller.dart';

class OnboardingScreen extends GetView<OnboardingController> {
  OnboardingScreen({super.key});

  final List<Map<String, String>> pages = [
    {
      'title': 'Grow Your Coaching Career',
      'subtitle':
          'Connect with aspiring athletes and share your expertise to make a real impact.',
      'image': 'assets/images/onboarding1.png',
    },
    {
      'title': 'Manage Bookings Effortlessly',
      'subtitle':
          'Handle session requests, schedules, and students — all in one place.',
      'image': 'assets/images/onboarding2.png',
    },
    {
      'title': 'Track Student Progress',
      'subtitle':
          'Monitor performance, provide feedback, and help students achieve their goals.',
      'image': 'assets/images/onboarding3.png',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Obx(
            () => controller.currentPage.value < pages.length - 1
                ? TextButton(
                    onPressed: controller.skip,
                    child: Text(
                      "Skip",
                      style: TextStyle(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w500,
                        fontSize: 15.sp,
                      ),
                    ),
                  )
                : const SizedBox.shrink(),
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.white, Color(0xFFF5F8FF)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
            child: Column(
              children: [
                // PageView
                Expanded(
                  child: PageView.builder(
                    controller: controller.pageController,
                    onPageChanged: controller.onPageChanged,
                    itemCount: pages.length,
                    itemBuilder: (context, index) {
                      final item = pages[index];
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 600),
                            curve: Curves.easeOut,
                            child: Image.asset(
                              item['image']!,
                              height: 280.h,
                              fit: BoxFit.contain,
                            ),
                          ),
                          SizedBox(height: 50.h),
                          Text(
                            item['title']!,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 20.sp,
                              fontWeight: FontWeight.bold,
                              color: AppColors.text,
                              height: 1.3,
                            ),
                          ),
                          SizedBox(height: 14.h),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 12.w),
                            child: Text(
                              item['subtitle']!,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: Colors.grey[600],
                                height: 1.5,
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),

                SizedBox(height: 40.h),

                // Dots
                _buildDots(),

                SizedBox(height: 40.h),

                // Next / Get Started Button
                _buildButton(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDots() {
    return Obx(
      () => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
          pages.length,
          (index) => AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            margin: EdgeInsets.symmetric(horizontal: 5.w),
            height: 8.h,
            width: controller.currentPage.value == index ? 24.w : 8.w,
            decoration: BoxDecoration(
              color: controller.currentPage.value == index
                  ? AppColors.primary
                  : Colors.grey[300],
              borderRadius: BorderRadius.circular(8.r),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildButton(BuildContext context) {
    return Obx(() {
      bool isLastPage = controller.currentPage.value == pages.length - 1;
      return AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        width: double.infinity,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            elevation: 0,
            backgroundColor: AppColors.primary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14.r),
            ),
            padding: EdgeInsets.symmetric(vertical: 15.h),
          ),
          onPressed: controller.nextPage,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                isLastPage ? "Get Started" : "Next",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              if (!isLastPage) ...[
                SizedBox(width: 6.w),
                const Icon(
                  Icons.arrow_forward_rounded,
                  color: Colors.white,
                  size: 20,
                ),
              ],
            ],
          ),
        ),
      );
    });
  }
}
