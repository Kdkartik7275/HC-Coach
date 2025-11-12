import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:hicoach_coach/common/dialogs/error_dialog.dart';
import 'package:hicoach_coach/core/constants/app_pages.dart';
import 'package:hicoach_coach/core/constants/localstorage_keys.dart';
import 'package:hicoach_coach/services/authentication/login_services.dart';
import 'package:hicoach_coach/services/remember_me/remember_me_services.dart';

class LoginController extends GetxController {
  var email = Rx<TextEditingController>(TextEditingController());
  var password = Rx<TextEditingController>(TextEditingController());

  var loginFormKey = Rx<GlobalKey<FormState>>(GlobalKey());

  // Observable variables

  var obsecure = true.obs;
  var isLoading = false.obs;
  var rememberme = false.obs;

  // Services
  final services = LoginServices();
  final FlutterSecureStorage storage = const FlutterSecureStorage();

  @override
  void onInit() {
    super.onInit();
    _loadSavedCredentials();
  }

  void _loadSavedCredentials() async {
    final data = await RememberMeService.getUserCredentials();
    if (data.isNotEmpty) {
      email.value.text = data['email'] ?? '';
      password.value.text = data['password'] ?? '';
      rememberme.value = true;
    }
  }

  toggleRememberMe() {
    rememberme.value = !rememberme.value;
  }

  toggleObsecure() {
    obsecure.value = !obsecure.value;
  }

  void loginWithEmailPassword() async {
    try {
      isLoading.value = true;
      final data = await services.loginWithEmailAndPassword(
        email: email.value.text,
        password: password.value.text,
      );

      if (!rememberme.value) {
        RememberMeService.clearUserCredentials();
      } else {
        RememberMeService.saveUserCredentials(
          email.value.text,
          password.value.text,
        );
      }

      if (data != null) {
        await storage.write(
          key: LocalStorageKeys.userData,
          value: jsonEncode(data['user']),
        );
        Get.offAllNamed(Routes.BottomNavBar);
      }
    } catch (e) {
      showErrorDialog(e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
