// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class CoachingArea {
  final String label;
  final double latitude;
  final double longitude;
  CoachingArea({
    required this.label,
    required this.latitude,
    required this.longitude,
  });

  CoachingArea copyWith({
    String? label,
    double? latitude,
    double? longitude,
  }) {
    return CoachingArea(
      label: label ?? this.label,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'label': label,
      'latitude': latitude,
      'longitude': longitude,
    };
  }

  factory CoachingArea.fromMap(Map<String, dynamic> map) {
    return CoachingArea(
      label: map['label'] as String,
      latitude: map['latitude'] as double,
      longitude: map['longitude'] as double,
    );
  }

  String toJson() => json.encode(toMap());

  factory CoachingArea.fromJson(String source) =>
      CoachingArea.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'CoachingArea(label: $label, latitude: $latitude, longitude: $longitude)';

  @override
  bool operator ==(covariant CoachingArea other) {
    if (identical(this, other)) return true;

    return other.label == label &&
        other.latitude == latitude &&
        other.longitude == longitude;
  }

  @override
  int get hashCode => label.hashCode ^ latitude.hashCode ^ longitude.hashCode;
}
