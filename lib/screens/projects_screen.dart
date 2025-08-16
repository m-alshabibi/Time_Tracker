import 'package:flutter/material.dart';
import 'package:time_tracker/core/utils/snackbar_utils.dart';
import 'package:time_tracker/dialogs/add_dialog.dart';
import 'package:time_tracker/models/project_model.dart';
import 'package:time_tracker/provider/project_provider.dart';
import 'package:time_tracker/screens/widgets/management_item.dart';
import 'package:time_tracker/screens/widgets/management_screen.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class ProjectManagementScreen extends StatelessWidget {
  const ProjectManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ProjectProvider>(
      builder: (context, provider, _) {
        return ManagementScreen<Project>(
          title: 'Manage Projects',
          dataList: provider.items,
          onDismissed: (project) {
            provider.deleteItem(project.id);
            showSnackBar(context, 'Project deleted: ${project.name}');
          },
          onAddPressed: () {
            // استدعاء النافذة المنبثقة العامة لإضافة المشاريع
            // showAddProjectDialog(context);
            showAddDialog(
              context: context,
              title: "Add Project",
              labelText: "Project Name",
              onAdd: (name) {
                provider.addItem(Project(id: const Uuid().v4(), name: name));
                showSnackBar(context, 'Project added: $name');
              },
            );
          },
          itemBuilder: (context, item) {
            return ManagementItem<Project>(item: item);
          },
        );
      },
    );
  }
}
