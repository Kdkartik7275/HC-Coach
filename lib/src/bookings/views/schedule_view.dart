// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hicoach_coach/common/containers/rounded_container.dart';
import 'package:hicoach_coach/common/indicators/progress_indicators.dart';
import 'package:hicoach_coach/core/constants/app_pages.dart';
import 'package:hicoach_coach/core/constants/colors.dart';

import 'package:loading_overlay/loading_overlay.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class ScheduleView extends StatefulWidget {
  const ScheduleView({super.key});

  @override
  State<ScheduleView> createState() => _ScheduleViewState();
}

class _ScheduleViewState extends State<ScheduleView> {
  // late ScheduleController controller;

  // final bookingController = Get.find<BookingController>();

  // @override
  // void initState() {
  //   controller = Get.put(ScheduleController());
  //   // Get.put(TimingsController());
  //   final user = Get.find<ProfileController>().user!;
  //   controller.fetchSchedules(user.userId);
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: AppColors.primary),
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: () => Get.toNamed(Routes.TrainingTimings),
              child: Text(
                'Add Training Timings',
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
      body: LoadingOverlay(
        isLoading: false,
        progressIndicator: circularProgress(context),
        color: Colors.black12,
        child: SfCalendar(
          timeZone: 'Asia/Kolkata',
          view: CalendarView.week,
          headerStyle: const CalendarHeaderStyle(
            backgroundColor: AppColors.white,
          ),
          showDatePickerButton: true,
          todayHighlightColor: AppColors.primary,
          timeSlotViewSettings: TimeSlotViewSettings(
            startHour: 6,
            endHour: 24,
            timeIntervalHeight: 40.h,
            timeTextStyle: Theme.of(context).textTheme.titleSmall!.copyWith(fontSize: 14.sp),
          ),
          onTap: (details) {
            // if (details.appointments?.first.sessionId != null) {
            //   final session = controller.classes.value.firstWhere(
            //     (ses) =>
            //         DateFormat('yyyy MM dd').format(ses.startTime) ==
            //         DateFormat('yyyy MM dd').format(details.date!),
            //   );

            //   final requests = session.students.any(
            //     (student) => student['isConfirmed'] == false,
            //   );
            // if (requests) {
            //   showDialog(
            //       context: context,
            //       builder: (_) {
            //         return Dialog(
            //           insetPadding:
            //               const EdgeInsets.symmetric(horizontal: 20),
            //           child: Container(
            //             width: double.infinity,
            //             padding: EdgeInsets.symmetric(
            //                 horizontal: 12.w, vertical: 10.h),
            //             decoration: BoxDecoration(
            //                 color: AppColors.filled,
            //                 borderRadius: BorderRadius.circular(12.r)),
            //             child: Column(
            //               mainAxisSize: MainAxisSize.min,
            //               crossAxisAlignment: CrossAxisAlignment.start,
            //               children: [
            //                 Row(
            //                   mainAxisAlignment:
            //                       MainAxisAlignment.spaceBetween,
            //                   children: [
            //                     Text('Request',
            //                         style: Theme.of(context)
            //                             .textTheme
            //                             .titleMedium),
            //                     IconButton(
            //                         onPressed: () => Get.back(),
            //                         icon: const Icon(Icons.close))
            //                   ],
            //                 ),
            //                 RequestTile(
            //                   session: session,
            //                 )
            //               ],
            //             ),
            //           ),
            //         );
            //       });
            // } else {
            //   Get.to(() => ClassDetails(session: session));
            // }
            //  }

            //  print(details.appointments?.first.sessionId);
          },
          //   dataSource: MeetingDataSource(controller.meetings.value),
          cellEndPadding: 0,
          appointmentBuilder: (context, details) {
            return TRoundedContainer(
              backgroundColor: details.appointments.first.color,
              radius: 5.r,
              child: Center(
                child: Text(
                  details.appointments.first.eventName,
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class Meeting {
  Meeting(this.eventName, this.from, this.to, this.color, this.sessionId);

  final String eventName;
  final DateTime from;
  final DateTime to;
  final Color color;
  final String sessionId;
}

class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<Meeting> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return appointments![index].from;
  }

  @override
  DateTime getEndTime(int index) {
    return appointments![index].to;
  }

  @override
  String getSubject(int index) {
    return appointments![index].eventName;
  }

  @override
  Color getColor(int index) {
    return appointments![index].color;
  }
}
