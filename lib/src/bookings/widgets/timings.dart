// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hicoach_coach/common/containers/rounded_container.dart';
import 'package:hicoach_coach/core/constants/colors.dart';
import 'package:hicoach_coach/core/utils/helpers/functions.dart';
import 'package:hicoach_coach/src/bookings/controller/timings_controller.dart';
import 'package:hicoach_coach/src/bookings/views/training_timings.dart';
import 'package:intl/intl.dart';

class Timing extends GetView<TimingsController> {
  const Timing({
    super.key,
    required this.isExpanded,
    required this.time,
    required this.index,
  });
  final bool isExpanded;
  final DateTime time;
  final int index;

  @override
  Widget build(BuildContext context) {
    String formattedTime = DateFormat('EEEE').format(time);
    var timings = controller.timings.value[index].timings;

    String allTimings = timings
        .map((timing) {
          String start = formatTimeOfDay(
            controller.convertDateTimeToTimeOfDay(timing['start']!),
          );
          String end = formatTimeOfDay(
            controller.convertDateTimeToTimeOfDay(timing['end']!),
          );
          return '$start - $end';
        })
        .join(', ');

    return TRoundedContainer(
      margin:  EdgeInsets.only(bottom: 10.h),
      radius: 12.r,
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      borderColor: isExpanded ? AppColors.primary : AppColors.border,
      showBorder: true,
      child: Column(
        children: [
          Row(
            children: [
              ScheduleSwitch(
                value: !controller.timings.value[index].isHoliday,
                onChanged: (value) {
                  controller.updateActiveValue(index, value);
                },
              ),
              SizedBox(width: 10.w),
              Text(
                formattedTime,
                style: Theme.of(
                  context,
                ).textTheme.titleLarge!.copyWith(),
              ),
              SizedBox(width: 10.w),
              if (!isExpanded)
                Expanded(
                  child: Text(
                    allTimings,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(
                      fontSize: 14.sp,
                      color: AppColors.textLighter,
                    ),
                  ),
                ),
            ],
          ),
          if (isExpanded)
            ...List.generate(timings.length, (i) {
              String startingtime = formatTimeOfDay(
                controller.convertDateTimeToTimeOfDay(timings[i]['start']!),
              );
              String endigtime = formatTimeOfDay(
                controller.convertDateTimeToTimeOfDay(timings[i]['end']!),
              );

              return Padding(
                padding:  EdgeInsets.only(bottom: 8.0.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ScheduleTimings(
                      startingtime: startingtime,
                      endingtime: endigtime,
                      onSelectStartingtime: () async {
                        TimeOfDay? selectedTime = await showTimePicker(
                          context: context,
                          initialEntryMode: TimePickerEntryMode.input,
                          initialTime: TimeOfDay.now(),
                        );
                        if (selectedTime != null) {
                          controller.updateTiming(
                            controller.currentIndex.value,
                            i,
                            'start',
                            selectedTime,
                          );
                        }
                      },
                      onSelectEndingtime: () async {
                        TimeOfDay? selectedTime = await showTimePicker(
                          context: context,
                          initialEntryMode: TimePickerEntryMode.input,
                          initialTime: TimeOfDay.now(),
                        );
                        if (selectedTime != null) {
                          controller.updateTiming(
                            controller.currentIndex.value,
                            i,
                            'end',
                            selectedTime,
                          );
                        }
                      },
                    ),
                    Row(
                      children: [
                        i != 0
                            ? InkWell(
                                onTap: () => controller.removeTiming(
                                  controller.currentIndex.value,
                                  i,
                                ),
                                child: Icon(
                                  Icons.delete_outline_rounded,
                                  color: Colors.red,
                                  size: 25.sp,
                                ),
                              )
                            : const SizedBox(),
                        InkWell(
                          onTap: () => controller.addNewTiming(index),
                          child:  Icon(Icons.add_circle_outline,size: 25.sp),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }),
        ],
      ),
    );
  }
}
