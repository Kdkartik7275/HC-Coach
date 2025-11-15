import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hicoach_coach/src/bookings/controller/timings_controller.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class Calender extends GetView<TimingsController> {
  const Calender({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {

    return TableCalendar(
        calendarFormat: controller.calendarFormat.value,
        formatAnimationCurve: Curves.linear,
        onFormatChanged: (format) {
          controller.calendarFormat.value = format;
        },
        selectedDayPredicate: (day) =>
            controller.selectedDates.value.contains(day),
        onDaySelected: (day, focusedDay) =>
            controller.onDaySelected(day, focusedDay),
        calendarStyle: CalendarStyle(
          defaultTextStyle: Theme.of(context).textTheme.titleSmall!.copyWith(fontWeight: FontWeight.w400),
          weekendTextStyle: Theme.of(context).textTheme.titleSmall!.copyWith(fontWeight: FontWeight.w400),
          outsideTextStyle: Theme.of(context).textTheme.titleSmall!.copyWith(fontWeight: FontWeight.w400),
        ),
        headerStyle: HeaderStyle(
          formatButtonVisible: false,
          titleCentered: true,
          titleTextStyle: Theme.of(context).textTheme.titleLarge!,
        ),
        firstDay: DateTime.now(),
        lastDay: DateTime.utc(2025, 12, 31),
        focusedDay: DateTime.now(),
        startingDayOfWeek: StartingDayOfWeek.monday,
        daysOfWeekStyle: DaysOfWeekStyle(
          dowTextFormatter: (date, locale) {
            return DateFormat.E(locale).format(date)[0];
          },
          weekdayStyle: Theme.of(context).textTheme.titleSmall!.copyWith(fontWeight: FontWeight.w400),
          weekendStyle: Theme.of(context)
              .textTheme
              .titleSmall!
              .copyWith(color: Colors.red,fontWeight: FontWeight.w400),
        ),
      );
    });
  }
}
