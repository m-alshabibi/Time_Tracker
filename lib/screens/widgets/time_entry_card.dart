import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:time_tracker/provider/project_provider.dart'
    show ProjectProvider;
import 'package:time_tracker/models/time_entry_model.dart' show TimeEntry;
import 'package:time_tracker/provider/project_task_provider.dart'
    show TimeEntryProvider;
import 'package:time_tracker/provider/task_provider.dart' show TaskProvider;
import 'package:provider/provider.dart';

class TimeEntryCard extends StatelessWidget {
  const TimeEntryCard({super.key, required this.entry, this.isGrouped = false});

  final TimeEntry entry;
  final bool isGrouped;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final projectName = context.watch<ProjectProvider>().getName(
      entry.projectId,
    );
    final taskName = isGrouped
        ? null
        : context.watch<TaskProvider>().getName(entry.taskId);

    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
        child: Row(
          children: [
            Flexible(
              fit: FlexFit.tight,
              flex: 8,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (!isGrouped) ...[
                    Row(
                      children: [
                        Container(
                          width: 6,
                          height: 6,
                          margin: const EdgeInsets.only(right: 10.0),
                          decoration: BoxDecoration(
                            color: theme.colorScheme.secondary,
                            borderRadius: BorderRadius.circular(50),
                          ),
                        ),
                        Text(
                          Jiffy.parseFromDateTime(entry.date).yMMMd,
                          style: const TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                  ],
                  Text(
                    isGrouped
                        ? (projectName ?? "null")
                        : '$projectName - $taskName',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      height: 1.6,
                    ),
                  ),

                  if (isGrouped) ...[
                    const Divider(height: 5),
                    ..._buildGroupedTasks(context, theme),
                  ] else ...[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Total Time",
                          style: TextStyle(color: theme.colorScheme.secondary),
                        ),
                        Text(
                          "${entry.totalTime.toInt()}h",
                          style: TextStyle(color: theme.colorScheme.secondary),
                        ),
                      ],
                    ),
                    const Divider(height: 5),
                    Row(
                      children: [
                        const Icon(
                          Icons.note_alt_rounded,
                          size: 16,
                          color: Colors.grey,
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            entry.notes,
                            style: const TextStyle(color: Colors.grey),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
            if (!isGrouped)
              Flexible(
                fit: FlexFit.loose,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Icon(
                    Icons.delete_forever,
                    size: 30,
                    color: Colors.redAccent,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildGroupedTasks(BuildContext context, ThemeData theme) {
    return context
        .watch<TimeEntryProvider>()
        .entries
        .where((element) => element.projectId == entry.projectId)
        .map((task) {
          final ktaskName = context.watch<TaskProvider>().getName(task.taskId);
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Text(
                    '${task.totalTime.toInt()}h - $ktaskName',
                    style: TextStyle(color: theme.colorScheme.secondary),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Row(
                  children: [
                    Icon(
                      Icons.date_range_sharp,
                      size: 16,
                      color: theme.colorScheme.secondary,
                    ),
                    const SizedBox(width: 5),
                    Text(
                      Jiffy.parseFromDateTime(task.date).yMMMd,
                      style: TextStyle(color: theme.colorScheme.secondary),
                    ),
                  ],
                ),
              ],
            ),
          );
        })
        .toList();
  }
}
