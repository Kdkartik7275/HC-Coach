import 'package:get/get.dart';
import 'package:hicoach_coach/src/authentication/controllers/signup_controller.dart';

class SignupBinding extends Bindings{
  @override
  void dependencies() {
   Get.lazyPut<SignUpController>(() => SignUpController());
  }
}