import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hicoach_coach/core/constants/app_apis.dart';
import 'package:hicoach_coach/models/chat.dart';
import 'package:hicoach_coach/models/message.dart';
import 'package:http/http.dart' as http;

class ChatsService {
  final storage = const FlutterSecureStorage();
  Future<ChatRoom?> createChatRoom(String studentId, String coachId) async {
    try {
      final token = await storage.read(key: "token");
      final url = Uri.parse(AppApis.createChatRoom);

      final response = await http.post(
        url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
        body: jsonEncode({"studentId": studentId, "coachId": coachId}),
      );
      print(response.body);
      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        return ChatRoom.fromJson(jsonData);
      }
      return null;
    } catch (e) {
     
      throw e.toString();
    }
  }

  Future<List<ChatRoom>> getUserChatList(String userId) async {
    try {
      final token = await storage.read(key: "token");
      final url = Uri.parse(AppApis.getChatList(userId));

      final response = await http.get(
        url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        final jsonData = jsonDecode(response.body);
        List<ChatRoom> chats = [];
        for (var chat in jsonData) {
          final room = ChatRoom.fromJson(chat);
          chats.add(room);
        }
        return chats;
      }
      return [];
    } catch (e) {
      throw e.toString();
    }
  }

  Future<List<MessageModel>> getChatMessages(String chatId) async {
    try {
      final token = await storage.read(key: "token");
      final url = Uri.parse(AppApis.getChatMessages(chatId));

      final response = await http.get(
        url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        final jsonData = jsonDecode(response.body);
        List<MessageModel> messages = [];
        for (var message in jsonData) {
          final msg = MessageModel.fromJson(message);
          messages.add(msg);
        }
        return messages;
      }
      return [];
    } catch (e) {
      throw e.toString();
    }
  }
}
