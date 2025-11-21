import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hicoach_coach/core/constants/colors.dart';

class LabeledTextField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final int maxLines;
  final TextInputType keyboard;
  final String? hint;
  final String? prefix;

  const LabeledTextField({
    super.key,
    required this.label,
    required this.controller,
    this.maxLines = 1,
    this.keyboard = TextInputType.text,
    this.hint,
    this.prefix,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: theme.textTheme.titleSmall?.copyWith(
              color: AppColors.text,
              fontSize: 13.sp,
            )),

        SizedBox(height: 8.h),

        TextField(
          controller: controller,
          maxLines: maxLines,
          keyboardType: keyboard,
          style: theme.textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.w500,
            fontSize: 14.sp,
          ),
          decoration: InputDecoration(
            hintText: hint,
            prefixText: prefix,
            prefixStyle: theme.textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.w600,
              fontSize: 14.sp,
              color: AppColors.text,
            ),
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
            contentPadding:
                EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
          ),
        ),
      ],
    );
  }
}
