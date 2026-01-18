import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hicoach_coach/common/indicators/progress_indicators.dart';
import 'package:hicoach_coach/core/constants/colors.dart';
import 'package:hicoach_coach/models/training_program_model.dart';
import 'package:hicoach_coach/src/profile/controller/profile_controller.dart';
import 'package:hicoach_coach/src/training_programs/controller/create_training_program_controller.dart';
import 'package:hicoach_coach/src/training_programs/widgets/create_program/create_program_button.dart';
import 'package:hicoach_coach/src/training_programs/widgets/create_program/labeled_dropdown.dart';
import 'package:hicoach_coach/src/training_programs/widgets/create_program/labeled_field_text.dart';
import 'package:hicoach_coach/src/training_programs/widgets/create_program/number_selector.dart';
import 'package:hicoach_coach/src/training_programs/widgets/create_program/program_card.dart';
import 'package:hicoach_coach/src/training_programs/widgets/create_program/tag_chip.dart';
import 'package:hicoach_coach/src/training_programs/widgets/create_program/tag_input.dart';
import 'package:hicoach_coach/src/training_programs/widgets/create_program/upload_thumbnail.dart';
import 'package:loading_overlay/loading_overlay.dart';

class CreateProgramScreen extends StatefulWidget {
  const CreateProgramScreen({super.key});

  @override
  State<CreateProgramScreen> createState() => _CreateProgramScreenState();
}

class _CreateProgramScreenState extends State<CreateProgramScreen> {
  final coach = Get.find<ProfileController>().user;

  final controller = Get.find<CreateTrainingProgramController>();

 late bool isEdit;
 late TrainingProgram trainingProgram;

  @override
  void initState() {
    super.initState();

    final args = Get.arguments ?? {};

     isEdit = args['isEdit'] ?? false;

    if (isEdit) {
      trainingProgram = args['program'];
      controller.loadProgram(trainingProgram);
    }
    if(coach != null){
      controller.sportC.text = coach!.sports.first;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: AppColors.filled,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(CupertinoIcons.back, color: AppColors.text),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(isEdit? "Edit Program": "Create Program", style: theme.textTheme.titleLarge),
      ),
      body: Obx(() {
        return LoadingOverlay(
          isLoading: controller.creating.value,
          progressIndicator: circularProgress(context),
          color: Colors.black12,
          child: SingleChildScrollView(
            padding: EdgeInsets.all(16.w),
            child: Column(
              children: [
                ProgramCard(
                  title: "Basic Information",
                  icon: CupertinoIcons.info_circle_fill,
                  children: [
                    LabeledTextField(
                      label: "Program Title",
                      hint: 'Enter Program Title',
                      controller: controller.titleC,
                    ),
                    SizedBox(height: 14.h),
                    Row(
                      children: [
                        Expanded(
                          child: LabeledTextField(
                            label: "Sport",
                            controller: controller.sportC,
                          ),
                        ),
                        SizedBox(width: 12.w),
                        Expanded(
                          child: LabeledDropdown(
                            label: "Level",
                            selected: controller.level,
                            items: ["Beginner", "Intermediate", "Advanced"],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                SizedBox(height: 16.h),

                ProgramCard(
                  title: "Duration & Schedule",
                  icon: CupertinoIcons.calendar,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: NumberSelector(
                            label: "Duration (Days)",
                            value: controller.durationDays,
                          ),
                        ),
                        SizedBox(width: 12.w),
                        Expanded(
                          child: LabeledTextField(
                            label: "Total Sessions",
                            hint: 'Total Sessions',
                            controller: controller.sessionsC,
                            keyboard: TextInputType.number,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 14.h),
                    LabeledTextField(
                      label: "Frequency",
                      controller: controller.frequencyC,
                      hint: "e.g., 4 sessions/week",
                      keyboard: TextInputType.number,
                    ),

                    SizedBox(height: 14.h),

                    Text(
                      "Add available slot ",
                      style: theme.textTheme.titleSmall?.copyWith(
                        color: AppColors.text,
                        fontSize: 13.sp,
                      ),
                    ),

                    SizedBox(height: 8.h),

                    TagInput(
                      controller: controller.slotInput,
                      list: controller.slots,
                      hint: "(e.g. 6 AM - 7 AM)",
                    ),

                    SizedBox(height: 8.h),

                    Wrap(
                      spacing: 8.w,
                      runSpacing: 8.h,
                      children: controller.slots
                          .map(
                            (slot) => TagChip(
                              label: slot,
                              onRemove: () => controller.slots.remove(slot),
                            ),
                          )
                          .toList(),
                    ),
                  ],
                ),

                SizedBox(height: 16.h),

                ProgramCard(
                  title: "Pricing",
                  icon: CupertinoIcons.money_dollar,
                  children: [
                    LabeledTextField(
                      label: "Program Price",
                      hint: 'Enter Program Price',
                      controller: controller.priceC,
                      keyboard: TextInputType.number,
                      prefix: "₹",
                    ),
                  ],
                ),

                SizedBox(height: 16.h),

                ProgramCard(
                  title: "About Program",
                  icon: CupertinoIcons.doc_text_fill,
                  children: [
                    LabeledTextField(
                      label: "Description",
                      controller: controller.descriptionC,
                      maxLines: 4,
                      hint: "Brief overview of your program",
                    ),
                  ],
                ),

                SizedBox(height: 16.h),

                ProgramCard(
                  title: "Upload Thumbnail",
                  icon: CupertinoIcons.photo,
                  children: [UploadThumbnail()],
                ),

                SizedBox(height: 16.h),

                ProgramCard(
                  title: "Learning Outcomes",
                  icon: CupertinoIcons.lightbulb_fill,
                  children: [
                    TagInput(
                      controller: controller.learningInput,
                      list: controller.learningPoints,
                      hint: "What will students learn?",
                    ),
                    SizedBox(height: 8.h),
                    Wrap(
                      spacing: 8.w,
                      runSpacing: 8.h,
                      children: controller.learningPoints
                          .map(
                            (e) => TagChip(
                              label: e,
                              onRemove: () =>
                                  controller.learningPoints.remove(e),
                            ),
                          )
                          .toList(),
                    ),
                  ],
                ),

                SizedBox(height: 16.h),

                ProgramCard(
                  title: "Requirements",
                  icon: CupertinoIcons.checkmark_shield_fill,
                  children: [
                    TagInput(
                      controller: controller.reqInput,
                      list: controller.requirements,
                      hint: "Any prerequisites?",
                    ),
                    SizedBox(height: 8.h),
                    Wrap(
                      spacing: 8.w,
                      runSpacing: 8.h,
                      children: controller.requirements
                          .map(
                            (e) => TagChip(
                              label: e,
                              onRemove: () => controller.requirements.remove(e),
                            ),
                          )
                          .toList(),
                    ),
                  ],
                ),

                SizedBox(height: 24.h),
                CreateProgramButton(
                  onPressed: () =>isEdit ? controller.updateTrainingProgram(trainingProgram.id!): controller.createTrainingProgram(
                    coach!.userId,
                    coach!.fullName,
                  
                  ), isEditing: isEdit,
                ),
                SizedBox(height: 20.h),
              ],
            ),
          ),
        );
      }),
    );
  }
}
