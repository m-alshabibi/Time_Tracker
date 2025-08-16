import 'dart:convert' show jsonEncode, jsonDecode;
import 'managed_entity.dart';

class Project extends ManagedEntity {
  @override
  final String id;
  @override
  final String name;
  Project({required this.id, required this.name});

  factory Project.fromJson(Map<String, dynamic> json) =>
      Project(id: json['id'], name: json['name']);

  Map<String, dynamic> toJson() => {'id': id, 'name': name};

  static List<Project> decode(String source) =>
      (jsonDecode(source) as List).map((e) => Project.fromJson(e)).toList();

  static String encode(List<Project> projects) =>
      jsonEncode(projects.map((e) => e.toJson()).toList());
}
