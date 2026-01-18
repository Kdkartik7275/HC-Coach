import 'dart:convert';
import 'dart:io';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:hicoach_coach/common/dialogs/error_dialog.dart';
import 'package:hicoach_coach/core/constants/app_pages.dart';
import 'package:hicoach_coach/core/constants/localstorage_keys.dart';
import 'package:hicoach_coach/models/coach.dart';
import 'package:hicoach_coach/models/package.dart';
import 'package:hicoach_coach/models/pricing.dart';
import 'package:hicoach_coach/services/authentication/login_services.dart';
import 'package:hicoach_coach/services/profile/profile_service.dart';
import 'package:hicoach_coach/src/authentication/controllers/signup_controller.dart';
import 'package:hicoach_coach/src/authentication/views/signup/profile_setup.dart';

class ProfileController extends GetxController {
  // LOADING VARIABLES
  var updatingInfo = false.obs;
  var profileLoading = false.obs;
  var errorFetchingData = false.obs;

  // USER DATA VARAIBLES
  var profilePic = Rx<File?>(null);
  var coachInfoSelectedIndex = 0.obs;
  final _user = Rx<Coach?>(null);

  // USER GETTER
  Coach? get user => _user.value;

  // SERVVICES
  final services = ProfileService();
  final loginServices = LoginServices();
  final storage = FlutterSecureStorage();

  Future<Coach?> fetchCoachByID(String id) async {
    try {

      Coach? coach = await services.getCoachById(id);
      return coach;
    } catch (e) {
      throw e.toString();
    }
  }

  Future<List<Pricing>?> getCoachPricings(String coachID) async {
    try {
      final prices = (user as Coach).pricings;

      return prices;
    } catch (e) {
      throw e.toString();
    }
  }

  Future<List<Package>?> getCoachPackages(String coachID) async {
    try {
      final packages = (user as Coach).packages;

      return packages;
    } catch (e) {
      throw e.toString();
    }
  }

  Future<void> fetchCurrentUser() async {
    try {
      profileLoading.value = true;
      errorFetchingData.value = false;

      final data = await loginServices.verifyToken();

      String userId = data['userId'];

      final coach = await services.getCoachById(userId);
      if (coach != null) {
        updateUser(coach);
        _user.refresh();
      } else {
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
      }
    } catch (e) {
      if (e.toString() == "Invalid or expired token") {
        Get.offAllNamed(Routes.Login);
      } else {
        errorFetchingData.value = true;
      }
    } finally {
      profileLoading.value = false;
    }
  }

  void updateUser(dynamic user) {
    _user.value = user;
  }

  void updateCoachInfoIndex(int index) {
    coachInfoSelectedIndex.value = index;
  }

  void logoutUser() async {
    try {
      await loginServices.logoutUser().then((_) {
        _user.value = null;
        Get.offAllNamed(Routes.Login);
      });
    } catch (e) {
      showErrorDialog("Something went wrong! Please try again.");
    }
  }
}
