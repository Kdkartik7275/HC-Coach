import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:flutter/cupertino.dart';
import 'package:hicoach_coach/core/constants/colors.dart';

void showErrorDialog(String message) {
  Get.closeAllSnackbars();
  Get.rawSnackbar(
    messageText: Text(
      message,
      textAlign: TextAlign.center,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
    ),
    backgroundColor: Colors.redAccent,
    snackStyle: SnackStyle.FLOATING,
    snackPosition: SnackPosition.TOP,
    borderRadius: 12,
    margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
    duration: const Duration(seconds: 2),
    isDismissible: true,
    animationDuration: const Duration(milliseconds: 400),
    forwardAnimationCurve: Curves.easeOutBack,
    reverseAnimationCurve: Curves.easeIn,
  );
}

Future<void> showErrorDialogWithAction({
  required String message,
  required String buttonText,
  required VoidCallback onConfirm,
}) async {
  await Get.dialog(
    CupertinoAlertDialog(
      insetAnimationDuration: const Duration(milliseconds: 200),
      content: Padding(
        padding: const EdgeInsets.only(top: 6.0),
        child: Text(
          message,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: AppColors.text,
            fontSize: 13.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      actions: [
        CupertinoDialogAction(
          onPressed: () => Get.back(),
          child: Text(
            "Cancel",
            style: TextStyle(
              color: AppColors.text,
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        CupertinoDialogAction(
          onPressed: () {
            Get.back();
            onConfirm();
          },
          child: Text(
            buttonText,
            style: TextStyle(
              color: AppColors.primary,
              fontWeight: FontWeight.w500,
              fontSize: 15.sp,
            ),
          ),
        ),
      ],
    ),
    barrierDismissible: false,
  );
}
