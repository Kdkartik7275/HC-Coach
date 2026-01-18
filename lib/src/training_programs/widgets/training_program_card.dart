import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hicoach_coach/core/constants/colors.dart';
import 'package:hicoach_coach/models/training_program_model.dart';
import 'package:hicoach_coach/src/training_programs/view/training_details_view.dart';

class TrainingProgramCard extends StatelessWidget {
  final TrainingProgram program;
  const TrainingProgramCard({super.key, required this.program});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return Container(
      margin: EdgeInsets.only(bottom: 14.h),
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(14.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: .05),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
        border: Border.all(color: AppColors.border.withValues(alpha: .4)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // -------- TITLE & DURATION BADGE ----------
          Row(
            children: [
              Expanded(
                child: Text(
                  program.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: theme.titleLarge!.copyWith(
                    color: AppColors.text,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 3.h),
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: .12),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Text(
                  "${program.durationDays} days",
                  style: theme.titleSmall!.copyWith(
                    color: AppColors.primary,
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: 6.h),

          // -------- DESCRIPTION ----------
          Text(
            program.description,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: theme.titleSmall!.copyWith(
              color: AppColors.textLighter,
              fontWeight: FontWeight.normal,
              fontSize: 12.sp,
              height: 1.3,
            ),
          ),

          SizedBox(height: 12.h),

          // -------- TAGS (SPORT + LEVEL) ----------
          Row(
            children: [
              _tag(program.sport, Icons.sports_soccer),
              SizedBox(width: 6.w),
              _tag(program.level, Icons.speed),
            ],
          ),

          SizedBox(height: 14.h),

          // -------- PRICE & DETAILS BUTTON ----------
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "₹${program.price}",
                style: theme.titleLarge!.copyWith(
                  color: AppColors.green,
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),

              InkWell(
                borderRadius: BorderRadius.circular(10.r),
                onTap: () {
                  Get.to(() => TrainingProgramDetailsPage(program: program));
                },
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 12.w,
                    vertical: 8.h,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Row(
                    children: [
                      Text(
                        "Details",
                        style: theme.titleSmall!.copyWith(
                          color: AppColors.white,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(width: 4),
                      const Icon(
                        Icons.arrow_forward_ios,
                        size: 12,
                        color: AppColors.white,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // -------- SMALL TAG WIDGET ----------
  Widget _tag(String label, IconData icon) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: AppColors.filled,
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Row(
        children: [
          Icon(icon, size: 12, color: AppColors.textLighter),
          SizedBox(width: 4.w),
          Text(
            label,
            style: Theme.of(Get.context!).textTheme.titleSmall!.copyWith(
              fontSize: 11.sp,
              color: AppColors.textLighter,
            ),
          ),
        ],
      ),
    );
  }
}
