import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hicoach_coach/common/indicators/progress_indicators.dart';
import 'package:hicoach_coach/core/constants/colors.dart';
import 'package:hicoach_coach/src/enrollments/controller/enrollments_controller.dart';
import 'package:hicoach_coach/src/enrollments/widgets/new_enrollment_card.dart';
import 'package:loading_overlay/loading_overlay.dart';

class NewEnrollmentsPage extends GetView<EnrollmentsController> {
  const NewEnrollmentsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final enrollments = controller.newEnrollments;
    return Obx(() {
      return Scaffold(
        backgroundColor: AppColors.white,
        appBar: AppBar(
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "New Enrollments",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              if (enrollments.isNotEmpty)
                Text(
                  "${enrollments.length} pending request${enrollments.length != 1 ? 's' : ''}",
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    color: AppColors.textLighter,
                    fontSize: 12.sp,
                  ),
                ),
            ],
          ),
          elevation: 0,
          toolbarHeight: 70.h,
        ),
        body: LoadingOverlay(
          isLoading:
              controller.updatingDecision.value || controller.isLoading.value,
          progressIndicator: circularProgress(context),
          child: enrollments.isEmpty
              ? const _EmptyState()
              : ListView.separated(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.w,
                    vertical: 16.h,
                  ),
                  itemCount: enrollments.length,
                  separatorBuilder: (_, _) => SizedBox(height: 16.h),
                  itemBuilder: (context, index) {
                    return EnrollmentCard(
                      enrollment: enrollments[index],
                      onAccept: () async {
                        await controller.acceptOrRejectEnrollment(
                          decision: 'accept',
                          enrollmentId: enrollments[index].id,
                        );
                      },
                      onReject: () async {
                        final reason = await showRejectReasonBottomSheet(
                          context,
                        );
                        if (reason != null) {
                          await controller.acceptOrRejectEnrollment(
                            decision: 'reject',
                            enrollmentId: enrollments[index].id,
                            reason: reason,
                          );
                        }
                      },
                    );
                  },
                ),
        ),
      );
    });
  }
}

Future<String?> showRejectReasonBottomSheet(BuildContext context) async {
  final reasons = [
    "Schedule conflict with other sessions",
    "Currently overbooked",
    "Personal reasons",
    "Not accepting new students at this time",
    "Other",
  ];

  final selectedReason = ValueNotifier<String?>(null);
  final otherController = TextEditingController();

  return await Get.bottomSheet<String>(
    StatefulBuilder(
      builder: (_, setState) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10,
                offset: Offset(0, -3),
              ),
            ],
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                /// Drag handle
                Container(
                  width: 40.w,
                  height: 4.h,
                  margin: EdgeInsets.only(bottom: 12.h),
                  decoration: BoxDecoration(
                    color: AppColors.textLighter,
                    borderRadius: BorderRadius.circular(2.r),
                  ),
                ),
                Text(
                  "Reject Enrollment",
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  "Select a reason or enter your own",
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: AppColors.textLighter,
                  ),
                ),
                SizedBox(height: 12.h),

                /// Reason Chips
                Wrap(
                  spacing: 10.w,
                  runSpacing: 0.h,
                  children: reasons.map((reason) {
                    final isSelected = selectedReason.value == reason;
                    return ChoiceChip(
                      label: Text(
                        reason,
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          color: isSelected ? AppColors.white : Colors.black87,
                          fontSize: 13.sp,
                        ),
                      ),
                      selected: isSelected,
                      onSelected: (_) {
                        setState(() {
                          selectedReason.value = reason;
                          if (reason != "Other") otherController.clear();
                        });
                      },

                      selectedColor: AppColors.primary,
                      backgroundColor: AppColors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: 12.w,
                        vertical: 8.h,
                      ),
                    );
                  }).toList(),
                ),

                /// Other Text Field
                if (selectedReason.value == "Other")
                  Padding(
                    padding: EdgeInsets.only(top: 12.h),
                    child: TextField(
                      controller: otherController,
                      autofocus: true,
                      maxLines: 2,
                      decoration: InputDecoration(
                        hintText: "Enter your reason",
                        filled: true,
                        fillColor: AppColors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.r),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),

                SizedBox(height: 14.h),

                /// Buttons
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => Get.back(),
                        style: OutlinedButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: 12.h),
                          side: BorderSide(color: Colors.grey.shade400),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                        ),
                        child: Text(
                          "Cancel",
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ),
                    ),

                    SizedBox(width: 12.w),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          final reason = selectedReason.value;
                          if (reason == null) return;

                          if (reason == "Other" &&
                              otherController.text.trim().isEmpty) {
                            Get.snackbar(
                              "Reason required",
                              "Please enter a rejection reason",
                              snackPosition: SnackPosition.BOTTOM,
                            );
                            return;
                          }

                          Get.back(
                            result: reason == "Other"
                                ? otherController.text.trim()
                                : reason,
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          padding: EdgeInsets.symmetric(vertical: 12.h),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                        ),
                        child: Text(
                          "Reject",
                          style: Theme.of(context).textTheme.titleLarge!
                              .copyWith(color: AppColors.white),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.h),
              ],
            ),
          ),
        );
      },
    ),
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
  );
}

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(24.w),
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: .06),
              shape: BoxShape.circle,
            ),
            child: Icon(
              CupertinoIcons.person_crop_circle_badge_plus,
              size: 64.sp,
              color: AppColors.primary.withValues(alpha: .6),
            ),
          ),
          SizedBox(height: 20.h),
          Text(
            "No New Enrollments",
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18.sp),
          ),
          SizedBox(height: 8.h),
          Text(
            "New student requests will appear here",
            style: Theme.of(
              context,
            ).textTheme.labelMedium?.copyWith(color: AppColors.textLighter),
          ),
        ],
      ),
    );
  }
}
