import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hicoach_coach/core/constants/colors.dart';

class InfoTab extends StatelessWidget {
  const InfoTab({
    super.key,
    this.controller,
    required this.title,
    required this.hintText,
  });

  final TextEditingController? controller;
  final String title;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
            fontWeight: FontWeight.w500,
            fontSize: 16.sp,
          ),
        ),
        SizedBox(height: 5.h),
        Container(
          height: 150.h,
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.r),
            color: AppColors.filled,
          ),
          child: TextField(
            maxLines: null,
            maxLength: null,
            controller: controller,
             style: Theme.of(
            context,
          ).textTheme.titleSmall!.copyWith(color: AppColors.text),
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: Theme.of(
                context,
              ).textTheme.titleSmall!.copyWith(color: AppColors.text),
              disabledBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              border: InputBorder.none,
            ),
          ),
        ),
        SizedBox(height: 20.h),
      ],
    );
  }
}
