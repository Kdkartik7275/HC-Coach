import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hicoach_coach/common/image/network_image.dart';
import 'package:hicoach_coach/common/preview/preview_image.dart';
import 'package:hicoach_coach/core/constants/colors.dart';
import 'package:hicoach_coach/models/coach.dart';
import 'package:hicoach_coach/src/profile/controller/profile_controller.dart';


class CoachResumeWidget extends GetView<ProfileController> {
  const CoachResumeWidget({super.key, required this.coach});
  final Coach coach;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _tab('Bio', coach.bio, context),
        _tab('Playing Experience', coach.playingExperience!, context),
        _tab('Coaching Experience', coach.coachingExperience!, context),
         Text(
        'Certifications',
        style: Theme.of(
          context,
        ).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.w500,fontSize: 16.sp),
      ),
      SizedBox(height: 12.h),
        Row(
          children: List.generate(coach.certifications!.length, (index) {
            return GestureDetector(
              onTap: () => showImageOverlay(
                context,
                coach.certifications! as List<String>,
              ),
              child: SizedBox(
                child: TCachedNetworkImage(
                  profileURL: coach.certifications![index],
                  height: 130.h,
                  radius: 0,
                  boxFit: BoxFit.contain,
                  width: 100.w,
                ),
              ),
            );
          }),
        ),
        SizedBox(height: 50.h),
      ],
    );
  }
}

Widget _tab(String title, String subtitle, BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        title,
        style: Theme.of(
          context,
        ).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.w500,fontSize: 16.sp),
      ),
      SizedBox(height: 12.h),
      Container(
        padding:  EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
          color: AppColors.filled,
        ),
        child: Text(
          subtitle,
          style: Theme.of(
            context,
          ).textTheme.titleSmall!.copyWith(color: AppColors.text),
        ),
      ),
      SizedBox(height: 25.h),
    ],
  );
}
