import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hicoach_coach/common/containers/rounded_container.dart';
import 'package:hicoach_coach/core/constants/colors.dart';

class CoachPriceContainer extends StatelessWidget {
  const CoachPriceContainer({
    super.key,
    required this.label,
    required this.ratePerHr,
  });

  final String label;
  final int ratePerHr;

  @override
  Widget build(BuildContext context) {
    return TRoundedContainer(
      width: 100.w,
      margin: EdgeInsets.only(right: 7.w),
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 14.h),
      backgroundColor: AppColors.filled,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            label,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleSmall!.copyWith(
              fontWeight: FontWeight.w400,
              fontSize: 16.sp,
            ),
          ),
          SizedBox(height: 5.h),
          Text(
            '\$ $ratePerHr/hr',
            style: Theme.of(context).textTheme.titleSmall!.copyWith(
              fontWeight: FontWeight.w400,
              color: AppColors.textLighter,
            ),
          ),
        ],
      ),
    );
  }
}
