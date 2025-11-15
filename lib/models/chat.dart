import 'dart:convert';

class ChatRoom {
  final String id;
  final List<String> members;
  String lastMessage;
  int unreadCount;
  DateTime createdAt;

  ChatRoom({
    required this.id,
    required this.members,
    required this.lastMessage,
    required this.unreadCount,
    required this.createdAt,
  });

  factory ChatRoom.fromJson(Map<String, dynamic> json) {
    return ChatRoom(
      id: json['_id'] ?? '',
      members: List<String>.from(json['members'] ?? []),
      lastMessage: json['message'] ?? '',
      unreadCount: json['unreadCount'] ?? 0,
      createdAt: DateTime.parse(json['createdAt'] ?? DateTime.now()),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "members": members,
      "message": lastMessage,
      "unreadCount": unreadCount,
      "createdAt": createdAt.toIso8601String(),
    };
  }

  static ChatRoom fromJsonString(String str) =>
      ChatRoom.fromJson(json.decode(str));

  String toJsonString() => json.encode(toJson());
}
