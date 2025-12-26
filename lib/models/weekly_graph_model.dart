class WeeklyGraphModel {
  final String day;
  final DateTime date;
  final int count;

  WeeklyGraphModel({
    required this.day,
    required this.date,
    required this.count,
  });

  factory WeeklyGraphModel.fromJson(Map<String, dynamic> json) {
    return WeeklyGraphModel(
      day: json['day'] ?? '',
      date: DateTime.tryParse(json['createdAt'] ?? '')?? DateTime.now(),
      count: json['count'] ?? 0,
    );
  }

  String get formattedDay => "$day-${date.day}";

  @override
  String toString() {
    return 'WeeklyGraphModel{day: $day, date: $date, count: $count}';
  }
}
