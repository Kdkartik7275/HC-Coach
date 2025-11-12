import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:hicoach_coach/core/constants/app_pages.dart';
import 'package:hicoach_coach/core/constants/localstorage_keys.dart';

class OnboardingController extends GetxController {
  final PageController pageController = PageController();
  final FlutterSecureStorage storage = const FlutterSecureStorage();

  var currentPage = 0.obs;

  void onPageChanged(int index) {
    currentPage.value = index;
  }

  void nextPage() async {
    if (currentPage.value < 2) {
      pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      await storage.write(
        key: LocalStorageKeys.onboardingCompleted,
        value: 'true',
      );
      Get.offAllNamed(Routes.Login);
    }
  }

  Future<void> skip() async {
    await storage.write(
      key: LocalStorageKeys.onboardingCompleted,
      value: 'true',
    );
    Get.offAllNamed(Routes.Login);
  }
}
