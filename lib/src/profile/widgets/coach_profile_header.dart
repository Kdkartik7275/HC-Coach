// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hicoach_coach/common/containers/rounded_container.dart';
import 'package:hicoach_coach/common/image/network_image.dart';
import 'package:hicoach_coach/common/preview/preview_image.dart';
import 'package:hicoach_coach/core/constants/colors.dart';
import 'package:hicoach_coach/models/coach.dart';
import 'package:hicoach_coach/src/profile/controller/profile_controller.dart';

class CoachProfileHeader extends StatefulWidget {
  const CoachProfileHeader({
    super.key,
    required this.coach,
    required this.controller,
    this.backRequired = false,
  });

  final Coach coach;
  final ProfileController controller;
  final bool backRequired;

  @override
  State<CoachProfileHeader> createState() => _CoachProfileHeaderState();
}

class _CoachProfileHeaderState extends State<CoachProfileHeader> {
  int currentIndex = 0;
 
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final height = size.height;
    final width = size.width;

    return SizedBox(
      height: height * 0.30,
      width: width,
      child: Stack(
        children: [
          // USER PROFILE IMAGES
          Swiper(
            pagination: const SwiperPagination(builder: SwiperPagination.rect),
            itemCount: widget.coach.profileURL?.length ?? 0,
            onIndexChanged: (index) => setState(() {
              currentIndex = index;
            }),
            itemBuilder: (context, index) {
              return TCachedNetworkImage(
                onTap: () =>
                    showImageOverlay(context, widget.coach.profileURL!),
                profileURL: widget.coach.profileURL![index],
                height: height * 0.28,
                radius: 0,
                width: width,
              );
            },
          ),

          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 120.h,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withOpacity(0.1),
                    Colors.black.withOpacity(0.4),
                  ],
                ),
              ),
            ),
          ),

          // USERNAME AND COACHING AREAS
          Positioned(
            bottom: 30,
            left: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.coach.fullName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(
                    context,
                  ).textTheme.headlineSmall!.copyWith(color: AppColors.white),
                ),
                ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: 300.w),
                  child: Wrap(
                    spacing: 10.0,
                    runSpacing: 5,
                    alignment: WrapAlignment.start,
                    children: List.generate(
                      widget.coach.coachingAreas?.length ?? 0,
                      (index) {
                        return TRoundedContainer(
                          padding: EdgeInsets.symmetric(horizontal: 8.w),
                          radius: 5.r,

                          child: Text(
                            widget.coach.coachingAreas![index].label,
                            textAlign: TextAlign.center,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(
                              context,
                            ).textTheme.titleSmall!.copyWith(fontSize: 12.sp,fontWeight: FontWeight.w400),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),

          // IMAGES INDEX
          Positioned(
            right: 0,
            bottom: 0,
            left: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                widget.coach.profileURL?.length ?? 0,
                (index) => AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  height: 10.h,
                  width: index == currentIndex ? 20.w : 10.w,
                  margin:  EdgeInsets.only(right: 10.w, bottom: 10.h),
                  decoration: BoxDecoration(
                    color:index == currentIndex ?AppColors.primary : Colors.transparent,
                    borderRadius: BorderRadius.circular(6.r),
                    
                    border: Border.all(
                      color: index == currentIndex
                          ? AppColors.primary
                          : AppColors.white,
                      width: index == currentIndex ? 2 : 1,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
