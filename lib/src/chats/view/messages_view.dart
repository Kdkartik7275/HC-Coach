// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hicoach_coach/common/containers/rounded_container.dart';
import 'package:hicoach_coach/common/dialogs/info_dialog.dart';
import 'package:hicoach_coach/common/indicators/progress_indicators.dart';
import 'package:hicoach_coach/core/constants/colors.dart';
import 'package:hicoach_coach/models/chat.dart';
import 'package:hicoach_coach/models/message.dart';
import 'package:hicoach_coach/src/chats/controller/chats_controller.dart';
import 'package:hicoach_coach/src/chats/widgets/chat_appbar.dart';
import 'package:hicoach_coach/src/chats/widgets/chat_error_widget.dart';
import 'package:hicoach_coach/src/chats/widgets/empty_chat.dart';
import 'package:hicoach_coach/src/chats/widgets/message_bubble.dart';
import 'package:hicoach_coach/src/profile/controller/profile_controller.dart';

import 'package:loading_overlay/loading_overlay.dart';

class MessagesView extends StatefulWidget {
  const MessagesView({
    super.key,
    required this.chatUser,
    required this.chatRoom,
  });

  final dynamic chatUser;
  final ChatRoom chatRoom;

  @override
  State<MessagesView> createState() => _MessagesViewState();
}

class _MessagesViewState extends State<MessagesView> {
  bool isTyping = false;
  final controller = Get.find<ChatController>();
  final currentUser = Get.find<ProfileController>().user;
  final TextEditingController _messageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    controller.currentChatRoomId.value = widget.chatRoom.id;

    controller.getMessages(controller.currentChatRoomId.value).then((_) {
      controller.markChatAsRead(controller.currentChatRoomId.value);

      WidgetsBinding.instance.addPostFrameCallback((_) {
        controller.scrollToBottom();
      });
    });
  }

  @override
  void dispose() {
    _messageController.dispose();
    controller.currentChatRoomId.value = "";
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildChatAppBar(
        context,
        widget.chatRoom.id,
        widget.chatUser.userType == 'Coach'
            ? widget.chatUser.profileURL.first
            : widget.chatUser.profileUrls.first,
        widget.chatUser.fullName,
        isTyping,
        onProfileTap: () {
          if (widget.chatUser.userType == 'Student') {}
        },
        onCallTap: () {
          showInfoDialog("Call feature is not available for now");
        },
      ),
      body: Obx(() {
        final messagesMap = controller.messages.value;
        final List<MessageModel> messageList =
            messagesMap[widget.chatRoom.id] ?? [];

        return LoadingOverlay(
          isLoading: controller.messagesLoading.value,
          progressIndicator: circularProgress(context),
          color: Colors.transparent,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: controller.errorMessage.value.isNotEmpty
                ? buildErrorWidget(() {})
                : Column(
                    children: [
                      const Divider(height: 1, color: AppColors.filled),
                      Expanded(
                        child:
                            !controller.messagesLoading.value &&
                                messageList.isEmpty
                            ? EmptyChat(fullName: widget.chatUser.fullName)
                            : ListView.builder(
                                controller: controller.scrollController.value,
                                itemCount: messageList.length,
                                itemBuilder: (context, index) {
                                  final message = messageList[index];
                                  return MessageBubble(
                                    isMe:
                                        message.senderId == currentUser!.userId,
                                    message: message.content,
                                    time: controller.formatTime(
                                      message.timestamp,
                                    ),
                                  );
                                },
                              ),
                      ),
                      _buildMessageInput(),
                      SizedBox(height: 10.h),
                    ],
                  ),
          ),
        );
      }),
    );
  }

  Widget _buildMessageInput() {
    return SafeArea(
      top: false,
      child: Container(
        color: Colors.white,
        margin: EdgeInsets.only(bottom: 14.h),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: _messageController,
                keyboardType: TextInputType.multiline,

                textInputAction: TextInputAction.newline,
                onChanged: (value) {
                  if (value.isEmpty) {
                    controller.stopTyping(widget.chatRoom.id);
                  } else {
                    controller.startTyping(widget.chatRoom.id);
                  }
                },
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 15),
                  fillColor: AppColors.white,
                  filled: true,

                  hintText: 'Type your message',
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(color: AppColors.border),
                    borderRadius: BorderRadius.circular(25.r),
                  ),
                ),
              ),
            ),
            SizedBox(width: 12.w),
            InkWell(
              onTap: () {
                if (_messageController.text.trim().isNotEmpty) {
                  controller.sendMessage(
                    widget.chatRoom.id,
                    _messageController.text,
                    'text',
                  );
                  _messageController.clear();
                  controller.stopTyping(widget.chatRoom.id);
                  controller.scrollToBottom();
                }
              },
              child: TRoundedContainer(
                height: 50.h,
                width: 45.w,
                radius: 12.r,
                backgroundColor: AppColors.primary,
                child: const Center(
                  child: Icon(Icons.send, color: AppColors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
