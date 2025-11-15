class Review {
  final String coachId;
  final String userId;
  final String userName;
  final String? userProfileUrl;
  final double rating;
  final String? content;
  final DateTime createdAt;

  Review({
    required this.coachId,
    required this.userId,
    required this.userName,
    this.userProfileUrl,
    required this.rating,
    this.content,
    required this.createdAt,
  });

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      coachId: json['coachId'] ?? '',
      userId: json['userId'] ?? '',
      userName: json['userName'] ?? '',
      userProfileUrl: json['userProfileUrl'],
      rating: (json['rating'] is int)
          ? (json['rating'] as int).toDouble()
          : (json['rating'] ?? 0.0).toDouble(),
      content: json['content'],
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'])
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'coachId': coachId,
      'userId': userId,
      'userName': userName,
      'userProfileUrl': userProfileUrl,
      'rating': rating,
      'content': content,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  Review copyWith({
    String? coachId,
    String? userId,
    String? userName,
    String? userProfileUrl,
    double? rating,
    String? content,
    DateTime? createdAt,
  }) {
    return Review(
      coachId: coachId ?? this.coachId,
      userId: userId ?? this.userId,
      userName: userName ?? this.userName,
      userProfileUrl: userProfileUrl ?? this.userProfileUrl,
      rating: rating ?? this.rating,
      content: content ?? this.content,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
