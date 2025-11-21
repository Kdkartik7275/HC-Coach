import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hicoach_coach/core/constants/colors.dart';

class LabeledDropdown extends StatelessWidget {
  final String label;
  final RxString selected;
  final List<String> items;

  const LabeledDropdown({
    super.key,
    required this.label,
    required this.selected,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: theme.textTheme.titleSmall?.copyWith(
            color: AppColors.text,
            fontSize: 13.sp,
          ),
        ),
        SizedBox(height: 8.h),

        Obx(
          () => Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: AppColors.border, width: 1.5),
            ),
            child: DropdownButton<String>(
              dropdownColor: Colors.white,
              value: selected.value,
              style: theme.textTheme.titleSmall?.copyWith(
                color: AppColors.hintText,
                fontSize: 13.sp,
              ),
              underline: SizedBox(),
              isExpanded: true,
              isDense: true,
              icon: Icon(
                CupertinoIcons.chevron_down,
                size: 18.sp,
                color: AppColors.text,
              ),
              items: items
                  .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                  .toList(),
              onChanged: (v) => selected.value = v!,
            ),
          ),
        ),
      ],
    );
  }
}
