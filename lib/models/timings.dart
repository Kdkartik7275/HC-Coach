class Timings {
  final String address;
  bool isHoliday;
  final DateTime date;
  final List<Map<String, DateTime>> timings;

  Timings({
    required this.address,
    required this.date,
    required this.isHoliday,
    required this.timings,
  });

  Timings copyWith({
    String? address,
    DateTime? date,
    List<Map<String, DateTime>>? timings,
    bool? isHoliday,
  }) {
    return Timings(
      address: address ?? this.address,
      isHoliday: isHoliday ?? this.isHoliday,
      date: date ?? this.date,
      timings: timings ?? this.timings,
    );
  }

  factory Timings.fromMap(Map<String, dynamic> map) {
    DateTime parsedDate;
    try {
      parsedDate = DateTime.parse(map['date']);
    } catch (e) {
      throw FormatException("Invalid date format: ${map['date']}");
    }

    return Timings(
      address: map['address'] as String,
      isHoliday: map['isHoliday'] as bool,
      date: parsedDate,
      timings: List<Map<String, DateTime>>.from(
        (map['timings'] as List<dynamic>).map((dynamic timing) {
          return (timing as Map<String, dynamic>).map(
            (key, value) {
              DateTime parsedTime;
              try {
                parsedTime = DateTime.parse(value);
              } catch (e) {
                throw FormatException("Invalid time format: $value");
              }
              return MapEntry(key, parsedTime.toLocal());
            },
          );
        }),
      ),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'address': address,
      'date': date.toIso8601String(),
      'isHoliday': isHoliday,
      'timings': timings
          .map((timing) => timing.map(
              (key, value) => MapEntry(key, value.toUtc().toIso8601String())))
          .toList(),
    };
  }
}
