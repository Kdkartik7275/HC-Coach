import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hicoach_coach/core/constants/colors.dart';

class NumberSelector extends StatelessWidget {
  final String label;
  final RxInt value;

  const NumberSelector({
    super.key,
    required this.label,
    required this.value,
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

        Obx(() => Container(
              padding:
                  EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(color: AppColors.border, width: 1.5),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _btn(CupertinoIcons.minus, () {
                    if (value.value > 1) value.value--;
                  }),
                  Text("${value.value}",
                      style: theme.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w700,
                        fontSize: 16.sp,
                      )),
                  _btn(CupertinoIcons.add, () => value.value++),
                ],
              ),
            )),
      ],
    );
  }

  Widget _btn(IconData icon, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(4.w),
        decoration: BoxDecoration(
          color: AppColors.filled,
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Icon(icon, size: 14.sp, color: AppColors.text),
      ),
    );
  }
}
