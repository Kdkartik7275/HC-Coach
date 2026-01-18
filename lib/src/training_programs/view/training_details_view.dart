import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hicoach_coach/common/indicators/progress_indicators.dart';
import 'package:hicoach_coach/core/constants/colors.dart';
import 'package:hicoach_coach/models/training_program_model.dart';
import 'package:hicoach_coach/src/training_programs/controller/training_programs_controller.dart';
import 'package:loading_overlay/loading_overlay.dart';

import '../../../core/constants/app_pages.dart';

class TrainingProgramDetailsPage extends GetView<TrainingProgramsController> {
  const TrainingProgramDetailsPage({super.key, required this.program});

  final TrainingProgram program;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0.4,
        title: Text(
          "Program Details",
          style: textTheme.titleLarge!.copyWith(fontSize: 18),
        ),
      ),
      body: Obx(
        () => LoadingOverlay(
          isLoading: controller.deleting.value,
          progressIndicator: circularProgress(context),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (program.thumbnailUrl != null &&
                    program.thumbnailUrl!.isNotEmpty)
                  ...[_thumbnailBanner(program.thumbnailUrl!),
                const SizedBox(height: 20)],

                _header(context),

                const SizedBox(height: 20),
                _sectionTitle("Program Overview", textTheme),

                const SizedBox(height: 10),
                _infoTile("Sport", program.sport, textTheme),
                _infoTile("Level", program.level, textTheme),
                _infoTile(
                  "Duration",
                  "${program.durationDays} days",
                  textTheme,
                ),
                _infoTile(
                  "Total Sessions",
                  "${program.totalSessions}",
                  textTheme,
                ),
                _infoTile("Frequency", program.frequency.toString(), textTheme),
                _infoTile(
                  "Price",
                  "₹${program.price.toStringAsFixed(0)}",
                  textTheme,
                ),

                const SizedBox(height: 24),
                _sectionTitle("About this Program", textTheme),
                const SizedBox(height: 6),
                _descriptionBox(program.description, textTheme),

                const SizedBox(height: 20),
                _sectionTitle("What You Will Learn", textTheme),
                const SizedBox(height: 6),
                _bulletBox(program.learningOutcomes, textTheme),

                const SizedBox(height: 20),
                _sectionTitle("Requirements", textTheme),
                const SizedBox(height: 6),
                _bulletBox(program.requirements, textTheme),

                const SizedBox(height: 40),
                _actionButtons(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _thumbnailBanner(String url) {
    return Container(
      height: 180.h,
      width: double.infinity,
      margin: EdgeInsets.only(bottom: 16.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: .08),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(14.r),
        child: Image.network(url, fit: BoxFit.cover),
      ),
    );
  }

  // ---------------- HEADER BOX ----------------

  Widget _header(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: .08),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Text(
        program.title,
        textAlign: TextAlign.center,
        style: textTheme.titleLarge!.copyWith(color: AppColors.primary),
      ),
    );
  }

  // ---------------- SECTION TITLE ----------------

  Widget _sectionTitle(String text, TextTheme textTheme) {
    return Text(
      text,
      style: textTheme.titleLarge!.copyWith(
        fontSize: 15.sp,
        fontWeight: FontWeight.normal,
      ),
    );
  }

  // ---------------- INFO TILE ----------------

  Widget _infoTile(String label, String value, TextTheme textTheme) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: textTheme.titleSmall!.copyWith(
              fontSize: 13.sp,
              color: AppColors.textLighter,
            ),
          ),
          Text(
            value,
            style: textTheme.titleSmall!.copyWith(
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  // ---------------- DESCRIPTION BOX ----------------

  Widget _descriptionBox(String text, TextTheme textTheme) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: .06),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Text(text, style: textTheme.titleSmall!.copyWith(fontSize: 13.sp,fontWeight: FontWeight.w500)),
    );
  }

  // ---------------- BULLET BOX ----------------

  Widget _bulletBox(List<String> list, TextTheme textTheme) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: .06),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: list.map((e) => _bulletItem(e, textTheme)).toList(),
      ),
    );
  }

  Widget _bulletItem(String text, TextTheme textTheme) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(top: 3),
          child: Icon(
            Icons.check_circle_rounded,
            size: 16,
            color: AppColors.primary,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            text,
            style: textTheme.titleSmall!.copyWith(fontSize: 13.sp,fontWeight: FontWeight.normal, height: 1.35),
          ),
        ),
      ],
    );
  }

  // ---------------- ACTION BUTTONS ----------------

  Widget _actionButtons(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              elevation: 0,
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: BorderSide.none,
              ),
            ),
            onPressed: () => Get.toNamed(
              Routes.CreateTrainingProgram,
              arguments: {'isEdit': true, 'program': program},
            ),
            child: const Text(
              "Edit Program",
              style: TextStyle(color: Colors.white, fontSize: 14),
            ),
          ),
        ),

        SizedBox(height: 12.h),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.white,
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onPressed: () => controller.deleteTrainingProgram(program.id!),
            child: const Text(
              "Delete Program",
              style: TextStyle(color: AppColors.primary, fontSize: 14),
            ),
          ),
        ),
      ],
    );
  }
}
