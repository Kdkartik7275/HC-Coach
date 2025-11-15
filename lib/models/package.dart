// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Package {
  final String packageFor;
  final int hours;
  final int actualPrice;
  final int discount;

  Package({
    required this.packageFor,
    required this.hours,
    required this.actualPrice,
    required this.discount,
  });

  Package copyWith({
    String? packageFor,
    int? hours,
    int? actualPrice,
    int? discount,
  }) {
    return Package(
      packageFor: packageFor ?? this.packageFor,
      hours: hours ?? this.hours,
      actualPrice: actualPrice ?? this.actualPrice,
      discount: discount ?? this.discount,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'packageFor': packageFor,
      'hours': hours,
      'actualPrice': actualPrice,
      'discount': discount,
    };
  }

  factory Package.fromMap(Map<String, dynamic> map) {
    return Package(
      packageFor: map['packageFor'] as String,
      hours: map['hours'] as int,
      actualPrice: map['actualPrice'] as int,
      discount: map['discount'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory Package.fromJson(String source) =>
      Package.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Package(packageFor: $packageFor, hours: $hours, actualPrice: $actualPrice, discount: $discount)';
  }

  @override
  bool operator ==(covariant Package other) {
    if (identical(this, other)) return true;

    return other.packageFor == packageFor &&
        other.hours == hours &&
        other.actualPrice == actualPrice &&
        other.discount == discount;
  }

  @override
  int get hashCode {
    return packageFor.hashCode ^
        hours.hashCode ^
        actualPrice.hashCode ^
        discount.hashCode;
  }
}
