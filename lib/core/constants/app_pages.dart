import 'package:get/get_navigation/src/routes/get_route.dart';


part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const initial = Routes.SPLASH;

  // static final routes = [
  //   GetPage(name: _Paths.ONBOARD, page: () =>  OnboardingScreen()),
  //   GetPage(name: _Paths.SPLASH, page: () => const SplashView()),

  //   // ----------------- AUTHENTICATION -----------------
  //   GetPage(
  //     name: _Paths.LOGIN,
  //     page: () => const LoginView(),
  //     binding: LoginBinding(),
  //   ),
  //   GetPage(
  //     name: _Paths.SIGN_UP,
  //     page: () => const SignUpView(),
  //     binding: SignupBinding(),
  //   ),
  //     GetPage(
  //     name: _Paths.FORGOT_PASSWORD,
  //     page: () => const ForgotPasswordView(),
     
  //   ),

  //   // ----------------- BOTTOM NAVBAR -----------------
  //   GetPage(
  //     name: _Paths.BOTTOMNAVBAR,
  //     page: () => const BottomNavbarView(),
  //     binding: BottomNavbarBinding(),
  //   ),

  //   // ----------------- PROFILE -----------------
  //   GetPage(
  //     name: _Paths.EDIT_PROFILE,
  //     page: () => const StudentEditProfileView(),
  //     binding: EditProfileBinding(),
  //   ),

  //   // ----------------- CHATS -----------------
  //   GetPage(name: _Paths.CHATS, page: () => const ChatsView()),

  //   // ----------------- BOOKINGS -----------------
  //   GetPage(name: _Paths.SELECTDATE, page: () => const SelectDateView()),
  //   GetPage(name: _Paths.PAYMENT, page: () => const PaymentView()),
  //   GetPage(name: _Paths.SUCCESSBOOKING, page: () => const SuccessView()),
  //   GetPage(
  //     name: _Paths.BOOKINGCONFIRMATION,
  //     page: () => const ConfirmationView(),
  //   ),
  //   GetPage(
  //     name: _Paths.BOOKINGS,
  //     binding: BookingBinding(),
  //     page: () => throw UnimplementedError(),
  //   ),
  // ];
}
