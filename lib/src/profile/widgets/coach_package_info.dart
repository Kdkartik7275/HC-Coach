// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hicoach_coach/common/containers/rounded_container.dart';
import 'package:hicoach_coach/core/constants/colors.dart';

// ignore: must_be_immutable
class CoachPackageInfo extends StatelessWidget {
  CoachPackageInfo({
    super.key,
    required this.label,
    required this.discountedPrice,
    required this.actualPrice,
    required this.hours,
  });

  final String label;
  final int discountedPrice;
  final int actualPrice;
  final int hours;
  Function()? onpressed;

  @override
  Widget build(BuildContext context) {
    return TRoundedContainer(
      width: double.infinity,
      //  height: 80.h,
      margin: EdgeInsets.only(bottom: 15.h),
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
      backgroundColor: AppColors.filled,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '$hours ${hours > 1 ? 'Hours' : 'Hour'} $label',
                style: Theme.of(context).textTheme.titleSmall!.copyWith(
                  fontWeight: FontWeight.w400,
                  fontSize: 16.sp,
                ),
              ),
              Row(
                children: [
                  Text(
                    '\$$actualPrice',
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(
                      decoration: TextDecoration.lineThrough,
                      color: AppColors.textLighter,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Text(
                    '\$$discountedPrice',
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(),
                  ),
                ],
              ),
            ],
          ),
          GestureDetector(
            onTap: onpressed,
            child: TRoundedContainer(
              height: 70.h,
              width: 70.w,
              backgroundColor: AppColors.primary,
              radius: 10.r,
              child: Center(
                child: Text(
                  'Book Now',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    fontSize: 16.sp,
                    color: AppColors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
