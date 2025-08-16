// lib/screens/add_time_entry_screen.dart
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:time_tracker/provider/project_task_provider.dart';
import 'package:uuid/uuid.dart'; // مكتبة لإنشاء معرفات فريدة

import 'package:provider/provider.dart';
import 'package:time_tracker/models/project_model.dart';
import 'package:time_tracker/models/task_model.dart';
import 'package:time_tracker/models/time_entry_model.dart';
import 'package:time_tracker/provider/project_provider.dart';
import 'package:time_tracker/provider/task_provider.dart';

import 'widgets/reusable_drop_down.dart'; // استيراد الودجت الجديدة

class AddTimeEntryScreen extends StatefulWidget {
  const AddTimeEntryScreen({super.key});

  @override
  _AddTimeEntryScreenState createState() => _AddTimeEntryScreenState();
}

class _AddTimeEntryScreenState extends State<AddTimeEntryScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? _projectId;
  String? _taskId;
  double? _totalTime;
  DateTime _date = DateTime.now();
  String? _notes;

  @override
  void initState() {
    super.initState();
    // تهيئة القيم الأولية بناءً على البيانات المتوفرة في Providers
    final projectProvider = Provider.of<ProjectProvider>(
      context,
      listen: false,
    );
    final taskProvider = Provider.of<TaskProvider>(context, listen: false);
    _projectId = projectProvider.items.isNotEmpty
        ? projectProvider.items.first.id
        : null;
    _taskId = taskProvider.items.isNotEmpty
        ? taskProvider.items.first.id
        : null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Time Entry')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              ReusableDropdown<Project, ProjectProvider>(
                labelText: 'Project',
                onChanged: (newValue) {
                  setState(() {
                    _projectId = newValue;
                  });
                },
              ),
              const SizedBox(height: 15),

              // استخدام الودجت الجديدة للمهام
              ReusableDropdown<Task, TaskProvider>(
                labelText: 'Task',
                onChanged: (newValue) {
                  setState(() {
                    _taskId = newValue;
                  });
                },
              ),
              const SizedBox(height: 15),

              // حقل التاريخ
              TextFormField(
                readOnly: true,
                controller: TextEditingController(
                  text: Jiffy.parseFromDateTime(_date).yMMMd,
                ),
                decoration: InputDecoration(
                  labelText: 'Date',
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.date_range),
                    onPressed: () async {
                      final selectedDate = await showDatePicker(
                        context: context,
                        initialDate: _date,
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2030),
                      );
                      if (selectedDate != null) {
                        setState(() {
                          _date = selectedDate;
                        });
                      }
                    },
                  ),
                ),
              ),
              const SizedBox(height: 15),

              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Total Time (hours)',
                ),
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter total time';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Please enter a valid number';
                  }
                  return null;
                },
                onSaved: (value) => _totalTime = double.parse(value!),
              ),
              const SizedBox(height: 15),

              // حقل الملاحظات
              TextFormField(
                decoration: const InputDecoration(labelText: 'Notes'),
                maxLines: 3,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some notes';
                  }
                  return null;
                },
                onSaved: (value) => _notes = value,
              ),
              const SizedBox(height: 25),

              // زر الحفظ
              ElevatedButton(onPressed: _submitForm, child: const Text('Save')),
            ],
          ),
        ),
      ),
    );
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      // يجب التحقق من أن القيم ليست null قبل الحفظ
      if (_projectId == null ||
          _taskId == null ||
          _totalTime == null ||
          _notes == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please select all required fields')),
        );
        return;
      }

      final newEntry = TimeEntry(
        id: const Uuid().v4(),
        projectId: _projectId!,
        taskId: _taskId!,
        totalTime: _totalTime!,
        date: _date,
        notes: _notes!,
      );

      Provider.of<TimeEntryProvider>(context, listen: false).addEntry(newEntry);
      Navigator.pop(context);
    }
  }
}
