import 'package:get/get.dart';
import 'package:hicoach_coach/src/bookings/controller/timings_controller.dart';

class TrainingTimingsBinding extends Bindings {
  @override
  void dependencies() {
   Get.lazyPut<TimingsController>(() => TimingsController());
  }
}