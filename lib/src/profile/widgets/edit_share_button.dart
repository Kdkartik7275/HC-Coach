import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hicoach_coach/common/containers/rounded_container.dart';
import 'package:hicoach_coach/core/constants/app_pages.dart';
import 'package:hicoach_coach/core/constants/colors.dart';

class EditAndShareProfileButton extends StatelessWidget {
  const EditAndShareProfileButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // ---------- EDIT PROFILE BUTTON ----------
        GestureDetector(
          onTap: () => Get.toNamed(Routes.EditProfile),
          child: TRoundedContainer(
            height: 42.h,
            width: 140.w,
            radius: 12.r,
            backgroundColor: AppColors.text,
           
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.edit_outlined,
                  color: AppColors.white,
                  size: 18.sp,
                ),
                SizedBox(width: 6.w),
                Text(
                  "Edit Profile",
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        color: AppColors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 13.sp,
                      ),
                ),
              ],
            ),
          ),
        ),

        SizedBox(width: 14.w),

        // ---------- SHARE PROFILE BUTTON ----------
        GestureDetector(
          child: TRoundedContainer(
            height: 42.h,
            width: 140.w,
            radius: 12.r,
            backgroundColor: AppColors.filled,
           
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.share_outlined,
                  color: AppColors.black,
                  size: 18.sp,
                ),
                SizedBox(width: 6.w),
                Text(
                  "Share Profile",
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        color: AppColors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 13.sp,
                      ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
