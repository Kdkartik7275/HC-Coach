class TrainingProgram {
  final String? id;
  final String title;
  final String sport;
  final String level;
  final int durationDays;
  final int totalSessions;
  final int frequency;
  final double price;

  final List<String> slots;
  final List<String> learningOutcomes;
  final List<String> requirements;

  final String description;
  final String? thumbnailUrl;
  final String coachId;

  final DateTime? createdAt;
  final DateTime? updatedAt;

  TrainingProgram({
     this.id,
    required this.title,
    required this.sport,
    required this.level,
    required this.durationDays,
    required this.totalSessions,
    required this.frequency,
    required this.price,
    required this.slots,
    required this.learningOutcomes,
    required this.requirements,
    required this.description,
    this.thumbnailUrl,
    required this.coachId,
    this.createdAt,
    this.updatedAt,
  });

  // ------------------------ From JSON ------------------------
  factory TrainingProgram.fromJson(Map<String, dynamic> json) {
    return TrainingProgram(
      id: json['_id'] ?? "",
      title: json['title'] ?? "",
      sport: json['sport'] ?? "",
      level: json['level'] ?? "",
      durationDays: json['durationDays'] ?? 0,
      totalSessions: json['totalSessions'] ?? 0,
      frequency: json['frequency'] ?? 0,
      price: (json['price'] ?? 0).toDouble(),

      slots: List<String>.from(json['slots'] ?? []),
      learningOutcomes:
          List<String>.from(json['learningOutcomes'] ?? []),
      requirements: List<String>.from(json['requirements'] ?? []),

      description: json['description'] ?? "",
      thumbnailUrl: json['thumbnailUrl'],
      coachId: json['coachId'] ?? "",

      createdAt:
          json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      updatedAt:
          json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
    );
  }

  // ------------------------ To JSON ------------------------
  Map<String, dynamic> toJson() {
    return {
      "title": title,
      "sport": sport,
      "level": level,
      "durationDays": durationDays,
      "totalSessions": totalSessions,
      "frequency": frequency,
      "price": price,
      "slots": slots,
      "learningOutcomes": learningOutcomes,
      "requirements": requirements,
      "description": description,
      "thumbnailUrl": thumbnailUrl,
      "coachId": coachId,
    };
  }
}
