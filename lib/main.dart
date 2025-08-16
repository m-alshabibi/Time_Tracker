import 'package:flutter/material.dart';
import 'package:time_tracker/core/theme/my_theme_data.dart';
import 'package:time_tracker/provider/project_provider.dart';
import 'package:time_tracker/provider/project_task_provider.dart';
import 'package:time_tracker/provider/task_provider.dart';
import 'package:time_tracker/screens/home_page.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<TimeEntryProvider>(
          create: (_) => TimeEntryProvider()..loadEntries(),
        ),
        ChangeNotifierProvider<ProjectProvider>(
          create: (_) => ProjectProvider()..loadItems(),
        ),
        ChangeNotifierProvider<TaskProvider>(
          create: (_) => TaskProvider()..loadItems(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: MyThemeApp.themeApp(light: false),
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}
