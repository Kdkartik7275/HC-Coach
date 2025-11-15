// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hicoach_coach/common/containers/rounded_container.dart';
import 'package:hicoach_coach/core/constants/colors.dart';
import 'package:hicoach_coach/core/utils/validators/vallidators.dart';
import 'package:hicoach_coach/src/profile/controller/edit_profile_controller.dart';

class AddPricingDialog extends StatelessWidget {
  const AddPricingDialog({super.key, required this.controller});

  final EditProfileController controller;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Container(
        height: 400.h,
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 20.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
          color: AppColors.white,
        ),
        child: Obx(
          () => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  padding: EdgeInsets.zero,
                  onPressed: () => Get.back(),
                  icon: const Icon(Icons.close),
                ),
              ),
              Form(
                key: controller.pricingFormKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Title',
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        fontWeight: FontWeight.w500,
                        fontSize: 16.sp,
                      ),
                    ),
                    TextFormField(
                      controller: controller.title,

                      validator: (value) =>
                          TValidator.validateEmptyText('Title', value),

                      style: Theme.of(context).textTheme.titleSmall!.copyWith(fontWeight: FontWeight.w400),
                      decoration: const InputDecoration(
                        hintText: 'Enter Title',
                        filled: true,
                        fillColor: AppColors.filled,
                        border: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                      ),
                    ),
                    SizedBox(height: 20.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Pax (No. of Students)',
                          style: Theme.of(context).textTheme.titleMedium!
                              .copyWith(
                                fontWeight: FontWeight.w500,
                                fontSize: 16.sp,
                              ),
                        ),
                        PopupMenuButton(
                          color: AppColors.white,
                          child: TRoundedContainer(
                            height: 40.h,
                            width: 70.w,
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            backgroundColor: AppColors.filled,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(controller.pax.value.toString()),
                                const Icon(Icons.arrow_drop_down, size: 30),
                              ],
                            ),
                          ),
                          itemBuilder: (context) {
                            return List.generate(
                              100,
                              (index) => PopupMenuItem(
                                value: index + 1,
                                onTap: () => controller.pax.value = index + 1,
                                child: Text('${index + 1}',  style: Theme.of(context).textTheme.titleSmall!.copyWith(fontWeight: FontWeight.w400)),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: 20.h),
                    Row(
                      children: [
                        Text(
                          'Price',
                          style: Theme.of(context).textTheme.titleMedium!
                              .copyWith(
                                fontWeight: FontWeight.w500,
                                fontSize: 16.sp,
                              ),
                        ),
                        SizedBox(width: 30.w),
                        Expanded(
                          child: TextFormField(
                            controller: controller.price,
                            validator: (value) =>
                                TValidator.validateEmptyText('Price', value),
                            keyboardType: TextInputType.number,
                              style: Theme.of(context).textTheme.titleSmall!.copyWith(fontWeight: FontWeight.w400),
                            decoration: const InputDecoration(
                              hintText: 'Enter Price in Rs.',
                              filled: true,
                              fillColor: AppColors.filled,
                              border: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20.h),
              GestureDetector(
                onTap: () => controller.addPricing(),
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: TRoundedContainer(
                    width: 80.w,
                    height: 40.h,
                    backgroundColor: AppColors.primary,
                    alignment: Alignment.center,
                    child: Text(
                      'Add',
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(fontWeight: FontWeight.w400,color: AppColors.white)
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
