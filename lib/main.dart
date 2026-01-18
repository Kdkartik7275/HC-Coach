import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hicoach_coach/core/constants/app_pages.dart';
import 'package:hicoach_coach/core/utils/theme/theme.dart';
import 'package:hicoach_coach/src/profile/controller/profile_controller.dart';
import 'package:hicoach_coach/src/splash/controller/splash_controller.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await dotenv.load(fileName: ".env");
  Get.put(SplashController());
  Get.put(ProfileController());
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  bool _ranOnce = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_ranOnce) {
      _ranOnce = true;
      final splashController = Get.find<SplashController>();
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        await splashController.setInitialView();
        FlutterNativeSplash.remove();
      });
    }
  }
  @override
  Widget build(BuildContext context) {
   
    return ScreenUtilInit(
      designSize: const Size(375, 852),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        final theme = AppTheme.lightTheme;
        return GetMaterialApp(
          title: 'HC Coach',
          debugShowCheckedModeBanner: false,
          theme: theme,
          initialRoute: AppPages.initial,
          getPages: AppPages.routes,
        );
      },
    );
  }
}
