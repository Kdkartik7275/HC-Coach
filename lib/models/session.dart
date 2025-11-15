// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:hicoach_coach/models/coaching_area.dart';

class Session {
  final String id;
  final String coachID;
  final String coachName;
  final String coachProfileUrl;
  final CoachingArea location;
  final String sport;
  final DateTime startTime;
  final DateTime endTime;
  final String repeat;
  final int pax;
  final int amount;
  final bool isInvitation;
  final bool isCanceled;
  final List<Map<String, dynamic>> students;
  final List studentIDs;
  Session({
    required this.id,
    required this.coachID,
    required this.coachName,
    required this.coachProfileUrl,
    required this.location,
    required this.sport,
    required this.startTime,
    required this.endTime,
    required this.repeat,
    required this.pax,
    required this.amount,
    required this.isInvitation,
    required this.isCanceled,
    required this.students,
    required this.studentIDs,
  });

  Session copyWith({
    String? id,
    String? coachID,
    String? coachName,
    String? coachProfileUrl,
    CoachingArea? location,
    String? sport,
    DateTime? startTime,
    DateTime? endTime,
    String? repeat,
    int? pax,
    int? amount,
    bool? isInvitation,
    bool? isCanceled,
    List<Map<String, dynamic>>? students,
    List? studentIDs,
  }) {
    return Session(
      id: id ?? this.id,
      coachID: coachID ?? this.coachID,
      coachName: coachName ?? this.coachName,
      coachProfileUrl: coachProfileUrl ?? this.coachProfileUrl,
      location: location ?? this.location,
      sport: sport ?? this.sport,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      repeat: repeat ?? this.repeat,
      pax: pax ?? this.pax,
      amount: amount ?? this.amount,
      isInvitation: isInvitation ?? this.isInvitation,
      isCanceled: isCanceled ?? this.isCanceled,
      students: students ?? this.students,
      studentIDs: studentIDs ?? this.studentIDs,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'coachID': coachID,
      'coachName': coachName,
      'coachProfileUrl': coachProfileUrl,
      'location': location.toMap(),
      'sport': sport,
      'startTime': startTime.toUtc().toIso8601String(),
      'endTime': endTime.toUtc().toIso8601String(),
      'repeat': repeat,
      'pax': pax,
      'amount': amount,
      'students': students,
      'studentIDs': studentIDs,
      'isInvitation': isInvitation,
      'isCanceled': isCanceled
    };
  }

  factory Session.fromMap(Map<String, dynamic> map) {
    return Session(
      id: map['id'] as String,
      coachID: map['coachID'] as String,
      coachName: map['coachName'] as String,
      coachProfileUrl: map['coachProfileUrl'] as String,
      location: CoachingArea.fromMap(map['location'] as Map<String, dynamic>),
      sport: map['sport'] as String,
      startTime: DateTime.parse(map['startTime']).toLocal(),
      endTime: DateTime.parse(map['endTime']).toLocal(),
      repeat: map['repeat'] as String,
      pax: map['pax'] as int,
      amount: map['amount'] as int,
      isInvitation: map['isInvitation'] as bool,
      isCanceled: map['isCanceled'] as bool,
      students: List<Map<String, dynamic>>.from(
        map['students'] as List<dynamic>,
      ),
      studentIDs: map['studentIDs'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Session.fromJson(String source) =>
      Session.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Session(id: $id, coachID: $coachID, coachName: $coachName, location: $location, sport: $sport, startTime: $startTime, endTime: $endTime, repeat: $repeat, pax: $pax, amount: $amount, students: $students)';
  }

  @override
  bool operator ==(covariant Session other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.coachID == coachID &&
        other.coachName == coachName &&
        other.location == location &&
        other.sport == sport &&
        other.startTime == startTime &&
        other.endTime == endTime &&
        other.repeat == repeat &&
        other.pax == pax &&
        other.amount == amount &&
        listEquals(other.students, students);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        coachID.hashCode ^
        coachName.hashCode ^
        location.hashCode ^
        sport.hashCode ^
        startTime.hashCode ^
        endTime.hashCode ^
        repeat.hashCode ^
        pax.hashCode ^
        amount.hashCode ^
        students.hashCode;
  }
}
