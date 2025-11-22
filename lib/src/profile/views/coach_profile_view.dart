// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hicoach_coach/common/indicators/progress_indicators.dart';
import 'package:hicoach_coach/src/profile/controller/profile_controller.dart';
import 'package:hicoach_coach/src/profile/widgets/about_tabs.dart';
import 'package:hicoach_coach/src/profile/widgets/coach_profile_header.dart';
import 'package:hicoach_coach/src/profile/widgets/edit_share_button.dart';
import 'package:hicoach_coach/src/profile/widgets/info.dart';
import 'package:hicoach_coach/src/training_programs/controller/training_programs_controller.dart';
import 'package:hicoach_coach/src/training_programs/view/coach_training_programs.dart';

import 'package:loading_overlay/loading_overlay.dart';

class CoachProfileView extends StatefulWidget {
  const CoachProfileView({super.key});

  @override
  State<CoachProfileView> createState() => _CoachProfileViewState();
}

class _CoachProfileViewState extends State<CoachProfileView> {
  late double height, width;

  final controller = Get.find<ProfileController>();
  late TrainingProgramsController trainingProgramsController;

  @override
  void initState() {
    super.initState();
    trainingProgramsController = Get.put(TrainingProgramsController());
    trainingProgramsController.getTrainingPrograms(controller.user!.userId);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    return Scaffold(
      body: Obx(() {
        final coach = controller.user!;

        return LoadingOverlay(
          isLoading: controller.updatingInfo.value,
          progressIndicator: circularProgress(context),
          color: Colors.transparent,
          child: SingleChildScrollView(
            child: Column(
              children: [
                // --------- PROFILE HEADER ---------------
                CoachProfileHeader(coach: coach, controller: controller),
                SizedBox(height: 25.h),

                // ------------ PROFILE BUTTONS
                const EditAndShareProfileButton(),

                // ---------- COACH INFORMATION TABS ---------------
                CoachAboutTabs(controller: controller),

                // TAB BAR BODY
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: controller.coachInfoSelectedIndex.value == 0
                      ? CoachResumeWidget(coach: coach)
                      : controller.coachInfoSelectedIndex.value == 1
                      ? CoachPrograms()
                      : const SizedBox(),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
