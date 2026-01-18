import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hicoach_coach/core/constants/colors.dart';

Widget buildErrorWidget(VoidCallback onRetry) {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(Icons.error_outline, color: Colors.redAccent, size: 50),
        SizedBox(height: 10.h),
        Text(
          "Something went wrong!",
          style: Theme.of(Get.context!)
              .textTheme
              .titleMedium!
              .copyWith(color: Colors.red),
        ),
        SizedBox(height: 5.h),
        Text(
          "Please try again.",
          style: Theme.of(Get.context!)
              .textTheme
              .titleSmall!
              .copyWith(color: AppColors.border),
        ),
        SizedBox(height: 15.h),
        ElevatedButton(
          onPressed: onRetry,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.redAccent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: const Text("Retry", style: TextStyle(color: Colors.white)),
        ),
      ],
    ),
  );
}
