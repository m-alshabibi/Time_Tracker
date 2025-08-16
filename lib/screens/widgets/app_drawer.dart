// lib/screens/widgets/app_drawer.dart
import 'package:flutter/material.dart';
import 'package:time_tracker/screens/projects_screen.dart';
import 'package:time_tracker/screens/task_screen.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Drawer(
      child: Column(
        children: [
          Container(
            width: double.infinity,
            height: 220,
            color: theme.cardColor,
            child: const Center(
              child: Text("Menu", style: TextStyle(fontSize: 18)),
            ),
          ),
          ListTile(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => ProjectManagementScreen()),
              );
            },
            minLeadingWidth: 15,
            leading: const Icon(Icons.folder, size: 20),
            title: const Text("Projects"),
            titleTextStyle: const TextStyle(fontSize: 16),
          ),
          ListTile(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => TaskManagementScreen()),
              );
            },
            minLeadingWidth: 15,
            leading: const Icon(Icons.feed_outlined, size: 20),
            title: const Text("Task"),
            titleTextStyle: const TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}
