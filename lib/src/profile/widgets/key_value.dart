// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:hicoach_coach/core/constants/colors.dart';

class KeyValue extends StatelessWidget {
  const KeyValue({
    super.key,
    required this.title,
    required this.hintText,
    this.controller,
    this.onChanged,
  });

  final String title;
  final String hintText;
  final TextEditingController? controller;
  final Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
            fontWeight: FontWeight.normal,
            fontSize: 14.sp,
          ),
        ),
        SizedBox(width: 30.w),
        Expanded(
          child: TextField(
            controller: controller,
            onChanged: onChanged,
            style: Theme.of(context).textTheme.titleSmall!.copyWith(
              fontWeight: FontWeight.w400,
              color: AppColors.textLighter,
            ),
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: Theme.of(context).textTheme.titleSmall!.copyWith(
                fontWeight: FontWeight.w400,
                color: AppColors.textLighter,
              ),
              border: const UnderlineInputBorder(
                borderSide: BorderSide(color: AppColors.border),
              ),
              enabledBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: AppColors.border),
              ),
              focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: AppColors.border),
              ),
              disabledBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: AppColors.border),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
