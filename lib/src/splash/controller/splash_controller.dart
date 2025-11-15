import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:hicoach_coach/core/constants/app_pages.dart';
import 'package:hicoach_coach/core/constants/localstorage_keys.dart';
import 'package:hicoach_coach/services/authentication/login_services.dart';
import 'package:hicoach_coach/src/authentication/controllers/signup_controller.dart';
import 'package:hicoach_coach/src/authentication/views/signup/profile_setup.dart';

class SplashController extends GetxController {
  final FlutterSecureStorage storage = const FlutterSecureStorage();
  final LoginServices _services = LoginServices();

  Future<void> setInitialView() async {
    try {
      final bool isAuthenticated = await _services.isAuthenticated();

      if (isAuthenticated) {
        final String? isInRegistrationProcess = await storage.read(
          key: LocalStorageKeys.isInRegistrationProcess,
        );
        if (isInRegistrationProcess == 'true') {
          final String? userDataJson = await storage.read(
            key: LocalStorageKeys.userData,
          );
          final Map<String, dynamic> userData = jsonDecode(userDataJson!);

          Get.offAll(
            () => const ProfileSetup(),
            binding: BindingsBuilder(() {
              final controller = Get.put(SignUpController());
              controller.userData.value = userData;
            }),
          );
          return;
        }

        Get.offAllNamed(Routes.BottomNavBar);
        return;
      }

      final String? hasCompletedOnboarding = await storage.read(
        key: LocalStorageKeys.onboardingCompleted,
      );

      if (hasCompletedOnboarding == null) {
        Get.offAllNamed(Routes.OnBoard);
      } else {
        Get.offAllNamed(Routes.Login);
      }
    } catch (e) {
      Get.offAllNamed(Routes.Login);
    }
  }
}
