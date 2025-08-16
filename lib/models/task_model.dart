import 'dart:convert' show jsonDecode, jsonEncode;
import 'managed_entity.dart';

class Task extends ManagedEntity {
  @override
  final String id;
  @override
  final String name;
  Task({required this.id, required this.name});

  factory Task.fromJson(Map<String, dynamic> json) =>
      Task(id: json['id'] as String, name: json['name'] as String);

  Map<String, dynamic> toJson() => {'id': id, 'name': name};

  static List<Task> decode(String source) =>
      (jsonDecode(source) as List).map((e) => Task.fromJson(e)).toList();

  static String encode(List<Task> tasks) =>
      jsonEncode(tasks.map((e) => e.toJson()).toList());
}
