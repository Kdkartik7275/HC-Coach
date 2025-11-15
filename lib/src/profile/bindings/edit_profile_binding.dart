import 'package:get/get.dart';
import 'package:hicoach_coach/src/profile/controller/edit_profile_controller.dart';

class EditProfileBinding extends Bindings{
  @override
  void dependencies() {
    
    Get.lazyPut<EditProfileController>(() => EditProfileController());
  }
}