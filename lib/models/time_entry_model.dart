import 'dart:convert';

class TimeEntry {
  final String id;
  final String projectId;
  final String taskId;
  final double totalTime;
  final DateTime date;
  final String notes;

  const TimeEntry({
    required this.id,
    required this.projectId,
    required this.taskId,
    required this.totalTime,
    required this.date,
    required this.notes,
  });

  factory TimeEntry.fromJson(Map<String, dynamic> json) {
    return TimeEntry(
      id: json['id'],
      projectId: json['projectId'],
      taskId: json['taskId'],
      totalTime: json['totalTime'],
      date: DateTime.parse(json['date']),
      notes: json['notes'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'projectId': projectId,
    'taskId': taskId,
    'totalTime': totalTime,
    'date': date.toIso8601String(),
    'notes': notes,
  };
  static List<TimeEntry> decode(String timeEntries) =>
      (jsonDecode(timeEntries) as List)
          .map((e) => TimeEntry.fromJson(e))
          .toList();

  static String encode(List<TimeEntry> entries) =>
      jsonEncode(entries.map((e) => e.toJson()).toList());
}
