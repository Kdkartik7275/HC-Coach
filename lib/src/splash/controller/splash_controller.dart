
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  final FlutterSecureStorage storage = const FlutterSecureStorage();
//  final LoginServices _services = LoginServices();

  Future<void> setInitialView() async {
    // try {
    //   final bool isAuthenticated = await _services.isAuthenticated();

    //   if (isAuthenticated) {
      
    //     Get.offAllNamed(Routes.BOTTOMNAVBAR);
        
    //   }

    //   else {
    //     Get.offAllNamed(Routes.LOGIN);
    //   }
    // } catch (e) {
    //   Get.offAllNamed(Routes.LOGIN);
    // }
  }
}
