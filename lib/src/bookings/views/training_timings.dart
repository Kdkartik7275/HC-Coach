import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hicoach_coach/common/containers/rounded_container.dart';
import 'package:hicoach_coach/common/indicators/progress_indicators.dart';
import 'package:hicoach_coach/core/constants/colors.dart';
import 'package:hicoach_coach/src/bookings/controller/timings_controller.dart';
import 'package:hicoach_coach/src/bookings/widgets/calendar.dart';
import 'package:hicoach_coach/src/bookings/widgets/timings.dart';
import 'package:loading_overlay/loading_overlay.dart';

class TrainingTimings extends StatefulWidget {
  const TrainingTimings({super.key});

  @override
  State<TrainingTimings> createState() => _TrainingTimingsState();
}

class _TrainingTimingsState extends State<TrainingTimings> {
  late TimingsController controller;
  @override
  void initState() {
    controller = Get.find<TimingsController>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
              onPressed: () {},
              child:  Text('Done',style: Theme.of(context).textTheme.titleLarge!.copyWith(color: AppColors.primary)))
        ],
      ),
      body: Obx(
        () => LoadingOverlay(
          isLoading: controller.loading.value,
          progressIndicator: circularProgress(context),
          color: Colors.transparent,
          child: SingleChildScrollView(
            child: Column(
              children: [
                // Calender
                TRoundedContainer(
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      offset: Offset(0, 4),
                      blurRadius: 10.0,
                    ),
                  ],
                  child: Column(
                    children: [
                      const Calender(),
                      SizedBox(
                          width: 60.w,
                          child: const Divider(
                            thickness: 3,
                            color: AppColors.black,
                          )),
                    ],
                  ),
                ),

                // Timings Setter
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
                  child: Column(
                    children: [
                      // HEAD
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Set Schedule',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!.copyWith(fontWeight: FontWeight.w400,fontSize: 18.sp)
                                  ),
                          Row(
                            children: [
                              ScheduleSwitch(
                                onChanged: (value) =>
                                    controller.setHoliday(value),
                                value: controller.isHoliday.value,
                              
                              ),
                              SizedBox(width: 8.w),
                              Text(
                                'Holiday',
                               style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!.copyWith(fontWeight: FontWeight.w400,fontSize: 18.sp)
                              ),
                            ],
                          )
                        ],
                      ),

                      // TIMINGS

                      ...List.generate(
                          controller.selectedDates.value.length,
                          (index) => GestureDetector(
                              onTap: () {
                                controller.currentIndex.value = index;
                              },
                              child: Timing(
                                isExpanded:
                                    controller.currentIndex.value == index || controller.timings.value.isEmpty,
                                index: index,
                                time: controller.selectedDates.value[index],
                              ))),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ScheduleTimings extends StatelessWidget {
  const ScheduleTimings({
    super.key,
    required this.startingtime,
    required this.endingtime,
    this.onSelectStartingtime,
    this.onSelectEndingtime,
  });

  final String startingtime;
  final String endingtime;
  final Function()? onSelectStartingtime;
  final Function()? onSelectEndingtime;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _SelectTimeWidget(
              onPressed: onSelectStartingtime, time: startingtime),
          Text('to', style: Theme.of(context).textTheme.titleSmall!.copyWith(color: AppColors.textLighter,fontSize: 14.sp)),
          _SelectTimeWidget(onPressed: onSelectEndingtime, time: endingtime),
        ],
      ),
    );
  }
}

class _SelectTimeWidget extends StatelessWidget {
  const _SelectTimeWidget({
    required this.time,
    required this.onPressed,
  });

  final String time;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return TRoundedContainer(
      height: 40.h,
      borderColor: AppColors.border,
      showBorder: true,
      padding: EdgeInsets.only(left: 8.w),
      radius: 10.r,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(time,
              style: Theme.of(context)
                  .textTheme
                  .titleSmall!
                  .copyWith(fontSize: 14.sp,fontWeight: FontWeight.w400)),
          IconButton(
              onPressed: onPressed, icon: const Icon(Icons.arrow_drop_down))
        ],
      ),
    );
  }
}

class ScheduleSwitch extends StatelessWidget {
  const ScheduleSwitch({
    super.key,
    required this.value,
    required this.onChanged,
  });

  final bool value;
  final void Function(bool)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: 0.7,
      child: Switch(
        value: value,
        onChanged: onChanged,
        activeColor: AppColors.white,
        activeTrackColor: AppColors.primary,
        inactiveTrackColor: AppColors.border,
        inactiveThumbColor: AppColors.white,
        trackOutlineColor: const WidgetStatePropertyAll(Colors.transparent),
      ),
    );
  }
}
