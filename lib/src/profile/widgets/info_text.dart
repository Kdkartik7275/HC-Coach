import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// ignore: must_be_immutable
class InfoText extends StatelessWidget {
  InfoText({
    super.key,
    required this.label,
    required this.isSelected,
    this.onpressed,
  });

  final String label;
  Function()? onpressed;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onpressed,
      child: Text(label,
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
              fontSize: 18.sp,
              decoration: isSelected ? TextDecoration.underline : null)),
    );
  }
}
