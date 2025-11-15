// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Invitation {
  final String id;
  final String classID;
  final String coachID;
  final String studentID;
  final bool isInvited;
  final int pax;

  Invitation({
    required this.id,
    required this.classID,
    required this.coachID,
    required this.studentID,
    required this.isInvited,
    required this.pax,
  });

  Invitation copyWith({
    String? id,
    String? classID,
    String? coachID,
    String? studentID,
    bool? isInvited,
    int? pax,
  }) {
    return Invitation(
      id: id ?? this.id,
      classID: classID ?? this.classID,
      coachID: coachID ?? this.coachID,
      studentID: studentID ?? this.studentID,
      isInvited: isInvited ?? this.isInvited,
      pax: pax ?? this.pax,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'classID': classID,
      'coachID': coachID,
      'studentID': studentID,
      'isInvited': isInvited,
      'pax': pax,
    };
  }

  factory Invitation.fromMap(Map<String, dynamic> map) {
    return Invitation(
      id: map['id'] as String,
      classID: map['classID'] as String,
      coachID: map['coachID'] as String,
      studentID: map['studentID'] as String,
      isInvited: map['isInvited'] as bool,
      pax: map['pax'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory Invitation.fromJson(String source) =>
      Invitation.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Invitation(id: $id, classID: $classID, coachID: $coachID, studentID: $studentID, isInvited: $isInvited, pax: $pax)';
  }

  @override
  bool operator ==(covariant Invitation other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.classID == classID &&
        other.coachID == coachID &&
        other.studentID == studentID &&
        other.isInvited == isInvited &&
        other.pax == pax;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        classID.hashCode ^
        coachID.hashCode ^
        studentID.hashCode ^
        isInvited.hashCode ^
        pax.hashCode;
  }
}
