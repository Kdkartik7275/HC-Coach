class MessageModel {
  final String id;
  final String chatRoomId;
  final String senderId;
  final String content;
  final String mediaUrl;
  final String messageType;
  final DateTime timestamp;
  bool isRead;

  MessageModel({
    required this.id,
    required this.chatRoomId,
    required this.senderId,
    required this.content,
    this.mediaUrl = "",
    this.messageType = "text",
    required this.timestamp,
    this.isRead = false,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      id: json['_id'] ?? '',
      chatRoomId: json['chatRoomId'] ?? '',
      senderId: json['senderId'] ?? '',
      content: json['content'] ?? '',
      mediaUrl: json['mediaUrl'] ?? '',
      messageType: json['messageType'] ?? 'text',
      timestamp:
          DateTime.parse(json['timestamp'] ?? DateTime.now().toIso8601String()),
      isRead: json['isRead'] ?? false,
    );
  }
}
