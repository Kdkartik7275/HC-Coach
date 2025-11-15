// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class PlaceModel {
  final String description;
  final String placeID;
  final List types;

  PlaceModel({
    required this.description,
    required this.placeID,
    required this.types,
  });

  PlaceModel copyWith({
    String? description,
    String? placeID,
    List? types,
  }) {
    return PlaceModel(
      description: description ?? this.description,
      placeID: placeID ?? this.placeID,
      types: types ?? this.types,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'description': description,
      'placeID': placeID,
      'types': types,
    };
  }

  factory PlaceModel.fromMap(Map<String, dynamic> map) {
    return PlaceModel(
      description: map['description'] ?? "",
      placeID: map['placeID'] ?? "",
      types: (map['types'] ?? []),
    );
  }

  String toJson() => json.encode(toMap());

  factory PlaceModel.fromJson(String source) =>
      PlaceModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'PlaceModel(description: $description, placeID: $placeID, types: $types)';
}
