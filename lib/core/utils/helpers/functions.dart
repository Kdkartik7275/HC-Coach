import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

void httpErrorHandling({
  required VoidCallback onSuccess,
  required http.Response res,
}) {
  switch (res.statusCode) {
    case 200:
      onSuccess();
      break;
    case 400:
      Get.snackbar('Error', jsonDecode(res.body)['message']);

      break;
    case 500:
      Get.snackbar('Error', jsonDecode(res.body)['error']);
      break;
    default:
      Get.snackbar('Error', res.body);
  }
}

Future<File?> pickImage({bool camera = false}) async {
  try {
    ImagePicker picker = ImagePicker();
    XFile? pickedFile = await picker.pickImage(
      source: camera ? ImageSource.camera : ImageSource.gallery,
    );

    return File(pickedFile!.path);
  } catch (e) {
  return null;
  }
}

double _degreesToRadians(double degrees) {
  return degrees * (pi / 180);
}

double calculateDistance(double lat1, double lon1, double lat2, double lon2) {
  const double earthRadius = 6371; // Earth radius in kilometers
  final double dLat = _degreesToRadians(lat2 - lat1);
  final double dLon = _degreesToRadians(lon2 - lon1);

  final double a =
      sin(dLat / 2) * sin(dLat / 2) +
      cos(_degreesToRadians(lat1)) *
          cos(_degreesToRadians(lat2)) *
          sin(dLon / 2) *
          sin(dLon / 2);
  final double c = 2 * atan2(sqrt(a), sqrt(1 - a));

  return earthRadius * c;
}

class FileUtils {
  static String getFileExtension(File file) {
    List fileNameSplit = file.path.split(".");
    String extension = fileNameSplit.last;
    return extension;
  }

  static String getFileSize(File file) {
    return (file.lengthSync() / (1024 * 1024)).toStringAsFixed(1);
  }
}

String formatTimeOfDay(TimeOfDay time) {
  final now = DateTime.now();
  final dt = DateTime(now.year, now.month, now.day, time.hour, time.minute);
  final format = DateFormat.jm();
  return format.format(dt);
}

String getHourMinutes(DateTime dateTime) {
  int hour = dateTime.hour;
  String period = hour >= 12 ? 'PM' : 'AM';
  hour = hour % 12 == 0 ? 12 : hour % 12;
  return "${hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')} $period";
}

String getFormattedDuration(DateTime startTime, DateTime endTime) {
  Duration duration = endTime.difference(startTime);

  return _formatDuration(duration);
}

String _formatDuration(Duration duration) {
  int hours = duration.inHours;
  int minutes = duration.inMinutes % 60;
  return '${hours}h ${minutes}m';
}

String timeDuration(DateTime starting, DateTime ending) {
  return '${DateFormat('h:mm a').format(starting)} - ${DateFormat('h:mm a').format(ending)}';
}

int calculateAge(String dob) {
  DateFormat dateFormat = DateFormat('dd-MMMM-yyyy');

  DateTime dateOfBirth = dateFormat.parse(dob);
  DateTime currentDate = DateTime.now();

  int age = currentDate.year - dateOfBirth.year;

  if (currentDate.month < dateOfBirth.month ||
      (currentDate.month == dateOfBirth.month &&
          currentDate.day < dateOfBirth.day)) {
    age--;
  }

  return age;
}


 String generateOtp() {
    final random = Random();
    return (random.nextInt(900000) + 100000).toString();
  }
