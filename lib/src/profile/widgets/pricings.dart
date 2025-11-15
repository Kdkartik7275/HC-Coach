// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hicoach_coach/common/containers/rounded_container.dart';
import 'package:hicoach_coach/core/constants/colors.dart';
import 'package:hicoach_coach/src/profile/controller/edit_profile_controller.dart';

class Pricings extends StatelessWidget {
  const Pricings({super.key, required this.controller});
  final EditProfileController controller;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ListView.separated(
        itemCount: controller.prices.value.length,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          final price = controller.prices.value[index];
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                Text(
                  '${index + 1}. ',
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    fontWeight: FontWeight.w500,
                    fontSize: 16.sp,
                  ),
                ),
                Text(
                  'Title',
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    fontWeight: FontWeight.w500,
                    fontSize: 16.sp,
                  ),
                ),
                SizedBox(width: 6.w),
                TRoundedContainer(
                  padding: EdgeInsets.symmetric(horizontal: 12.w),
                  height: 35.h,
                  width: 120.w,
                  alignment: Alignment.centerLeft,
                  backgroundColor: AppColors.filled,
                  child: Text(
                    price.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w300,
                      color: AppColors.textLighter,
                    ),
                  ),
                ),
                SizedBox(width: 6.w),
                Text(
                  'Pax',
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    fontWeight: FontWeight.w500,
                    fontSize: 16.sp,
                  ),
                ),
                SizedBox(width: 6.w),
                TRoundedContainer(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  height: 35.h,
                  alignment: Alignment.center,
                  backgroundColor: AppColors.filled,
                  child: Text(
                    price.pax.toString(),
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w300,
                      color: AppColors.textLighter,
                    ),
                  ),
                ),
                SizedBox(width: 6.w),
                Text(
                  'Price',
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    fontWeight: FontWeight.w500,
                    fontSize: 16.sp,
                  ),
                ),
                SizedBox(width: 6.w),
                TRoundedContainer(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  height: 35.h,
                  // width: 50,
                  radius: 20.r,
                  alignment: Alignment.centerLeft,
                  backgroundColor: AppColors.filled,
                  child: Text(
                    '\$ ${price.price.toString()}',
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w300,
                      color: AppColors.textLighter,
                    ),
                  ),
                ),

                InkWell(
                 onTap:  ()=> controller.removePrice(price),
                  child: Padding(
                    padding:  EdgeInsets.symmetric(horizontal: 8.0.w),
                    child: Icon(Icons.close, size: 20.sp,color: Colors.red),
                  ),
                ),
              ],
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return SizedBox(height: 15.h);
        },
      ),
    );
  }
}
