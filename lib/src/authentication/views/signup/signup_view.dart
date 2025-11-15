import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hicoach_coach/common/animation/animated_wrapper.dart';
import 'package:hicoach_coach/common/date/date_picker.dart';
import 'package:hicoach_coach/common/dialogs/error_dialog.dart';
import 'package:hicoach_coach/common/indicators/progress_indicators.dart';
import 'package:hicoach_coach/core/constants/colors.dart';
import 'package:hicoach_coach/core/utils/validators/vallidators.dart';
import 'package:hicoach_coach/src/authentication/controllers/signup_controller.dart';
import 'package:hicoach_coach/src/authentication/widget/auth_button.dart';
import 'package:hicoach_coach/src/authentication/widget/auth_field.dart';
import 'package:loading_overlay/loading_overlay.dart';

class SignUpView extends GetView<SignUpController> {
  const SignUpView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: AnimatedScreenWrapper(
        child: SafeArea(
          child: Obx(
            () => LoadingOverlay(
              progressIndicator: circularProgress(context),

              isLoading: controller.registering.value,
              color: Colors.black12,

              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
                child: Form(
                  key: controller.formKey.value,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// 🏷️ Heading
                      SizedBox(height: 40.h),

                      Text(
                        "Create your account",
                        style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          fontWeight: FontWeight.w500,
                         
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        "Sign up to get started with HiCoach",
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(
                          fontWeight: FontWeight.w400,
                          color: AppColors.textLighter,
                        ),
                      ),
                      SizedBox(height: 40.h),

                      /// 🧍 Full Name
                      _label(context, 'Full Name'),
                      AuthField(
                        hintText: 'Enter your full name',
                        validator: (value) =>
                            TValidator.validateEmptyText('Full Name', value),
                        controller: controller.fullName.value,
                      ),

                      SizedBox(height: 20.h),

                      /// 📧 Email
                      _label(context, 'Email'),
                      AuthField(
                        hintText: 'Enter your email',
                        validator: (value) => TValidator.validateEmail(value),
                        controller: controller.email.value,
                      ),

                      SizedBox(height: 20.h),

                      /// 🔑 Password
                      _label(context, 'Password'),
                      AuthField(
                        hintText: 'Enter your password',
                        obsecure: controller.obsecure.value,
                        controller: controller.password.value,
                        validator: (value) =>
                            TValidator.validatePassword(value),
                        suffixIcon: IconButton(
                          onPressed: () => controller.toggleObsecure(),
                          icon: Icon(
                            controller.obsecure.value
                                ? Icons.visibility_off_outlined
                                : Icons.visibility_outlined,
                            color: Colors.grey[500],
                          ),
                        ),
                      ),

                      SizedBox(height: 20.h),

                      /// 🎂 DOB
                      _label(context, 'Date of Birth'),
                      SizedBox(height: 8.h),
                      DatePicker(
                        date: (date) => controller.date.value = date!,
                        month: (month) => controller.month.value = month!,
                        year: (year) => controller.year.value = year!,
                      ),

                      SizedBox(height: 40.h),

                      /// 🔘 Register Button
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: AuthButton(
                          label: 'Create Account',
                          size: Size(271.w, 51.h),
                          onPressed: () {
                            if (controller.formKey.value.currentState!
                                .validate()) {
                              if (controller.date.value == 0 ||
                                  controller.month.value == "" ||
                                  controller.year.value == 0) {
                                showErrorDialog(
                                  "Please select your date of birth",
                                );
                              } else {
                                controller.registerUser();
                              }
                            }
                          },
                        ),
                      ),

                      SizedBox(height: 28.h),

                      /// 🔗 Already have account
                      Center(
                        child: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: "Already have an account? ",
                                style: TextStyle(
                                  color: Colors.grey[700],
                                  fontSize: 14.5.sp,
                                ),
                              ),
                              TextSpan(
                                text: "Sign in",
                                style: TextStyle(
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 14.5.sp,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Get.back();
                                  },
                              ),
                            ],
                          ),
                        ),
                      ),

                      SizedBox(height: 20.h),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _label(BuildContext context, String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: 6.h),
      child: Text(
        text,
        style: Theme.of(context).textTheme.titleSmall!.copyWith(),
      ),
    );
  }
}
