import "package:hicoach_coach/models/training_program_model.dart";

import "session.dart";

import "payment_model.dart";

class EnrollmentModel {
  final String id;
  final String studentId;
  final String coachId;
  final TrainingProgram program;
  final DateTime startDate;
  final DateTime endDate;
  final String enrollmentStatus; // active, completed, cancelled
  final String? cancellationReason;
  final List<SessionModel> sessions;
  final PaymentModel payment;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  EnrollmentModel({
    required this.id,
    required this.studentId,
    required this.coachId,
    required this.program,
    required this.startDate,
    required this.endDate,
    required this.enrollmentStatus,
    this.cancellationReason,
    required this.sessions,
    required this.payment,
    this.createdAt,
    this.updatedAt
  });

  factory EnrollmentModel.fromJson(Map<String, dynamic> json) {
    return EnrollmentModel(
      id: json["_id"],
      studentId: json["studentId"],
      coachId: json["coachId"],
      program: TrainingProgram.fromJson(json["programId"]),
      startDate: DateTime.parse(json["startDate"]),
      endDate: DateTime.parse(json["endDate"]),
      enrollmentStatus: json["enrollmentStatus"],
      cancellationReason: json["cancellationReason"],
      sessions: (json["sessions"] as List<dynamic>)
          .map((e) => SessionModel.fromJson(e))
          .toList(),
      payment: PaymentModel.fromJson(json["payment"]),
      createdAt: json["createdAt"] != null ? DateTime.parse(json["createdAt"]) : null,
      updatedAt: json["updatedAt"] != null ? DateTime.parse(json["updatedAt"]) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "_id": id,
      "studentId": studentId,
      "coachId": coachId,
      "programId": program,
      "startDate": startDate.toIso8601String(),
      "endDate": endDate.toIso8601String(),
      "enrollmentStatus": enrollmentStatus,
      "cancellationReason": cancellationReason,
      "sessions": sessions.map((e) => e.toJson()).toList(),
      "payment": payment.toJson(),
    };
  }
}