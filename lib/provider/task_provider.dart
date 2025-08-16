import 'dart:convert';
import 'package:time_tracker/provider/base_provider.dart';
import '../models/task_model.dart';

class TaskProvider extends BaseProvider<Task> {
  TaskProvider()
    : super(
        prefKey: 'tasks',
        decoder: (data) =>
            (json.decode(data) as List).map((e) => Task.fromJson(e)).toList(),
        encoder: (items) => json.encode(items.map((e) => e.toJson()).toList()),
        initialData: [
          Task(id: 't1', name: 'Task A'),
          Task(id: 't2', name: 'Task B'),
          Task(id: 't3', name: 'Task C'),
        ],
      );
}
