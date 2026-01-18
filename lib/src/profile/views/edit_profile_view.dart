// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hicoach_coach/common/containers/rounded_container.dart';
import 'package:hicoach_coach/common/image/network_image.dart';
import 'package:hicoach_coach/common/indicators/progress_indicators.dart';
import 'package:hicoach_coach/core/constants/colors.dart';
import 'package:hicoach_coach/src/profile/controller/edit_profile_controller.dart';
import 'package:hicoach_coach/src/profile/widgets/coach_info_tab.dart';
import 'package:hicoach_coach/src/profile/widgets/key_value.dart';

import 'package:loading_overlay/loading_overlay.dart';

class EditProfileView extends GetView<EditProfileController> {
  const EditProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Edit Profile',
          style: Theme.of(
            context,
          ).textTheme.titleLarge!.copyWith(fontSize: 16.sp),
        ),
        actions: [
          TextButton(
            onPressed: () {
              controller.updateCoachProfileInfo();
            },
            child: Text(
              'Save',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: AppColors.primary,
                fontSize: 16.sp,
              ),
            ),
          ),
        ],
      ),
      body: Obx(
        () => LoadingOverlay(
          isLoading: controller.loading.value,
          progressIndicator: circularProgress(context),
          color: Colors.black12,

          child: Padding(
            padding: const EdgeInsets.all(15),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // -------------- COACH PROFILE IMAGES ------------
                  SizedBox(
                    height: 130.h,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          Row(
                            children: List.generate(
                              controller.profiles.length,
                              (index) => Padding(
                                padding: EdgeInsets.only(right: 10.w),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(12.r),
                                  child: TCachedNetworkImage(
                                    radius: 12.r,
                                    profileURL: controller.profiles[index],
                                    height: 130.h,
                                    width: 110.w,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          TRoundedContainer(
                            height: 50.h,
                            width: 50.w,
                            radius: 100.w,
                            backgroundColor: AppColors.filled,
                            child: Center(
                              child: IconButton(
                                onPressed: () => controller.uploadNewProfile(),
                                icon: Icon(Icons.add, size: 25.sp),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(height: 20.h),

                  // --------- COACH DETAILS --------------
                  KeyValue(
                    hintText: 'Full Name',
                    title: 'Name',
                    controller: controller.name,
                  ),
                  SizedBox(height: 10.h),
                  KeyValue(
                    hintText: 'Phone No.',
                    title: 'Contact',
                    controller: controller.phone,
                  ),
                  SizedBox(height: 10.h),
                  KeyValue(
                    hintText: 'Postal Code (For nearby students)',
                    title: 'Location',
                    controller: controller.location,
                    onChanged: (value) => controller.onLocationChanged(value),
                  ),
                  SizedBox(height: 10.h),
                  Obx(
                    () => controller.locationSuggestions.isEmpty
                        ? const SizedBox.shrink()
                        : ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: controller.locationSuggestions.length,
                            itemBuilder: (context, index) {
                              final suggestion =
                                  controller.locationSuggestions[index];

                              final query = controller.location.text.trim();

                              final title = suggestion.title;
                              final highlightLength =
                                  title.toLowerCase().startsWith(
                                    query.toLowerCase(),
                                  )
                                  ? query.length
                                  : 0;

                              return GestureDetector(
                                onTap: () =>
                                    controller.selectLocation(suggestion),
                                child: ListTile(
                                  leading: const Icon(
                                    Icons.location_on,
                                    color: AppColors.primary,
                                  ),
                                  title: Text.rich(
                                    TextSpan(
                                      children: [
                                        if (highlightLength > 0)
                                          TextSpan(
                                            text: title.substring(
                                              0,
                                              highlightLength,
                                            ),
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleLarge!
                                                .copyWith(
                                                  fontWeight: FontWeight.bold,
                                                  color: AppColors.primary,
                                                ),
                                          ),
                                        TextSpan(
                                          text: title.substring(
                                            highlightLength,
                                          ),
                                          style: Theme.of(
                                            context,
                                          ).textTheme.titleLarge,
                                        ),
                                      ],
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  subtitle: Text(
                                    suggestion.subtitle,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleSmall!
                                        .copyWith(
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.normal,
                                        ),
                                  ),
                                ),
                              );
                            },
                          ),
                  ),

                  GestureDetector(
                    onTap: () => controller.getCurrentLocation(),
                    child: TRoundedContainer(
                      height: 45.h,
                      width: double.infinity,
                      backgroundColor: AppColors.primary.withValues(alpha: .1),
                      radius: 12.r,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(12.r),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.my_location,
                              color: AppColors.primary,
                            ),
                            SizedBox(width: 8.w),
                            Text(
                              'Use Current Location',
                              style: Theme.of(context).textTheme.titleLarge!
                                  .copyWith(
                                    color: AppColors.primary,
                                    fontWeight: FontWeight.w500,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 12.h),
                  InfoTab(
                    hintText:
                        'Tell us about yourself and your teaching style...',
                    title: 'Bio',
                    controller: controller.bio,
                  ),
                  InfoTab(
                    hintText: 'Tell us about the level you were playing at...',
                    title: 'Playing Experience',
                    controller: controller.playExperience,
                  ),
                  InfoTab(
                    hintText: 'Tell us about your coaching experience...',
                    title: 'Coaching Experience',
                    controller: controller.coachingExperience,
                  ),
                  Text(
                    'Certifications',
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      fontWeight: FontWeight.w500,
                      fontSize: 16.sp,
                    ),
                  ),

                  // --------------- ADD CERTIFICATIONS BUTTON -----------------
                  SizedBox(
                    height: 150.h,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          Row(
                            children: List.generate(
                              controller.certifications.length,
                              (index) => Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(12.r),
                                  child: TCachedNetworkImage(
                                    profileURL:
                                        controller.certifications[index],
                                    radius: 0,
                                    height: 150.h,
                                    width: 120.w,
                                  ),
                                ),
                              ),
                            ),
                          ),

                          TRoundedContainer(
                            height: 50.h,
                            width: 50.w,
                            radius: 100.w,
                            backgroundColor: AppColors.filled,
                            child: Center(
                              child: IconButton(
                                onPressed: () =>
                                    controller.uploadNewCertification(),
                                icon: Icon(Icons.add, size: 25.sp),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 30.h),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
