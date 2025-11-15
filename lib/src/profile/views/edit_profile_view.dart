// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hicoach_coach/common/containers/rounded_container.dart';
import 'package:hicoach_coach/common/image/network_image.dart';
import 'package:hicoach_coach/common/indicators/progress_indicators.dart';
import 'package:hicoach_coach/core/constants/colors.dart';
import 'package:hicoach_coach/src/profile/controller/edit_profile_controller.dart';
import 'package:hicoach_coach/src/profile/widgets/add_package_dialog.dart';
import 'package:hicoach_coach/src/profile/widgets/add_price_dialog.dart';
import 'package:hicoach_coach/src/profile/widgets/coach_info_tab.dart';
import 'package:hicoach_coach/src/profile/widgets/key_value.dart';
import 'package:hicoach_coach/src/profile/widgets/location_search_field.dart';
import 'package:hicoach_coach/src/profile/widgets/packages.dart';
import 'package:hicoach_coach/src/profile/widgets/pricings.dart';

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
          ).textTheme.titleMedium!.copyWith(fontSize: 18.sp),
        ),
        actions: [
          TextButton(
            onPressed: () {
              controller.updateCoachProfileInfo();
            },
            child: Text(
              'Done',
              style: Theme.of(
                context,
              ).textTheme.titleLarge!.copyWith(color: AppColors.primary),
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
                              controller.profiles.value.length,
                              (index) => Padding(
                                padding: EdgeInsets.only(right: 10.w),
                                child: TCachedNetworkImage(
                                  radius: 0,
                                  profileURL: controller.profiles.value[index],
                                  height: 130.h,
                                  width: 110.w,
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
                  ),
                  SizedBox(height: 20.h),

                  // COACHING AREAS
                  ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: 500.0.w),
                    child: Wrap(
                      spacing: 10.0,
                      runSpacing: 10.0,
                      alignment: WrapAlignment.start,
                      children: List.generate(
                        controller.coachingAreas.value.length,
                        (index) {
                          return TRoundedContainer(
                            height: 35.h,
                            width: 150.w,
                            padding: EdgeInsets.symmetric(horizontal: 16.w),
                            backgroundColor: AppColors.primary,
                            alignment: Alignment.centerLeft,
                            child: Text(
                              controller.coachingAreas.value[index].label,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context).textTheme.titleLarge!,
                            ),
                          );
                        },
                      ),
                    ),
                  ),

                  SizedBox(
                    height: controller.coachingAreas.value.isNotEmpty
                        ? 20.h
                        : 0,
                  ),

                  // ----------- LOCATION SEARCH FIELD --------------
                  SearchAreasField(controller: controller),

                  // SUGGESTIONS
                  if (controller.suggestions.value.isNotEmpty)
                    ...List.generate(controller.suggestions.value.length, (
                      index,
                    ) {
                      return GestureDetector(
                        onTap: () {
                          controller.addAreas(
                            controller.suggestions.value[index],
                          );
                        },
                        child: TRoundedContainer(
                          height: 30.h,
                          // backgroundColor: AppColors.filled,
                          padding: EdgeInsets.symmetric(horizontal: 12.w),
                          margin: EdgeInsets.only(top: 10.h),
                          radius: 0,
                          child: Text(
                            controller.suggestions.value[index],
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ),
                      );
                    }),
                  SizedBox(height: 40.h),
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
                              controller.certifications.value.length,
                              (index) => Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: TCachedNetworkImage(
                                  profileURL:
                                      controller.certifications.value[index],
                                  radius: 0,
                                  height: 150.h,
                                  width: 120.w,
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

                  // --------------- PRICING ------------------
                  SizedBox(height: 20.h),
                  Text(
                    'Pricing',
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      fontWeight: FontWeight.w500,
                      fontSize: 16.sp,
                    ),
                  ),
                  SizedBox(height: 10.h),

                  // SHOW ALL PRICINGS
                  Pricings(controller: controller),
                  SizedBox(height: 10.h),

                  // BUTTON TO ADD PRICING
                  ElevatedButton(
                    onPressed: () {
                      Get.dialog(AddPricingDialog(controller: controller));
                    },
                    child: Text(
                      'Add Pricing',
                      style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        fontWeight: FontWeight.w400,
                        color: AppColors.white,
                      ),
                    ),
                  ),

                  // ---------------- PACKAGES --------------------
                  SizedBox(height: 20.h),
                  if (controller.prices.value.isNotEmpty) ...[
                    Text(
                      'Packages',
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        fontWeight: FontWeight.w500,
                        fontSize: 16.sp,
                      ),
                    ),
                    SizedBox(height: 10.h),

                    // SHOW ALL PACKAGES
                    Packages(controller: controller),
                    SizedBox(height: 10.h),

                    ElevatedButton(
                      onPressed: () {
                        Get.dialog(AddPackageDialog(controller: controller));
                      },
                      child: Text(
                        'Add Package',
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(
                          fontWeight: FontWeight.w400,
                          color: AppColors.white,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
