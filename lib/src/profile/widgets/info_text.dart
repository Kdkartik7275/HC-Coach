// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:hicoach_coach/src/profile/controller/profile_controller.dart';

// ignore: must_be_immutable
class InfoText extends StatelessWidget {
  const InfoText({
    super.key,
    required this.label,
    required this.index,
    required this.selectedIndex,
    required this.controller,
  });

  final String label;
  final int index;
  final int selectedIndex;
  final ProfileController controller;
  @override
  Widget build(BuildContext context) {
    final isSelected = index == selectedIndex;
    return Expanded(
      child: GestureDetector(
        onTap: () => controller.updateCoachInfoIndex(index),
        child: Center(
          child: AnimatedDefaultTextStyle(
            duration: const Duration(milliseconds: 180),
            curve: Curves.easeOut,
            style: Theme.of(context).textTheme.titleSmall!.copyWith(
              fontSize: 14.sp,
              fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
              color: isSelected ? Colors.black : Colors.grey,
            ),
            child: Text(label),
          ),
        ),
      ),
    );
  }
}
