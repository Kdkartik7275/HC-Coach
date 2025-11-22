import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hicoach_coach/core/constants/colors.dart';

class TagInput extends StatelessWidget {
  final TextEditingController controller;
  final RxList list;
  final String hint;

  const TagInput({
    super.key,
    required this.controller,
    required this.list,
    required this.hint,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: controller,
            style: theme.textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.w500,
              fontSize: 14.sp,
            ),
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: theme.textTheme.titleSmall?.copyWith(
                color: AppColors.hintText,
                fontSize: 13.sp,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide: BorderSide(color: AppColors.border, width: 1.5),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide: BorderSide(color: AppColors.primary, width: 2),
              ),
              contentPadding: EdgeInsets.symmetric(
                horizontal: 16.w,
                vertical: 14.h,
              ),
            ),
          ),
        ),
        SizedBox(width: 10.w),

        InkWell(
          onTap: () {
            if (controller.text.trim().isNotEmpty) {
              list.add(controller.text.trim());
              controller.clear();
            }
          },
          child: Container(
            height: 35.h,
            width: 35.h,
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(12.r),
            ),
            alignment: Alignment.center,
            child: Center(child: Icon(Icons.add, color: Colors.white)),
          ),
        ),
      ],
    );
  }
}
