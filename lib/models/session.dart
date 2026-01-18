class SessionModel {
  final String id;
  final DateTime? sessionDate; // nullable
  final String slot;
  final String status; // pending, completed, etc.
  final String? attendance; // nullable

  SessionModel({
    required this.id,
    required this.sessionDate,
    required this.slot,
    required this.status,
    required this.attendance,
  });

  factory SessionModel.fromJson(Map<String, dynamic> json) {
    return SessionModel(
      id: json["_id"],
      sessionDate: json["sessionDate"] == null
          ? null
          : DateTime.parse(json["sessionDate"]),
      slot: json["slot"] ?? "",
      status: json["status"] ?? "pending",
      attendance: json["attendance"],
    );
  }

  Map<String, dynamic> toJson() => {
    "_id": id,
    "sessionDate": sessionDate?.toIso8601String(),
    "slot": slot,
    "status": status,
    "attendance": attendance,
  };
}
