import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hicoach_coach/common/indicators/progress_indicators.dart';
import 'package:hicoach_coach/src/training_programs/controller/training_programs_controller.dart';
import 'package:hicoach_coach/src/training_programs/widgets/no_programs_found.dart';
import 'package:hicoach_coach/src/training_programs/widgets/training_program_card.dart';

class CoachPrograms extends GetView<TrainingProgramsController> {
  const CoachPrograms({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return controller.isLoading.value
          ? circularProgress(context)
          : controller.trainingPrograms.isEmpty
          ? NoProgramsFound()
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // -------- PROGRAMS --------
                Text(
                  "Training Programs",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                SizedBox(height: 12.h),

                Column(
                  children: controller.trainingPrograms
                      .map((p) => TrainingProgramCard(program: p))
                      .toList(),
                ),

                SizedBox(height: 24.h),
              ],
            );
    });
  }
}
