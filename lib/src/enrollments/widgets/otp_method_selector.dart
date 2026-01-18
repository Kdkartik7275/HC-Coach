import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hicoach_coach/core/constants/colors.dart';
import 'package:hicoach_coach/models/student.dart';
import 'package:hicoach_coach/src/enrollments/controller/enrollments_controller.dart';

class OtpMethodSelector extends StatelessWidget {
   final Student? student;
  const OtpMethodSelector(Key? key, this.student) : super(key: key);
 
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<EnrollmentsController>();
    return Obx(
      () => Column(
        children: [
          if (student?.phone != null && student!.phone.isNotEmpty)
            _OtpOptionTile(
              title: student!.phone,
              subtitle: "Send OTP via SMS",
              icon: CupertinoIcons.phone,
              selected:
                  controller.selectedOtpMethod.value == OtpSendMethod.phone,
              onTap: () => controller.setOtpMethod(OtpSendMethod.phone),
            ),
          SizedBox(height: 8.h),
          if (student?.email != null && student!.email.isNotEmpty)
            _OtpOptionTile(
              title: student!.email,
              subtitle: "Send OTP via Email",
              icon: CupertinoIcons.mail,
              selected:
                  controller.selectedOtpMethod.value == OtpSendMethod.email,
              onTap: () => controller.setOtpMethod(OtpSendMethod.email),
            ),
        ],
      ),
    );
  }
}

class _OtpOptionTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final bool selected;
  final VoidCallback onTap;
  const _OtpOptionTile({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.selected,
    required this.onTap,
  });
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: selected ? AppColors.primary : AppColors.border,
          ),
          color: selected
              ? AppColors.primary.withOpacity(0.05)
              : Colors.transparent,
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: selected ? AppColors.primary : AppColors.textLighter,
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    subtitle,
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: AppColors.textLighter,
                    ),
                  ),
                ],
              ),
            ),
            if (selected)
              Icon(
                CupertinoIcons.check_mark_circled_solid,
                color: AppColors.primary,
              ),
          ],
        ),
      ),
    );
  }
}
