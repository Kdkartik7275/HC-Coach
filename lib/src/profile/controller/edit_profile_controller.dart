import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:hicoach_coach/common/dialogs/error_dialog.dart';
import 'package:hicoach_coach/common/dialogs/success_dialog.dart';
import 'package:hicoach_coach/core/constants/localstorage_keys.dart';
import 'package:hicoach_coach/core/utils/helpers/functions.dart';
import 'package:hicoach_coach/models/coaching_area.dart';
import 'package:hicoach_coach/services/location/location_service.dart';
import 'package:hicoach_coach/services/profile/profile_service.dart';
import 'package:hicoach_coach/services/storage/storage_services.dart';
import 'package:hicoach_coach/src/profile/controller/profile_controller.dart';
import 'package:http/http.dart' as http;

/// ================= LOCATION SUGGESTION MODEL =================
class LocationSuggestion {
  final String title;
  final String subtitle;
  final double latitude;
  final double longitude;

  LocationSuggestion({
    required this.title,
    required this.subtitle,
    required this.latitude,
    required this.longitude,
  });
}

/// ================= EDIT PROFILE CONTROLLER =================
class EditProfileController extends GetxController {
  // TEXT CONTROLLERS
  final title = TextEditingController();
  final price = TextEditingController();
  final name = TextEditingController();
  final phone = TextEditingController();
  final location = TextEditingController();
  final bio = TextEditingController();
  final playExperience = TextEditingController();
  final coachingExperience = TextEditingController();
  final discount = TextEditingController();

  // FORM KEYS
  final pricingFormKey = GlobalKey<FormState>();
  final packageFormKey = GlobalKey<FormState>();

  // OBSERVABLES
  final pax = 1.obs;
  final hours = 1.obs;
  final packageFor = ''.obs;
  final loading = false.obs;

  final profiles = <dynamic>[].obs;
  final certifications = <dynamic>[].obs;
  final coachingAreas = <CoachingArea>[].obs;

  final RxList<LocationSuggestion> locationSuggestions =
      <LocationSuggestion>[].obs;

  Timer? _debounce;

  // SERVICES
  final profileController = Get.find<ProfileController>();
  final services = ProfileService();
  final storage = StorageServices();
  final localStorage = const FlutterSecureStorage();
  final locationService = LocationService();

  // ============================================================

  @override
  void onInit() {
    super.onInit();
    _initializeProfileFields();
  }

  void _initializeProfileFields() {
    final user = profileController.user!;
    name.text = user.fullName;
    phone.text = user.phone;
    bio.text = user.bio;
    profiles.value = user.profileURL ?? [];
    playExperience.text = user.playingExperience ?? '';
    coachingExperience.text = user.coachingExperience ?? '';
    certifications.value = user.certifications ?? [];
    coachingAreas.value = user.coachingAreas ?? [];

    if (coachingAreas.isNotEmpty) {
      location.text = coachingAreas.first.label;
    }
  }

  void _resetAllFields() {
    name.clear();
    phone.clear();
    bio.clear();
    profiles.value = [];
    playExperience.clear();
    coachingExperience.clear();
    certifications.value = [];
  }

  // ================= PROFILE UPDATE =================

  Future<void> updateCoachProfileInfo() async {
    try {
      loading.value = true;
      final token = await localStorage.read(key: LocalStorageKeys.token) ?? "";

      final coach = await services.updateCoach(
        {
          'fullName': name.text,
          'phone': phone.text,
          'bio': bio.text,
          'playingExperience': playExperience.text,
          'coachingExperience': coachingExperience.text,
          'certifications': certifications,
          'profileURL': profiles,
          'coachingAreas': coachingAreas.map((area) => area.toMap()).toList(),
        },
        profileController.user!.userId,
        token,
      );

      profileController.updateUser(coach);
      Get.back();
      showSuccessDialog("Profile Updated Successfully");
      _resetAllFields();
    } catch (e) {
      showErrorDialog(e.toString());
    } finally {
      loading.value = false;
    }
  }

