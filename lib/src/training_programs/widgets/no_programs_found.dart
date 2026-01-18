import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hicoach_coach/core/constants/app_pages.dart';
import 'package:hicoach_coach/core/constants/colors.dart';

class NoProgramsFound extends StatelessWidget {
  const NoProgramsFound({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // 🔹 Icon Circle
          Container(
            height: 110,
            width: 110,
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.08),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.library_books_outlined,
              size: 50,
              color: AppColors.primary.withOpacity(0.6),
            ),
          ),

          SizedBox(height: 20),

          // 🔹 Title (using titleMedium or titleLarge)
          Text(
            "No Training Programs",
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(color: AppColors.text),
          ),

          SizedBox(height: 8),

          // 🔹 Subtitle (using titleSmall)
          Text(
            "Create your first program to get started",
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
              color: AppColors.textLighter,
              fontWeight: FontWeight.w500,
            ),
          ),

          SizedBox(height: 24),

          // 🔹 Primary Button (no textstyle override)
          InkWell(
            onTap: () =>  Get.toNamed(Routes.CreateTrainingProgram),
            borderRadius: BorderRadius.circular(14),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 12),
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(14),
               
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.add, size: 20, color: Colors.white),
                  const SizedBox(width: 8),
                  Text(
                    "Create Program",
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
