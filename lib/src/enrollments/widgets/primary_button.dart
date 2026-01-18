import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hicoach_coach/core/constants/colors.dart';
import 'package:hicoach_coach/src/enrollments/controller/enrollments_controller.dart';

class PrimaryButton extends StatelessWidget {
  final String label;
  final VoidCallback? onTap;
  final EnrollmentsController controller;
  const PrimaryButton({
    super.key,
    required this.label,
    this.onTap,
    required this.controller,
  });
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: onTap,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            padding: EdgeInsets.symmetric(vertical: 14.h),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.r),
            ),
          ),
          child: controller.isOtpSending.value
              ? Center(
                  child: SizedBox(
                    height: 20.h,
                    width: 20.h,
                    child: CircularProgressIndicator(color: AppColors.white),
                  ),
                )
              : Text(label),
        ),
      ),
    );
  }
}
