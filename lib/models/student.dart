import 'dart:convert';

class Student {
  final String userId;
  final String email;
  final String fullName;
  final String phone;
  final String bio;
  String? gender;
  String? userType;
  List<String>? profileUrls;
  String? dateOfBirth;
  final List<String> sports;
  List<String>? favouriteCoaches;

  final DateTime? createdAt;
  final DateTime? updatedAt;

  Student({
    required this.userId,
    required this.email,
    required this.fullName,
    required this.phone,
    required this.bio,
    this.gender,
    this.userType,
    this.profileUrls,
    this.dateOfBirth,
    required this.sports,
    this.favouriteCoaches,
    this.createdAt,
    this.updatedAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'email': email,
      'fullName': fullName,
      'phone': phone,
      'bio': bio,
      'gender': gender,
      'userType': userType,
      'profileUrls': profileUrls,
      'dateOfBirth': dateOfBirth,
      'sports': sports,
      'favouriteCoaches': favouriteCoaches,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }

  factory Student.fromMap(Map<String, dynamic> map) {
    return Student(
      userId: map['userId'] as String,
      email: map['email'] as String,
      fullName: map['fullName'] as String,
      phone: map['phone'] as String,
      bio: map['bio'] as String,
      gender: map['gender'] as String?,
      userType: map['userType'] as String?,
      profileUrls: (map['profileUrls'] as List<dynamic>?)?.cast<String>() ?? [],
      dateOfBirth: map['dateOfBirth'] as String?,
      sports: (map['sports'] as List<dynamic>).cast<String>(),
      favouriteCoaches:
          (map['favouriteCoaches'] as List<dynamic>?)?.cast<String>() ?? [],
      createdAt: map['createdAt'] != null
          ? DateTime.tryParse(map['createdAt'])
          : null,
      updatedAt: map['updatedAt'] != null
          ? DateTime.tryParse(map['updatedAt'])
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Student.fromJson(String source) =>
      Student.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Student(userId: $userId, email: $email, fullName: $fullName, phone: $phone, bio: $bio, gender: $gender, userType: $userType, profileUrls: $profileUrls, dateOfBirth: $dateOfBirth, sports: $sports, createdAt: $createdAt, updatedAt: $updatedAt)';
  }
}
