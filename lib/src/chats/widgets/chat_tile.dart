import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hicoach_coach/core/constants/colors.dart';
import 'package:hicoach_coach/models/chat.dart';
import 'package:hicoach_coach/src/chats/controller/chats_controller.dart';
import 'package:hicoach_coach/src/chats/view/messages_view.dart';

class ChatTile extends GetView<ChatController> {
  const ChatTile({
    super.key,
    required this.chatUser,
    required this.chat,
    required this.isCoach,
  });

  final dynamic chatUser;
  final ChatRoom chat;
  final bool isCoach;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return ListTile(
      contentPadding: EdgeInsets.zero,
      onTap: () =>
          Get.to(() => MessagesView(chatUser: chatUser, chatRoom: chat)),
      leading: CircleAvatar(
        radius: 20.r,
        backgroundImage: NetworkImage(
          !isCoach ? chatUser.profileURL.first : chatUser.profileUrls.first,
        ),
      ),
      title: Text(
        chatUser.fullName,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: textTheme.titleLarge,
      ),
      subtitle: Text(
        chat.lastMessage.isNotEmpty
            ? chat.lastMessage
            : 'Start conversation with ${chatUser.fullName.split(' ')[0]}',
        style: textTheme.titleSmall!.copyWith(
          color: chat.lastMessage.isEmpty ? AppColors.primary : Colors.black54,
          fontSize: 12.sp,
          fontWeight: FontWeight.normal,
        ),

        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            controller.formatInstagramChatTimestamp(chat.createdAt),
            style: textTheme.titleSmall!.copyWith(
              fontSize: 12.sp,
              color: Colors.grey[600],
            ),
          ),
          if (chat.unreadCount > 0) ...[
            Container(
              padding: const EdgeInsets.all(6),
              decoration: const BoxDecoration(
                color: AppColors.primary,
                shape: BoxShape.circle,
              ),
              child: Text(
                chat.unreadCount > 4 ? "4+" : '${chat.unreadCount}',
                style: textTheme.titleSmall!.copyWith(color: Colors.white),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
