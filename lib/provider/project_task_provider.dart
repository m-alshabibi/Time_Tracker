import 'package:flutter/material.dart' show ChangeNotifier;
import '../models/time_entry_model.dart' show TimeEntry;
import 'package:shared_preferences/shared_preferences.dart';

class TimeEntryProvider with ChangeNotifier {
  List<TimeEntry> _entries = [];

  List<TimeEntry> get entries => _entries;

  Future<void> loadEntries() async {
    final prefs = await SharedPreferences.getInstance();
    // await prefs.clear();
    final data = prefs.getString('time_entries');
    if (data != null) {
      _entries = TimeEntry.decode(data);
    }
    _saveToPrefs();
    notifyListeners();
  }

  Future<void> addEntry(TimeEntry entry) async {
    _entries.add(entry);
    await _saveToPrefs();
    notifyListeners();
  }

  Future<void> deleteEntry(String id) async {
    _entries.removeWhere((e) => e.id == id);
    await _saveToPrefs();
    notifyListeners();
  }

  Future<void> _saveToPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final data = TimeEntry.encode(_entries);
    await prefs.setString('time_entries', data);
  }
}
