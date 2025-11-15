// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hicoach_coach/common/dialogs/error_dialog.dart';
import 'package:hicoach_coach/common/indicators/progress_indicators.dart';
import 'package:hicoach_coach/core/constants/colors.dart';
import 'package:hicoach_coach/core/constants/sports.dart';
import 'package:hicoach_coach/core/constants/strings.dart';
import 'package:hicoach_coach/src/authentication/controllers/signup_controller.dart';
import 'package:hicoach_coach/src/authentication/views/signup/coaching_profile_setup.dart';
import 'package:hicoach_coach/src/authentication/widget/auth_button.dart';
import 'package:hicoach_coach/src/authentication/widget/pick_image.dart';

import 'package:loading_overlay/loading_overlay.dart';

class ProfileSetup extends StatefulWidget {
  const ProfileSetup({super.key});

  @override
  State<ProfileSetup> createState() => _ProfileSetupState();
}

class _ProfileSetupState extends State<ProfileSetup> {
  final controller = Get.find<SignUpController>();

  selectSports(String sport) {
    controller.selectedSport.value = sport;
    controller.selectedSport.refresh();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(AppStrings.appName)),
      body: Obx(
        () => LoadingOverlay(
          isLoading: controller.updatingInfo.value,
          progressIndicator: circularProgress(context),
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 30.h),
              child: Center(
                child: Column(
                  children: [
                    const PickImage(),
                    SizedBox(height: 10.h),
                    Text(
                      controller.userData.value!['fullname'],
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    SizedBox(height: 40.h),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Sport',
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.w600,fontSize: 18.sp),
                      ),
                    ),
                    SizedBox(height: 15.h),
                    GridView(
                      shrinkWrap: true,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            mainAxisExtent: 30,
                            crossAxisCount: 3,
                            crossAxisSpacing: 15,
                            mainAxisSpacing: 15,
                          ),
                      children: List.generate(
                        sportsName.length,
                        (index) => GestureDetector(
                          onTap: () {
                            selectSports(sportsName[index]);
                          },
                          child: Obx(() {
                            return Container(
                              width: 110.w,
                              height: 30.h,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.r),
                                color:
                                    controller.selectedSport.value ==
                                        sportsName[index]
                                    ? AppColors.primary
                                    : AppColors.filled,
                              ),
                              child: Center(
                                child: Text(
                                  sportsName[index],
                                  style: Theme.of(context).textTheme.titleSmall!
                                      .copyWith(
                                        fontWeight:controller.selectedSport.value ==
                                        sportsName[index] ? FontWeight.w400 : FontWeight.w300,
                                        fontSize: 14.sp,
                                        color: controller.selectedSport.value ==
                                        sportsName[index]
                                    ? AppColors.white
                                    : AppColors.black,
                                    
                                      ),
                                ),
                              ),
                            );
                          }),
                        ),
                      ),
                    ),
                    SizedBox(height: 50.h),
                    AuthButton(
                      label: 'Done',
                      onPressed: () {
                        if (controller.profilePic.value == null) {
                          showErrorDialog("Please select profile picture");
                        } else if (controller.selectedSport.value.isEmpty) {
                          showErrorDialog("Please select any sport");
                        } else {
                          Get.to(() => const CoachingProfileSetup());
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
