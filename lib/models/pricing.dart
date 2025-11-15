// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Pricing {
  final String title;
  final int price;
  int? pax;

  Pricing({
    required this.title,
    required this.price,
    this.pax,
  });

  Pricing copyWith({
    String? title,
    int? price,
    int? pax,
  }) {
    return Pricing(
      title: title ?? this.title,
      price: price ?? this.price,
      pax: pax ?? this.pax,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'price': price,
      'pax': pax,
    };
  }

  factory Pricing.fromMap(Map<String, dynamic> map) {
    return Pricing(
      title: map['title'] ?? "",
      price: map['price'] ?? 0,
      pax: map['pax'] ?? 1,
    );
  }

  String toJson() => json.encode(toMap());

  factory Pricing.fromJson(String source) =>
      Pricing.fromMap(json.decode(source) as Map<String, dynamic>);
}
