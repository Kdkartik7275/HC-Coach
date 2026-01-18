import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hicoach_coach/common/image/network_image.dart';
import 'package:hicoach_coach/common/preview/preview_image.dart';
import 'package:hicoach_coach/core/constants/colors.dart';
import 'package:hicoach_coach/models/coach.dart';
import 'package:hicoach_coach/src/profile/controller/profile_controller.dart';

class CoachResumeWidget extends GetView<ProfileController> {
  const CoachResumeWidget({super.key, required this.coach});
  final Coach coach;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionCard(
          context,
          title: "Bio",
          icon: Icons.person_outline,
          content: coach.bio,
        ),

        _sectionCard(
          context,
          title: "Playing Experience",
          icon: Icons.sports_soccer_outlined,
          content: coach.playingExperience ?? "",
        ),

        _sectionCard(
          context,
          title: "Coaching Experience",
          icon: Icons.school_outlined,
          content: coach.coachingExperience ?? "",
        ),

        _certificationSection(context),
        SizedBox(height: 40.h),
      ],
    );
  }

  Widget _certificationSection(BuildContext context) {
    if (coach.certifications == null || coach.certifications!.isEmpty) {
      return SizedBox();
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Certifications",
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
          ),
        ),

        SizedBox(height: 12.h),

        SizedBox(
          height: 150.h,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: coach.certifications?.length ?? 0,
            separatorBuilder: (_, _) => SizedBox(width: 12.w),
            itemBuilder: (context, index) {
              final certUrl = coach.certifications![index];
              return GestureDetector(
                onTap: () => showImageOverlay(
                  context,
                  coach.certifications! as List<String>,
                  index
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16.r),
                  child: TCachedNetworkImage(
                    profileURL: certUrl,
                    height: 150.h,
                    width: 130.w,
                    boxFit: BoxFit.cover,
                  ),
                ),
              );
            },
          ),
        ),

        SizedBox(height: 25.h),
      ],
    );
  }
}

Widget _sectionCard(
  BuildContext context, {
  required String title,
  required IconData icon,
  required String content,
}) {
  return Container(
    margin: EdgeInsets.only(bottom: 20.h),
    padding: EdgeInsets.all(16.w),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16.r),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: .06),
          blurRadius: 10,
          offset: Offset(0, 3),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: EdgeInsets.all(6.w),
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: .1),
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Icon(icon, color: AppColors.primary, size: 20.sp),
            ),
            SizedBox(width: 10.w),
            Text(
              title,
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),

        SizedBox(height: 12.h),

        ExpandableText(
          text: content,
          trimLines: 4,
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
            color: AppColors.text,
            fontSize: 13.5.sp,
            height: 1.4,
          ),
        ),
      ],
    ),
  );
}

class ExpandableText extends StatefulWidget {
  final String text;
  final int trimLines;
  final TextStyle? style;

  const ExpandableText({
    super.key,
    required this.text,
    this.trimLines = 4,
    this.style,
  });

  @override
  // ignore: library_private_types_in_public_api
  _ExpandableTextState createState() => _ExpandableTextState();
}

class _ExpandableTextState extends State<ExpandableText> {
  bool expanded = false;
  late String firstPart;
  late String secondPart;

  @override
  void initState() {
    super.initState();

    final span = TextSpan(text: widget.text);
    final tp = TextPainter(
      text: span,
      maxLines: widget.trimLines,
      textDirection: TextDirection.ltr,
    )..layout(maxWidth: double.infinity);

    // If text overflows, split it
    if (tp.didExceedMaxLines) {
      int endIndex = tp
          .getPositionForOffset(Offset(tp.width, tp.height))
          .offset;

      firstPart = widget.text.substring(0, endIndex);
      secondPart = widget.text.substring(endIndex, widget.text.length);
    } else {
      firstPart = widget.text;
      secondPart = "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AnimatedCrossFade(
          firstChild: Text(firstPart.trim(), style: widget.style),
          secondChild: Text(
            (firstPart + secondPart).trim(),
            style: widget.style,
          ),
          crossFadeState: expanded
              ? CrossFadeState.showSecond
              : CrossFadeState.showFirst,
          duration: Duration(milliseconds: 250),
        ),

        if (secondPart.isNotEmpty)
          GestureDetector(
            onTap: () => setState(() => expanded = !expanded),
            child: Padding(
              padding: EdgeInsets.only(top: 6.h),
              child: Text(
                expanded ? "Show less" : "Read more",
                style: Theme.of(context).textTheme.titleSmall!.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w600,
                  fontSize: 13.sp,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
