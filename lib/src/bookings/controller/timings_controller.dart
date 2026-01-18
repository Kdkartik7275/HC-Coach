import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:hicoach_coach/common/dialogs/error_dialog.dart';
import 'package:hicoach_coach/common/dialogs/success_dialog.dart';
import 'package:hicoach_coach/core/constants/localstorage_keys.dart';
import 'package:hicoach_coach/models/coach.dart';
import 'package:hicoach_coach/models/timings.dart';
import 'package:hicoach_coach/services/profile/profile_service.dart';
import 'package:hicoach_coach/src/profile/controller/profile_controller.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class TimingsController extends GetxController {
  var loading = false.obs;
  var isHoliday = false.obs;
  var currentIndex = 0.obs;
  var timings = Rx<List<Timings>>([]);
  var selectedDates = Rx<List<DateTime>>([]);

  var calendarFormat = CalendarFormat.month.obs;

  final services = ProfileService();
  final coach = Get.find<ProfileController>().user as Coach;
  final storage = FlutterSecureStorage();

  @override
  void onInit() {
    super.onInit();
    getInitialTimings();
  }

  void getInitialTimings() {
    loading.value = true;
    timings.value = coach.timings ?? [];

    selectedDates.value = timings.value.map((timing) => timing.date).toList();

    loading.value = false;
  }

  void onDaySelected(DateTime day, DateTime focusedDay) {
    loading.value = true;

    var existingTiming = timings.value.firstWhereOrNull(
      (timing) =>
          DateFormat('yyyy-MM-dd').format(timing.date) ==
          DateFormat('yyyy-MM-dd').format(day),
    );

    if (selectedDates.value.contains(day)) {
      selectedDates.value = List.from(selectedDates.value)..remove(day);
      if (existingTiming != null) {
        timings.value = List.from(timings.value)..remove(existingTiming);
      }
    } else {
      selectedDates.value = List.from(selectedDates.value)..add(day);
      timings.value = List.from(timings.value)
        ..add(
          Timings(
            address: "Coaching Area Address",
            date: day,
            isHoliday: false,
            timings: [
              {'start': day, 'end': day},
            ],
          ),
        );
    }

    selectedDates.refresh();
    timings.refresh();

    loading.value = false;
  }

  void addNewTiming(int index) {
    loading.value = true;
    timings.value[index].timings.add({
      'start': DateTime.now(),
      'end': DateTime.now(),
    });
    timings.refresh();
    loading.value = false;
  }

  void removeTiming(int parentIndex, int childIndex) {
    loading.value = true;

    timings.value[parentIndex].timings.removeAt(childIndex);

    timings.refresh();
    loading.value = false;
  }

  void updateTiming(int index, int timingIndex, String key, TimeOfDay time) {
    loading.value = true;
    var selectedDate = timings.value[index].date;
    var updatedDateTime = DateTime(
      selectedDate.year,
      selectedDate.month,
      selectedDate.day,
      time.hour,
      time.minute,
    );

    timings.value[index].timings[timingIndex][key] = updatedDateTime;
    timings.refresh();
    loading.value = false;
  }

  void updateActiveValue(int index, bool value) {
    loading.value = true;
    timings.value[index] = timings.value[index].copyWith(isHoliday: !value);
    timings.refresh();
    loading.value = false;
  }

  void setHoliday(bool value) {
    loading.value = true;
    isHoliday.value = value;

    if (value) {
      for (var entry in timings.value) {
        entry.isHoliday = true;
      }
    } else {
      for (var entry in timings.value) {
        entry.isHoliday = false;
      }
    }
    timings.refresh();

    loading.value = false;
  }

  Future<void> saveTimings(String coachId) async {
    loading.value = true;

    try {
      final token = await storage.read(key: LocalStorageKeys.token) ?? "";
      await services.updateCoach({
        'timings': timings.value.map((timing) => timing.toMap()).toList(),
      }, coachId,token);
      coach.timings = timings.value;

      showSuccessDialog('Schedules updated successfully');
    } catch (e) {
      showErrorDialog("Failed to save timings");
    } finally {
      loading.value = false;
    }
  }

  TimeOfDay convertDateTimeToTimeOfDay(DateTime dateTime) {
    return TimeOfDay(hour: dateTime.hour, minute: dateTime.minute);
  }
}