  // ================= IMAGE UPLOAD =================

  Future<void> uploadNewProfile() async {
    try {
      final token = await localStorage.read(key: LocalStorageKeys.token) ?? "";

      final image = await pickImage();
      loading.value = true;

      if (image != null) {
        final imageURL = await storage.uploadFileData(image);
        profiles.add(imageURL);

        await services.updateCoach(
          {'profileURL': profiles},
          profileController.user!.userId,
          token,
        );
      }
    } catch (e) {
      showErrorDialog("Something went wrong! Please try again.");
    } finally {
      loading.value = false;
    }
  }

  Future<void> uploadNewCertification() async {
    try {
      final token = await localStorage.read(key: LocalStorageKeys.token) ?? "";

      final certificate = await pickImage();
      loading.value = true;

      if (certificate != null) {
        final certificateURL = await storage.uploadFileData(certificate);
        certifications.add(certificateURL);

        await services.updateCoach(
          {'certifications': certifications},
          profileController.user!.userId,
          token,
        );
      }
    } catch (e) {
      showErrorDialog("Something went wrong! Please try again.");
    } finally {
      loading.value = false;
    }
  }

  // ================= LOCATION (GPS) =================

  Future<void> getCurrentLocation() async {
    try {
      loading.value = true;

      final serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        showErrorDialog('Please enable location services');
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }

      if (permission == LocationPermission.denied) {
        showErrorDialog('Location permission is required');
        return;
      }

      if (permission == LocationPermission.deniedForever) {
        showErrorDialog(
          'Location permission permanently denied. Enable from settings.',
        );
        await Geolocator.openAppSettings();
        return;
      }

      final position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
        ),
      );

      final address = await locationService.getAddressFromLatLng(
        position.latitude,
        position.longitude,
      );

      if (address.isEmpty) {
        showErrorDialog('Unable to detect address');
        return;
      }

      coachingAreas.value = [
        CoachingArea(
          label: address,
          latitude: position.latitude,
          longitude: position.longitude,
        ),
      ];

      location.text = address;
    } catch (e) {
      showErrorDialog('Unable to fetch current location');
    } finally {
      loading.value = false;
    }
  }

  // ================= LOCATION SEARCH =================

  void onLocationChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();

    _debounce = Timer(const Duration(milliseconds: 500), () {
      if (query.isEmpty) {
        locationSuggestions.clear();
      } else {
        _fetchLocationSuggestions(query);
      }
    });
    debugPrint(locationSuggestions.toString());
  }

  Future<void> _fetchLocationSuggestions(String query) async {
    try {
      final uri = Uri.parse(
        'https://nominatim.openstreetmap.org/search'
        '?q=$query&format=json&addressdetails=1&limit=5',
      );

      final response = await http.get(
        uri,
        headers: {'User-Agent': 'HiCoach-App'},
      );

      if (response.statusCode == 200) {
        final List data = json.decode(response.body);
        debugPrint("Suggestion");
        debugPrint(data.toString());

        locationSuggestions.value = data.map((item) {
          final address = item['address'] ?? {};

          final title =
              address['suburb'] ??
              address['neighbourhood'] ??
              address['city'] ??
              address['town'] ??
              address['village'] ??
              item['display_name'].toString().split(',').first;

          final subtitle = [
            address['city'],
            address['state'],
            address['country'],
          ].where((e) => e != null).join(', ');

          return LocationSuggestion(
            title: title,
            subtitle: subtitle,
            latitude: double.parse(item['lat']),
            longitude: double.parse(item['lon']),
          );
        }).toList();
      } else {
        locationSuggestions.clear();
      }
    } catch (_) {
      locationSuggestions.clear();
    }
  }

  void selectLocation(LocationSuggestion suggestion) {
    final label = '${suggestion.title}, ${suggestion.subtitle}';

    coachingAreas.value = [CoachingArea(label: label, latitude: suggestion.latitude, longitude: suggestion.longitude)];

    location.text = label;
    locationSuggestions.clear();
  }
}
