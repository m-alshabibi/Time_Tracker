import 'package:flutter/material.dart';
import 'package:time_tracker/core/utils/snackbar_utils.dart';
import 'package:time_tracker/dialogs/add_dialog.dart';
import 'package:time_tracker/models/task_model.dart';
import 'package:time_tracker/provider/task_provider.dart';
import 'package:provider/provider.dart';
import 'package:time_tracker/screens/widgets/management_screen.dart';
import 'widgets/management_item.dart';

class TaskManagementScreen extends StatelessWidget {
  const TaskManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<TaskProvider>(
      builder: (context, provider, _) {
        return ManagementScreen<Task>(
          title: 'Manage Tasks',
          dataList: provider.items,
          onDismissed: (task) {
            provider.deleteItem(task.id);
            showSnackBar(context, 'Task deleted: ${task.name}');
          },
          onAddPressed: () {
            showAddDialog(
              context: context,
              title: "Add Tasks",
              labelText: "Task Name",
              onAdd: (name) {
                provider.addItem(Task(id: "t4", name: name));
                showSnackBar(context, 'Task added: $name');
              },
            );
          },
          itemBuilder: (context, item) {
            return ManagementItem<Task>(item: item);
          },
        );
      },
    );
  }
}
