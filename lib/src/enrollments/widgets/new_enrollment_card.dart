
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hicoach_coach/core/constants/colors.dart';
import 'package:hicoach_coach/models/enrollment_model.dart';
import 'package:hicoach_coach/models/student.dart';
import 'package:hicoach_coach/src/enrollments/controller/enrollments_controller.dart';
import 'package:intl/intl.dart';

class EnrollmentCard extends GetView<EnrollmentsController> {
  final EnrollmentModel enrollment;
  final VoidCallback onAccept;
  final VoidCallback onReject;

  const EnrollmentCard({
    super.key,
    required this.enrollment,
    required this.onAccept,
    required this.onReject,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    final student = controller.studentsCache[enrollment.studentId];

    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: AppColors.primary.withValues(alpha: .08)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          /// TOP ROW (Avatar + Info)
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _Avatar(student: student!),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            student.fullName,
                            style: theme.titleSmall?.copyWith(
                              fontWeight: FontWeight.w700,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        _ModernStatusChip(label: "NEW"),
                      ],
                    ),

                    Text(
                      enrollment.program.title,
                      style: theme.labelMedium?.copyWith(
                        color: AppColors.textLighter,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 8.h),

                    /// COMPACT INFO ROW
                    _MiniInfo(
                      icon: Icons.date_range_outlined,
                      value: DateFormat(
                        'dd MMM yyyy',
                      ).format(enrollment.startDate),
                    ),
                    SizedBox(height: 2.h),
                    Row(
                      children: [
                        Expanded(
                          child: _MiniInfo(
                            icon: Icons.schedule_rounded,
                            value: enrollment.sessions.first.slot,
                          ),
                        ),
                        SizedBox(width: 12.w),
                        Expanded(
                          child: _MiniInfo(
                            icon: Icons.event_repeat_rounded,
                            value: "${enrollment.sessions.length} sessions",
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),

          SizedBox(height: 12.h),

          /// ACTIONS
          Row(
            children: [
              Expanded(
                child: _CompactOutlineButton(
                  label: "Decline",
                  onTap: onReject,
                  color: Colors.red.shade400,
                ),
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: _CompactPrimaryButton(label: "Accept", onTap: onAccept),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _Avatar extends StatelessWidget {
  final Student student;

  const _Avatar({required this.student});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 44.w,
      height: 44.w,
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: student.profileUrls?.firstOrNull != null
          ? ClipRRect(
              borderRadius: BorderRadius.circular(12.r),
              child: Image.network(
                student.profileUrls!.first,
                fit: BoxFit.cover,
              ),
            )
          : Icon(
              CupertinoIcons.person_fill,
              color: AppColors.white,
              size: 22.sp,
            ),
    );
  }
}

class _MiniInfo extends StatelessWidget {
  final IconData icon;
  final String value;

  const _MiniInfo({required this.icon, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 14.sp, color: AppColors.primary),
        SizedBox(width: 4.w),
        Expanded(
          child: Text(
            value,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.titleSmall!.copyWith(
              fontSize: 12.sp,
              fontWeight: FontWeight.normal,
              color: Colors.black87,
            ),
          ),
        ),
      ],
    );
  }
}

class _CompactOutlineButton extends StatelessWidget {
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _CompactOutlineButton({
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onTap,
      style: OutlinedButton.styleFrom(
        foregroundColor: color,
        padding: EdgeInsets.symmetric(vertical: 10.h),
        side: BorderSide(color: color.withValues(alpha: .3)),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.r),
        ),
      ),
      child: Text(
        label,
        style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w600),
      ),
    );
  }
}

class _CompactPrimaryButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const _CompactPrimaryButton({required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        padding: EdgeInsets.symmetric(vertical: 10.h),
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.r),
        ),
      ),
      child: Text(
        label,
        style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w700),
      ),
    );
  }
}

class _ModernStatusChip extends StatelessWidget {
  final String label;

  const _ModernStatusChip({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.primary, AppColors.primary.withValues(alpha: .8)],
        ),
        borderRadius: BorderRadius.circular(6.r),
      ),
      child: Text(
        label,
        style: Theme.of(context).textTheme.titleSmall!.copyWith(
          fontSize: 10.sp,
          fontWeight: FontWeight.w700,
          color: AppColors.white,
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}
