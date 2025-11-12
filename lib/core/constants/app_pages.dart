import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:hicoach_coach/src/authentication/bindings/login_binding.dart';
import 'package:hicoach_coach/src/authentication/views/login/login_view.dart';
import 'package:hicoach_coach/src/forgot_password/binding/forgot_password_binding.dart';
import 'package:hicoach_coach/src/forgot_password/view/forgot_password.dart';
import 'package:hicoach_coach/src/onboarding/binding/onboarding_binding.dart';
import 'package:hicoach_coach/src/onboarding/view/onboarding_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const initial = Routes.Login;

  static final routes = [
    GetPage(
      name: _Paths.OnBoard,
      page: () => OnboardingScreen(),
      binding: OnboardingBinding(),
    ),

    //   // ----------------- AUTHENTICATION -----------------
      GetPage(
        name: _Paths.Login,
        page: () => const LoginView(),
        binding: LoginBinding(),
      ),
    //   GetPage(
    //     name: _Paths.SIGN_UP,
    //     page: () => const SignUpView(),
    //     binding: SignupBinding(),
    //   ),
        GetPage(
        name: _Paths.ForgotPassword,
        page: () => const ForgotPasswordView(),
        binding: ForgotPasswordBinding()

      ),

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
  ];
}
