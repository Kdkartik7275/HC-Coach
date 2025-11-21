import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hicoach_coach/core/constants/colors.dart';

class DraggableFAB extends StatefulWidget {
  final VoidCallback onPressed;
  final Widget child;

  const DraggableFAB({
    super.key,
    required this.onPressed,
    required this.child,
  });

  @override
  State<DraggableFAB> createState() => _DraggableFABState();
}

class _DraggableFABState extends State<DraggableFAB> {
  double posX = 180.w;
  double posY = 600.h;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: posX,
      top: posY,
      child: GestureDetector(
        onPanUpdate: (details) {
          setState(() {
            posX += details.delta.dx;
            posY += details.delta.dy;
          });
        },
        child: FloatingActionButton.extended(
          onPressed: widget.onPressed,
          backgroundColor: AppColors.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          label: widget.child,
        ),
      ),
    );
  }
}
