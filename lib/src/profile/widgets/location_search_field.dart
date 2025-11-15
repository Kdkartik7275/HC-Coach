// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hicoach_coach/common/containers/rounded_container.dart';
import 'package:hicoach_coach/core/constants/colors.dart';
import 'package:hicoach_coach/src/profile/controller/edit_profile_controller.dart';
class SearchAreasField extends StatelessWidget {
  const SearchAreasField({
    super.key,
    required this.controller,
  });

  final EditProfileController controller;

  @override
  Widget build(BuildContext context) {
    return TRoundedContainer(
      height: 40.h,
      width: 250.w,
      backgroundColor: AppColors.filled,
      borderColor: AppColors.border,
      showBorder: true,
      radius: 12.r,
      padding: EdgeInsets.symmetric(horizontal: 8.w),
      child: Center(
        child: TextField(
          textAlign: TextAlign.start, 
          onChanged: (value) => controller.searchAreas(value),
          decoration: InputDecoration(
            isCollapsed: true,
            hintText: 'Search your coaching areas',
            hintStyle: Theme.of(context).textTheme.titleSmall!.copyWith(
                  fontSize: 14.sp,
                  color: AppColors.textLighter,
                ),
            border: InputBorder.none,
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
          ),
        ),
      ),
    );
  }
}
