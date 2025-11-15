import 'dart:convert';

import 'package:hicoach_coach/models/coaching_area.dart';
import 'package:hicoach_coach/models/package.dart';
import 'package:hicoach_coach/models/pricing.dart';
import 'package:hicoach_coach/models/timings.dart';

class Coach {
  final String userId;
  String email;
  String fullName;
  String phone;
  String bio;
  String? gender;
  String? userType;
  List<String>? profileURL;
  String? dob;
  List sports;
  List<CoachingArea>? coachingAreas;
  String? playingExperience;
  String? coachingExperience;
  List? certifications;
  List<Timings>? timings;
  List<Pricing>? pricings;
  List<Package>? packages;
  List<String>? favouriteStudents;

  Coach(
      {required this.userId,
      required this.email,
      required this.fullName,
      required this.phone,
      required this.bio,
      this.gender,
      this.userType,
      this.profileURL,
      this.dob,
      required this.sports,
      this.coachingAreas,
      this.playingExperience,
      this.coachingExperience,
      this.certifications,
      this.pricings,
      this.packages,
      this.timings,
      this.favouriteStudents});

  void updateCoachField(Map<String, dynamic> updatedFields) {
    updatedFields.forEach((key, value) {
      switch (key) {
        case 'email':
          email = value;
          break;
        case 'fullName':
          fullName = value;
          break;
        case 'phone':
          phone = value;
          break;
        case 'bio':
          bio = value;
          break;
        case 'gender':
          gender = value;
          break;
        case 'userType':
          userType = value;
          break;
        case 'profileURL':
          profileURL = List<String>.from(value);
          break;
        case 'dob':
          dob = value;
          break;
        case 'sports':
          sports = List<String>.from(value);
          break;

        case 'coachingAreas':
          coachingAreas = List<CoachingArea>.from(
              value.map((x) => CoachingArea.fromMap(x)));
          break;
        case 'playingExperience':
          playingExperience = value;
          break;
        case 'coachingExperience':
          coachingExperience = value;
          break;
        case 'certifications':
          certifications = List<String>.from(value);
          break;
        case 'timings':
          timings = List<Timings>.from(value.map((x) => Timings.fromMap(x)));
          break;
        case 'pricing':
          pricings = List<Pricing>.from(value.map((x) => Pricing.fromMap(x)));
          break;
        case 'package':
          packages = List<Package>.from(value.map((x) => Package.fromMap(x)));
          break;
      }
    });
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'email': email,
      'fullName': fullName,
      'phone': phone,
      'bio': bio,
      'gender': gender,
      'userType': userType,
      'profileURL': profileURL,
      'dob': dob,
      'sports': sports,
      'coachingAreas': coachingAreas != null
          ? coachingAreas!.map((x) => x.toMap()).toList()
          : [],
      'playingExperience': playingExperience,
      'coachingExperience': coachingExperience,
      'certifications': certifications,
      'timings': timings != null ? timings!.map((x) => x.toMap()).toList() : [],
      'pricing':
          pricings != null ? pricings!.map((x) => x.toMap()).toList() : [],
      'package':
          packages != null ? packages!.map((x) => x.toMap()).toList() : [],
      'favouriteStudents': favouriteStudents
    };
  }

  factory Coach.fromMap(Map<String, dynamic> map) {
    return Coach(
      userId: map['userId'] as String,
      email: map['email'] as String,
      fullName: map['fullName'] as String,
      phone: map['phone'] as String,
      bio: map['bio'] as String,
      gender: map['gender'],
      userType: map['userType'],
      profileURL:
          map['profileURL'] is List ? List<String>.from(map['profileURL']) : [],
      dob: map['dob'],
      sports: map['sports'] is List ? List<String>.from(map['sports']) : [],
      coachingAreas: map['coachingAreas'] is List
          ? List<CoachingArea>.from(
              map['coachingAreas'].map((x) => CoachingArea.fromMap(x)))
          : [],
      playingExperience: map['playingExperience'],
      coachingExperience: map['coachingExperience'],
      certifications: map['certifications'] is List
          ? List<String>.from(map['certifications'])
          : [],
      timings: map['timings'] is List
          ? List<Timings>.from(map['timings'].map((x) => Timings.fromMap(x)))
          : [],
      pricings: map['pricing'] is List
          ? List<Pricing>.from(map['pricing'].map((x) => Pricing.fromMap(x)))
          : [],
      packages: map['package'] is List
          ? List<Package>.from(map['package'].map((x) => Package.fromMap(x)))
          : [],
      favouriteStudents:
          (map['favouriteStudents'] as List<dynamic>?)?.cast<String>() ?? [],
    );
  }

  String toJson() => json.encode(toMap());

  factory Coach.fromJson(String source) => Coach.fromMap(json.decode(source));
}
