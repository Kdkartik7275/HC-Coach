import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:hicoach_coach/models/chat.dart';
import 'package:hicoach_coach/models/coach.dart';
import 'package:hicoach_coach/models/message.dart';
import 'package:hicoach_coach/services/chats/chats_services.dart';
import 'package:hicoach_coach/services/profile/profile_service.dart';
import 'package:hicoach_coach/src/profile/controller/profile_controller.dart';
import 'package:intl/intl.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

class ChatController extends GetxController {
  var chatsLoading = false.obs;
  var messagesLoading = false.obs;
  var chats = Rx<List<ChatRoom>>([]);
  var messages = Rx<Map<String, List<MessageModel>>>({});
  var coaches = Rx<List<Coach>>([]);

  var scrollController = Rx<ScrollController>(ScrollController());

  Map<String, dynamic> userCache = {};

  final _services = ChatsService();
  final user = Get.find<ProfileController>().user;
  late io.Socket socket;
  var usersTypingStatus = Rx<Map<String, bool>>({});
  // var isTyping = false.obs;
  var typingUserId = "".obs;
  var errorMessage = "".obs;
  var currentChatRoomId = "".obs;
  var unreadChatsCount = 0.obs;

  final ProfileService profileService = ProfileService();
  final storage = const FlutterSecureStorage();

  @override
  void onInit() {
    super.onInit();
    getChats();
    connectSocket();
  }

  @override
  void onClose() {
    scrollController.value.dispose();
    super.onClose();
  }

  // Fetch chats from API
  Future<void> getChats() async {
    try {
      chatsLoading.value = true;
      final data = await _services.getUserChatList(user!.userId);
      chats.value = data;
      usersTypingStatus.value = {for (var chat in chats.value) chat.id: false};

      updateUnreadChatsCount();
    } catch (e) {
      debugPrint("Error fetching chats: $e");
    } finally {
      chatsLoading.value = false;
    }
  }

  String getOtherUserId(String myId, List<String> userIds) {
    if (userIds.length != 2) {
      throw ArgumentError("The list must contain exactly two user IDs.");
    }
    return userIds.firstWhere((id) => id != myId);
  }

  void connectSocket() async {
    final token = await storage.read(key: "token");

    socket = io.io(dotenv.env['CHAT_SOCKET_URL'], <String, dynamic>{
      "transports": ["websocket"],
      "autoConnect": false,
      "auth": {"token": token},
    });

    socket.connect();

    socket.onConnect((_) {
      socket.emit("join");
      debugPrint("User connected to the socket");
    });

    socket.on("receiveMessage", (data) {
      final message = MessageModel.fromJson(data);

      messages.value.putIfAbsent(message.chatRoomId, () => []).add(message);

      messages.refresh();

      final chat = chats.value.firstWhereOrNull(
        (chat) => chat.id == message.chatRoomId,
      );
      if (chat != null) {
        chat.createdAt = message.timestamp;
        chat.lastMessage = message.content;
        chat.unreadCount = chat.unreadCount + 1;

        chats.refresh();
        if (currentChatRoomId.value == message.chatRoomId) {
          scrollToBottom();
          FlutterRingtonePlayer().playNotification();
          markChatAsRead(currentChatRoomId.value);
        }
        updateUnreadChatsCount();
      }
      if (currentChatRoomId.value == "" ||
          currentChatRoomId.value != message.chatRoomId) {
        // NotificationService.showBasicNotification(
        //     id: message.id.hashCode,
        //     title: "New Message",
        //     body: message.content);
      }
    });

    socket.on("userTyping", (data) {
      String chatRoomId = data['chatRoomId'];

      if (usersTypingStatus.value.containsKey(chatRoomId)) {
        usersTypingStatus.value[chatRoomId] = true;
        usersTypingStatus.refresh();
      }
    });

    socket.on("userStoppedTyping", (data) {
      String chatRoomId = data['chatRoomId'];

      if (usersTypingStatus.value.containsKey(chatRoomId)) {
        usersTypingStatus.value[chatRoomId] = false;
        usersTypingStatus.refresh();
      }
    });

    socket.on("messagesRead", (data) {
      markMessagesAsRead(data['chatRoomId']);
      final chat = chats.value.firstWhereOrNull(
        (chat) => chat.id == data["chatRoomId"],
      );
      if (chat != null) {
        chat.unreadCount = 0;
        chats.refresh();
      }
    });
  }

