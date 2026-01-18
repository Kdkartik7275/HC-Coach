import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hicoach_coach/common/containers/rounded_container.dart';
import 'package:hicoach_coach/common/effects/shimmer.dart';
import 'package:hicoach_coach/common/indicators/progress_indicators.dart';
import 'package:hicoach_coach/core/constants/colors.dart';
import 'package:hicoach_coach/models/coach.dart';
import 'package:hicoach_coach/models/student.dart';
import 'package:hicoach_coach/src/chats/controller/chats_controller.dart';
import 'package:hicoach_coach/src/chats/widgets/chat_tile.dart';
import 'package:loading_overlay/loading_overlay.dart';

class ChatsView extends StatefulWidget {
  const ChatsView({super.key});

  @override
  State<ChatsView> createState() => _ChatsViewState();
}

class _ChatsViewState extends State<ChatsView> {
  final controller = Get.find<ChatController>();
  @override
  Widget build(BuildContext context) {
    final user = controller.user;
    bool isCoach = user!.userType == 'Coach';
    return Scaffold(
      body: Obx(() {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            children: [
              TRoundedContainer(
                padding: EdgeInsets.only(left: 15.w),
                margin: EdgeInsets.only(top: 10.h),
                height: 40.h,
                width: double.infinity,
                radius: 12.r,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    offset: Offset(1, 1),
                    blurRadius: 5.0,
                  ),
                ],
                child: Row(
                  children: [
                    const Icon(Icons.search, size: 16, color: AppColors.text),
                    SizedBox(width: 6.w),
                    Text(
                      'Search',
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: AppColors.text,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10.h),
              Expanded(
                child: RefreshIndicator(
                  backgroundColor: AppColors.white,
                  color: AppColors.primary,
                  onRefresh: () async {
                    await controller.getChats();
                  },
                  child: LoadingOverlay(
                    isLoading: controller.chatsLoading.value,
                    color: Colors.transparent,
                    progressIndicator: circularProgress(context),
                    child: ListView.separated(
                      itemCount: controller.chats.value.length,
                      itemBuilder: (context, index) {
                        final chat = controller.chats.value[index];
                        final otherUserId = controller.getOtherUserId(
                          user.userId,
                          chat.members,
                        );

                        if (controller.userCache.containsKey(otherUserId)) {
                          final chatUser = controller.userCache[otherUserId];
                          return ChatTile(
                            chatUser: chatUser,
                            chat: chat,
                            isCoach: isCoach,
                          );
                        } else {
                          return FutureBuilder<dynamic>(
                            future: !isCoach
                                ? controller.profileService.getCoachById(
                                    otherUserId,
                                  )
                                : controller.profileService.getStudentById(
                                    otherUserId,
                                  ),
                            builder: (context, AsyncSnapshot snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 8.0),
                                  child: TShimmerEffect(
                                    height: 80.h,
                                    width: double.infinity,
                                    radius: 20.r,
                                  ),
                                );
                              }
                              if (snapshot.hasData) {
                                dynamic chatUser = !isCoach
                                    ? snapshot.data as Coach
                                    : snapshot.data as Student;

                                controller.userCache[otherUserId] = chatUser;

                                return ChatTile(
                                  chatUser: chatUser,
                                  chat: chat,
                                  isCoach: isCoach,
                                );
                              } else if (snapshot.hasError) {
                                return Center(
                                  child: Text(snapshot.error.toString()),
                                );
                              } else {
                                return const SizedBox.shrink();
                              }
                            },
                          );
                        }
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return Divider(color: Colors.grey.shade100);
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
