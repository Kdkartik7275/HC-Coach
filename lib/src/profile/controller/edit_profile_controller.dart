import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hicoach_coach/common/dialogs/error_dialog.dart';
import 'package:hicoach_coach/core/utils/helpers/functions.dart';
import 'package:hicoach_coach/models/coaching_area.dart';
import 'package:hicoach_coach/models/package.dart';
import 'package:hicoach_coach/models/pricing.dart';
import 'package:hicoach_coach/services/profile/profile_service.dart';
import 'package:hicoach_coach/services/storage/storage_services.dart';
import 'package:hicoach_coach/src/profile/controller/profile_controller.dart';

class EditProfileController extends GetxController {
  // CONTROLLERS
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

  // OBSERVABLE VARIABLES

  var pax = 1.obs;
  var hours = 1.obs;
  var packageFor = ''.obs;
  var loading = false.obs;

  var prices = Rx<List<Pricing>>([]);
  var packages = Rx<List<Package>>([]);
  var profiles = Rx<List>([]);

  var certifications = Rx<List>([]);
  var coachingAreas = Rx<List<CoachingArea>>([]);
  var suggestions = Rx<List>([]);

  // PROFILE CONTROLLER

  final profileController = Get.find<ProfileController>();

  final services = ProfileService();
  final _storage = StorageServices();

  // final locationServices = LocationServices();

  @override
  void onInit() {
    super.onInit();
    _initilizeProfileFields();
  }

  _initilizeProfileFields() {
    final user = profileController.user!;
    name.text = user.fullName;
    phone.text = user.phone;
    bio.text = user.bio;
    profiles.value = user.profileURL!;
    playExperience.text = user.playingExperience!;
    coachingExperience.text = user.coachingExperience!;
    certifications.value = user.certifications!;

    coachingAreas.value = user.coachingAreas!;
    prices.value = user.pricings ?? [];
    packages.value = user.packages ?? [];
  }

  _resetAllFields() {
    name.clear();
    phone.clear();
    bio.clear();
    profiles.value = [];
    playExperience.clear();
    coachingExperience.clear();
    certifications.value = [];

    prices.value = [];
    packages.value = [];
  }

  void addPricing() {
    if (pricingFormKey.currentState!.validate()) {
      loading.value = true;
      _addPrice(
        Pricing(
          title: title.text.capitalize!,
          price: int.parse(price.text),
          pax: pax.value,
        ),
      );

      Get.back();
      title.clear();
      price.clear();
    }
    loading.value = false;
  }

  void addPackage() {
    if (packageFormKey.currentState!.validate()) {
      loading.value = true;
      int actualPrice = prices.value
          .where((price) => price.title == packageFor.value)
          .first
          .price;
      _addPackage(
        Package(
          packageFor: packageFor.value,
          hours: hours.value,
          actualPrice: actualPrice,
          discount: int.parse(discount.text),
        ),
      );

      Get.back();
      packageFor.value = '';
      discount.clear();
    }
    loading.value = false;
  }

  updateCoachProfileInfo() async {
    try {
      loading.value = true;

      final coach = await services.updateCoach({
        'fullName': name.text,
        'phone': phone.text,
        'bio': bio.text,
        'playingExperience': playExperience.text,
        'coachingExperience': coachingExperience.text,
        'certifications': certifications.value,
        'profileURL': profiles.value,
        'coachingAreas': coachingAreas.value
            .map((area) => area.toMap())
            .toList(),
        'pricing': prices.value.map((price) => price.toMap()).toList(),
        'package': packages.value.map((package) => package.toMap()).toList(),
      }, profileController.user!.userId);

      loading.value = false;
      profileController.updateUser(coach);
      Get.back();
      _resetAllFields();
    } catch (e) {
      loading.value = false;
      showErrorDialog("Something went wrong! Please try again.");
    }
  }

  uploadNewProfile() async {
    try {
      final image = await pickImage();
      loading.value = true;
      if (image != null) {
        final imageURl = await _storage.uploadFileData(image);

        profiles.value.add(imageURl);

        await services.updateCoach({
          'profileURL': profiles.value,
        }, profileController.user!.userId);
      }
    } catch (e) {
      showErrorDialog("Something went wrong! Please try again.");
    } finally {
      loading.value = false;
    }
  }

  uploadNewCertification() async {
    try {
      final certificate = await pickImage();
      loading.value = true;
      if (certificate != null) {
        final certificateURL = await _storage.uploadFileData(certificate);

        certifications.value.add(certificateURL);

        await services.updateCoach({
          'profileURL': profiles.value,
        }, profileController.user!.userId);
      }
    } catch (e) {
      showErrorDialog("Something went wrong! Please try again.");
    } finally {
      loading.value = false;
    }
  }

  _addPrice(Pricing price) {
    prices.value.add(price);
  }

  _addPackage(Package package) {
    packages.value.add(package);
  }

  removePackage(Package package) {
    packages.value.remove(package);
    packages.refresh();
  }

  removePrice(Pricing price) {
    prices.value.remove(price);
    packages.value.removeWhere((pkg) => pkg.packageFor == price.title);
    packages.refresh();
    prices.refresh();
  }

  Future<void> searchAreas(String input) async {
    try {
      // final areas = await locationServices.getAreas(input);
      // if (areas.isNotEmpty) {
      //   suggestions.value = areas;
      // } else {
      //   suggestions.value = [];
      // }
    } catch (e) {
      //
    }
  }

  addAreas(String text) async {
    // final latlng = await locationServices.getLatLngFromAddress(text);

    // coachingAreas.value.add(CoachingArea(
    //     label: text, latitude: latlng!.latitude, longitude: latlng.longitude));
    // print(coachingAreas.value);
    // suggestions.value = [];
  }
}