  void sendMessage(
    String chatRoomId,
    String content,
    String messageType, {
    String? mediaUrl,
  }) {
    String messageTime = DateTime.now().toIso8601String();
    MessageModel newMessage = MessageModel(
      id: "",
      chatRoomId: chatRoomId,
      senderId: user!.userId,
      content: content,
      timestamp: DateTime.parse(messageTime),
    );

    messages.value[chatRoomId]?.add(newMessage);
    messages.refresh();

    socket.emit("sendMessage", {
      "chatRoomId": chatRoomId,
      "senderId": user!.userId,
      "content": content,
      "messageType": messageType,
      "mediaUrl": mediaUrl ?? "",
      "timestamp": messageTime,
    });

    final chatIndex = chats.value.indexWhere(
      (chat) => chat.id == newMessage.chatRoomId,
    );
    if (chatIndex != -1) {
      final chat = chats.value.removeAt(chatIndex);
      chat.createdAt = newMessage.timestamp;
      chat.lastMessage = newMessage.content;

      chats.value.insert(0, chat);
      chats.refresh();
    }
  }

  void markChatAsRead(String chatRoomId) {
    socket.emit("markAsRead", {
      "chatRoomId": chatRoomId,
      "userId": user!.userId,
    });

    markMessagesAsRead(chatRoomId);

    final chat = chats.value.firstWhereOrNull((chat) => chat.id == chatRoomId);
    if (chat != null) {
      chat.unreadCount = 0;
      chats.refresh();
      updateUnreadChatsCount();
    }
  }

  void markMessagesAsRead(String chatRoomId) {
    if (messages.value.containsKey(chatRoomId)) {
      messages.value[chatRoomId] = messages.value[chatRoomId]!.map((msg) {
        if (msg.senderId != user!.userId) {
          msg.isRead = true;
        }
        return msg;
      }).toList();

      messages.refresh();
    }
  }

  void updateUnreadChatsCount() {
    final unreadChats = chats.value.where((chat) => chat.unreadCount != 0);
    unreadChatsCount.value = unreadChats.length;
    unreadChatsCount.refresh();
  }

  void startTyping(String chatRoomId) {
    socket.emit("typing", {"chatRoomId": chatRoomId, "userId": user!.userId});
  }

  void stopTyping(String chatRoomId) {
    socket.emit("stopTyping", {
      "chatRoomId": chatRoomId,
      "userId": user!.userId,
    });
  }

  Future<void> getMessages(String chatRoomId) async {
    try {
      errorMessage.value = "";
      messagesLoading.value = true;
      final data = await _services.getChatMessages(chatRoomId);
      messages.value[chatRoomId] = data;
    } catch (e) {
      errorMessage.value = e.toString();
      messagesLoading.value = false;
    } finally {
      messagesLoading.value = false;
    }
  }

  String formatInstagramChatTimestamp(DateTime dateTime) {
    final local = dateTime.toLocal();
    final now = DateTime.now();

    final today = DateTime(now.year, now.month, now.day);
    final messageDay = DateTime(local.year, local.month, local.day);

    final difference = today.difference(messageDay).inDays;

    // Today → 4:30 PM
    if (difference == 0) {
      return DateFormat('h:mm a').format(local);
    }

    // Yesterday
    if (difference == 1) {
      return 'Yesterday';
    }

    // Within last 7 days → Mon, Tue
    if (difference < 7) {
      return DateFormat('EEE').format(local); // Mon
    }

    // Same year → Nov 19
    if (local.year == now.year) {
      return DateFormat('MMM d').format(local);
    }

    // Older → Nov 19, 2024
    return DateFormat('MMM d, yyyy').format(local);
  }

  String formatTime(DateTime dateTime) {
    int hour = dateTime.hour;
    int minute = dateTime.minute;
    String period = hour >= 12 ? 'PM' : 'AM';

    String formattedTime = '$hour:${minute.toString().padLeft(2, '0')} $period';

    return formattedTime;
  }

  void scrollToBottom() {
    if (scrollController.value.hasClients) {
      scrollController.value.animateTo(
        scrollController.value.position.maxScrollExtent + 80,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }
}
