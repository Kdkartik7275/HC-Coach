import 'package:get/get.dart';
import 'package:hicoach_coach/src/navbar/controller/bottom_navbar_controller.dart';

class BottomNavbarBinding extends Bindings{
  @override
  void dependencies() {
   Get.lazyPut<BottomNavBarController>(() => BottomNavBarController());
  }
}