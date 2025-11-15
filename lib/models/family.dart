// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Family {
  final String fullName;
  final String dob;
  Family({
    required this.fullName,
    required this.dob,
  });

  Family copyWith({
    String? fullName,
    String? dob,
  }) {
    return Family(
      fullName: fullName ?? this.fullName,
      dob: dob ?? this.dob,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'fullName': fullName,
      'dob': dob,
    };
  }

  factory Family.fromMap(Map<String, dynamic> map) {
    return Family(
      fullName: map['fullName'] as String,
      dob: map['dob'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Family.fromJson(String source) =>
      Family.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Family(fullName: $fullName, dob: $dob)';

  @override
  bool operator ==(covariant Family other) {
    if (identical(this, other)) return true;

    return other.fullName == fullName && other.dob == dob;
  }

  @override
  int get hashCode => fullName.hashCode ^ dob.hashCode;
}
