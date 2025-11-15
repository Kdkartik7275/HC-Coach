// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hicoach_coach/common/containers/price_container.dart';
import 'package:hicoach_coach/models/coach.dart';
import 'package:hicoach_coach/src/profile/widgets/coach_package_info.dart';
import 'package:lottie/lottie.dart';

class CoachPricingWidget extends StatelessWidget {
  const CoachPricingWidget({super.key, required this.coach});
  final Coach coach;

  @override
  Widget build(BuildContext context) {
    if ((coach.pricings != null && coach.pricings!.isNotEmpty) ||
        coach.packages != null && coach.packages!.isNotEmpty) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ---------- PRICINGS --------------
          if (coach.pricings != null && coach.pricings!.isNotEmpty) ...[
            SizedBox(height: 20.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                coach.pricings!.length,
                (index) => CoachPriceContainer(
                  label: coach.pricings![index].title,
                  ratePerHr: coach.pricings![index].price,
                ),
              ),
            ),
          ],
          // ----------- PACKAGES ----------------
          SizedBox(height: 20.h),
          if (coach.packages != null && coach.packages!.isNotEmpty) ...[
            Text(
              'Packages',
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                fontWeight: FontWeight.w500,
                fontSize: 16.sp,
              ),
            ),
            SizedBox(height: 12.h),
            Column(
              children: List.generate(coach.packages!.length, (index) {
                int discountedPrice =
                    coach.packages![index].actualPrice.toInt() -
                    (coach.packages![index].actualPrice.toInt() *
                            (coach.packages![index].discount / 100))
                        .toInt();

                return CoachPackageInfo(
                  label: coach.packages![index].packageFor,
                  hours: coach.packages![index].hours,
                  actualPrice: coach.packages![index].actualPrice,
                  discountedPrice: discountedPrice,
                );
              }),
            ),
            SizedBox(height: 50.h),
          ],
        ],
      );
    } else {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Lottie.asset(
                'assets/json/no_data.json',
                height: 150.h,
                repeat: true,
                fit: BoxFit.contain,
              ),
              SizedBox(height: 12.h),

              Text(
                "Complete your profile",
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: 16.sp,
                ),
                textAlign: TextAlign.center,
              ),

              SizedBox(height: 6.h),

              Text(
                "Add your pricing and packages to make your profile visible to students.",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: Colors.grey.shade600,
                  fontSize: 13.sp,
                ),
              ),
            ],
          ),
        ),
      );
    }
  }
}
