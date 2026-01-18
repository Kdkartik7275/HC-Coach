import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hicoach_coach/core/constants/colors.dart';
class EmptyChat extends StatelessWidget {
  const EmptyChat({
    super.key,
    required this.fullName,
  });

  final String fullName;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 32.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            /// Icon
            Container(
              height: 72.r,
              width: 72.r,
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: .08),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.chat_bubble_outline_rounded,
                size: 32.r,
                color: AppColors.primary,
              ),
            ),

            SizedBox(height: 16.h),

            /// Title
            Text(
              'No messages yet',
              style: textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w400,
                fontSize: 16.sp,
              ),
            ),

            SizedBox(height: 6.h),

            /// Subtitle
            Text(
              'Start a conversation with ${fullName.split(' ').first}',
              textAlign: TextAlign.center,
              style: textTheme.titleSmall?.copyWith(
                fontSize: 13.sp,
                color: Colors.grey[600],
              ),
            ),

            SizedBox(height: 8.h),

            /// Helper text
            Text(
              'Say hello 👋',
              style: textTheme.titleSmall?.copyWith(
                fontSize: 12.sp,
                color: Colors.grey[500],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
