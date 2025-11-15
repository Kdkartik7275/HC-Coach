import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hicoach_coach/common/animation/animated_wrapper.dart';
import 'package:hicoach_coach/common/headings/heading.dart';
import 'package:hicoach_coach/common/indicators/progress_indicators.dart';
import 'package:hicoach_coach/core/constants/app_pages.dart';
import 'package:hicoach_coach/core/constants/colors.dart';
import 'package:hicoach_coach/core/constants/strings.dart';
import 'package:hicoach_coach/core/utils/validators/vallidators.dart';
import 'package:hicoach_coach/src/authentication/controllers/login_controller.dart';
import 'package:hicoach_coach/src/authentication/widget/auth_button.dart';
import 'package:hicoach_coach/src/authentication/widget/auth_field.dart';

import 'package:loading_overlay/loading_overlay.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(AppStrings.appName)),
      body: AnimatedScreenWrapper(
        child: Obx(
          () => LoadingOverlay(
            isLoading: controller.isLoading.value,
            progressIndicator: circularProgress(context),
            color: Colors.black12,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 24.h),
              child: ListView(
                children: [
                  SizedBox(height: 12.h),
                  TitleSubtitle(
                    title: AppStrings.login,
                    subtitle: Text(
                      AppStrings.loginSubtitle,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                  SizedBox(height: 50.h),
                  Form(
                    key: controller.loginFormKey.value,
                    autovalidateMode: AutovalidateMode.onUnfocus,
                    child: Column(
                      children: [
                        AuthField(
                          validator: (value) => TValidator.validateEmail(value),
                          controller: controller.email.value,
                          hintText: 'Enter your email',
                          inputFormatters: [
                            FilteringTextInputFormatter.deny(RegExp(r"\s")),
                          ],
                        ),
                        SizedBox(height: 12.h),
                        AuthField(
                          validator: (value) =>
                              TValidator.validateEmptyText('Password', value),
                          controller: controller.password.value,

                          hintText: 'Enter your Password',
                          obsecure: controller.obsecure.value,
                          suffixIcon: GestureDetector(
                            onTap: () => controller.obsecure.value =
                                !controller.obsecure.value,
                            child: Icon(
                              controller.obsecure.value
                                  ? Icons.visibility_outlined
                                  : Icons.visibility_off_outlined,
                            ),
                          ),
                          inputFormatters: [
                            FilteringTextInputFormatter.deny(RegExp(r"\s")),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      InkWell(
                        onTap: () {
                          controller.toggleRememberMe();
                        },
                        child: Container(
                          margin: EdgeInsets.only(right: 5.w),
                          height: 20.h,
                          width: 20.w,
                          decoration: BoxDecoration(
                            color: controller.rememberme.value
                                ? AppColors.primary
                                : AppColors.white,
                            borderRadius: BorderRadius.circular(6.r),
                            border: controller.rememberme.value
                                ? null
                                : Border.all(color: AppColors.border),
                          ),
                          child: controller.rememberme.value
                              ? Icon(
                                  Icons.check,
                                  size: 16.sp,
                                  color: AppColors.white,
                                )
                              : null,
                        ),
                      ),
                      Text(
                        AppStrings.rememberMe,
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(
                          color: AppColors.hintText,
                        ),
                      ),
                      const Spacer(),
                      TextButton(
                        onPressed: () => Get.toNamed(Routes.ForgotPassword),
                        child: Text(
                          'Forget Password?',
                          style: TextStyle(
                            color: const Color(0xffFF3951),
                            fontSize: 12.sp,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 50.h),

                  AuthButton(
                    label: 'Continue',
                    size: Size(271.w, 51.h),
                    onPressed: () {
                      if (controller.loginFormKey.value.currentState!
                          .validate()) {
                        controller.loginWithEmailPassword();
                      }
                    },
                  ),
                  SizedBox(height: 30.h),
                  Align(
                    alignment: Alignment.center,
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'Don’t have an account? ',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14.sp,
                            ),
                          ),
                          TextSpan(
                            text: 'Sign up',
                            style: TextStyle(
                              color: AppColors.primary,
                              fontSize: 16.sp,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () => Get.toNamed(Routes.SignUp)
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
