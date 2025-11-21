import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hicoach_coach/core/constants/colors.dart';
import 'package:hicoach_coach/core/utils/helpers/functions.dart';
import 'package:hicoach_coach/src/training_programs/controller/create_training_program_controller.dart';

class UploadThumbnail extends GetView<CreateTrainingProgramController> {

  const UploadThumbnail({super.key});

  Future<void> pick() async {
    final picked = await pickImage();

    if (picked != null) {
      controller.thumbnail.value = picked;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final path =  controller.thumbnail.value;

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
      

          GestureDetector(
            onTap: pick,
            child: Container(
              height: 140.h,
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(color: AppColors.border, width: 1),
              ),
              child: path == null
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.upload_file,
                              size: 30.sp, color: AppColors.primary),
                          SizedBox(height: 6.h),
                          Text("Tap to upload thumbnail",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(color: AppColors.textLighter)),
                        ],
                      ),
                    )
                  : ClipRRect(
                      borderRadius: BorderRadius.circular(12.r),
                      child: Image.file(
                        File(path.path),
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                    ),
            ),
          ),
        ],
      );
    });
  }
}
