import 'dart:convert';
import '../models/project_model.dart';
import 'base_provider.dart';

class ProjectProvider extends BaseProvider<Project> {
  ProjectProvider()
    : super(
        prefKey: 'projects',
        decoder: (data) => (json.decode(data) as List)
            .map((e) => Project.fromJson(e))
            .toList(),
        encoder: (items) => json.encode(items.map((e) => e.toJson()).toList()),
        initialData: [
          Project(id: 'p1', name: 'Project Alpha'),
          Project(id: 'p2', name: 'Project Beta'),
          Project(id: 'p3', name: 'Project Gamma'),
        ],
      );
}
