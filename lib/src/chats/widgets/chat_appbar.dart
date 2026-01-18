import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:hicoach_coach/core/constants/colors.dart';
import 'package:hicoach_coach/src/chats/controller/chats_controller.dart';

AppBar buildChatAppBar(
  BuildContext context,
  String chatId,
  String profileUrl,
  String fullName,
  bool isTyping, {
  required Function() onProfileTap,
  required Function() onCallTap,
}) {
  final chatController = Get.find<ChatController>();
  final textTheme = Theme.of(context).textTheme;

  return AppBar(
    toolbarHeight: 72,
    backgroundColor: Colors.white,
    elevation: 1,
    centerTitle: false,
    automaticallyImplyLeading: false,
    titleSpacing: 0,
    title: Row(
      children: [
        // 🔙 Back Button
        IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black87),
        ),

        // 🧑‍ Avatar + Name + Typing
        Expanded(
          child: GestureDetector(
            onTap: onProfileTap,
            child: Row(
              children: [
                CircleAvatar(
                  radius: 20.r,
                  backgroundColor: AppColors.primary.withOpacity(0.2),
                  backgroundImage: profileUrl.isNotEmpty
                      ? NetworkImage(profileUrl)
                      : null,
                  child: profileUrl.isEmpty
                      ? const Icon(Icons.person, color: AppColors.primary)
                      : null,
                ),
                const SizedBox(width: 10),

                // Name + typing indicator
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        fullName,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style:textTheme.titleLarge,
                      ),
                      const SizedBox(height: 2),
                      Obx(() {
                        bool typing = chatController.usersTypingStatus.value[chatId] ?? false;
                        if (typing) {
                          return Row(
                            mainAxisSize: MainAxisSize.min,
                            children: const [
                              SpinKitThreeBounce(
                                color: Colors.grey,
                                size: 8,
                                duration: Duration(milliseconds: 800),
                              ),
                              SizedBox(width: 4),
                              Text(
                                "typing...",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                            ],
                          );
                        } else {
                          return const SizedBox.shrink();
                        }
                      }),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ),

    // 📞 Action Buttons
    actions: [
      IconButton(
        onPressed: onCallTap,
        icon: const Icon(Icons.call_outlined, color: AppColors.primary),
      ),
      IconButton(
        onPressed: () {},
        icon: const Icon(Icons.more_vert_rounded, color: AppColors.primary),
      ),
    ],
  );
}
