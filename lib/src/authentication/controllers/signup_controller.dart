import 'dart:convert';
import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:country_picker/country_picker.dart';
import 'package:hicoach_coach/common/dialogs/error_dialog.dart';
import 'package:hicoach_coach/core/constants/app_pages.dart';
import 'package:hicoach_coach/core/constants/localstorage_keys.dart';
import 'package:hicoach_coach/core/utils/helpers/functions.dart';
import 'package:hicoach_coach/models/coach.dart';
import 'package:hicoach_coach/services/authentication/regsiter_services.dart';
import 'package:hicoach_coach/services/profile/profile_service.dart';
import 'package:hicoach_coach/services/storage/storage_services.dart';
import 'package:hicoach_coach/src/authentication/views/signup/profile_setup.dart';

class SignUpController extends GetxController {
  // Controllers

  var fullName = Rx<TextEditingController>(TextEditingController());
  var email = Rx<TextEditingController>(TextEditingController());
  var password = Rx<TextEditingController>(TextEditingController());
  var phone = Rx<TextEditingController>(TextEditingController());

  var userData = Rx<Map<String, dynamic>?>(null);
  var profilePic = Rx<File?>(null);

  var formKey = Rx<GlobalKey<FormState>>(GlobalKey());

  // Observable variables

  var registering = false.obs;
  var updatingInfo = false.obs;

  var obsecure = true.obs;

  // Date of Birth
  var date = 0.obs;
  var month = ''.obs;
  var bio = ''.obs;
  var coachingExperience = ''.obs;
  var playingExperience = ''.obs;
  var year = 0.obs;
  var selectedCountry = Rx<Country?>(null);
  var selectedSport = ''.obs;
  var certificaiton = Rx<File?>(null);

  @override
  void onInit() {
    selectedCountry.value = Country(
      phoneCode: "91",
      countryCode: "IN",
      e164Sc: 0,
      geographic: true,
      level: 1,
      name: "India",
      example: "India",
      displayName: "India",
      displayNameNoCountryCode: "IN",
      e164Key: "",
    );
    super.onInit();
  }

  // Services

  final _service = RegisterServices();
  final _profileService = ProfileService();
  final _storageService = StorageServices();
  final localStorage = FlutterSecureStorage();

  void toggleObsecure() {
    obsecure.value = !obsecure.value;
  }

  Future<void> registerUser() async {
    try {
      registering.value = true;

      if (formKey.value.currentState!.validate()) {
        final data = {
          "fullname": fullName.value.text,
          "email": email.value.text,
          "password": password.value.text,
          "userType": 'Coach',
        };

        final userResponse = await _service.registerUser(data);
        userData.value = userResponse?['user'];

        await localStorage.write(
          key: LocalStorageKeys.userData,
          value: jsonEncode(userResponse?['user']),
        );

        await localStorage.write(
          key: LocalStorageKeys.dob,
          value: "${date.value}-${month.value}-${year.value}",
        );
        await localStorage.write(
          key: LocalStorageKeys.isInRegistrationProcess,
          value: 'true',
        );
        Get.to(() => ProfileSetup());
      } else {
        showErrorDialog("All Fields are required");
      }
    } catch (e) {
      showErrorDialog("Something went wrong! Please try again.");
    } finally {
      registering.value = false;
    }
  }

  void pickProfileImage({bool camera = false}) async {
    final userImage = await pickImage(camera: camera);
    if (userImage != null) {
      profilePic.value = userImage;
    }
  }

  void pickCertificate({bool camera = false}) async {
    final certificate = await pickImage(camera: camera);
    if (certificate != null) {
      certificaiton.value = certificate;
    }
  }

  Future<void> saveCoach() async {
    try {
      updatingInfo.value = true;
      final authToken = await localStorage.read(key: LocalStorageKeys.token) ?? "";
      String imageUrl = "";
      String certificateUrl = "";
      String dob = await localStorage.read(key: LocalStorageKeys.dob) ?? "";
      if (profilePic.value != null) {
        final url = await _storageService.uploadFileData(profilePic.value!);
        imageUrl = url.toString();
      }
      if (certificaiton.value != null) {
        final certificate = await _storageService.uploadFileData(
          certificaiton.value!,
        );
        certificateUrl = certificate.toString();
      }

      final Coach newCoach = Coach(
        userId: userData.value!['userId'],
        email: userData.value!['email'],
        fullName: userData.value!['fullname'],
        phone: phone.value.text,
        bio: bio.value,
        sports: [selectedSport.value],
        certifications: [certificateUrl],
        coachingAreas: [],
        coachingExperience: coachingExperience.value,
        dob: dob,
        gender: 'Male',
        playingExperience: playingExperience.value,
        profileURL: [imageUrl],
        timings: [],
        userType: 'Coach',
      );

      final response = await _profileService.createCoach(newCoach,authToken);

      debugPrint(response.toString());

      if (response != null) {
        await localStorage.delete(
          key: LocalStorageKeys.isInRegistrationProcess,
        );
        await localStorage.delete(key: LocalStorageKeys.dob);
        await localStorage.delete(key: LocalStorageKeys.userData);
        Get.offAllNamed(Routes.BottomNavBar);
      }
    } catch (e) {
      showErrorDialog(e.toString());
    } finally {
      updatingInfo.value = false;
    }
  }
}
