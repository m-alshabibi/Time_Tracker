import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'package:time_tracker/models/managed_entity.dart';
import 'package:shared_preferences/shared_preferences.dart';

typedef Decoder<T> = List<T> Function(String);
typedef Encoder<T> = String Function(List<T>);

class BaseProvider<T extends ManagedEntity> with ChangeNotifier {
  final String _prefKey;
  final Decoder<T> _decoder;
  final Encoder<T> _encoder;
  final List<T> _initialData;

  List<T> _items = [];

  BaseProvider({
    required String prefKey,
    required Decoder<T> decoder,
    required Encoder<T> encoder,
    required List<T> initialData,
  }) : _prefKey = prefKey,
       _decoder = decoder,
       _encoder = encoder,
       _initialData = initialData;

  List<T> get items => _items;

  String? getName(String id) {
    if (_items.isEmpty) return null;
    return _items.firstWhereOrNull((item) => item.id == id)?.name;
  }

  Future<void> loadItems() async {
    final prefs = await SharedPreferences.getInstance();
    bool hasInitialized = prefs.containsKey(_prefKey);

    if (!hasInitialized) {
      _items = List.from(_initialData);
      await _saveToPrefs();
    } else {
      final data = prefs.getString(_prefKey);
      if (data != null) {
        _items = _decoder(data);
      }
    }
    notifyListeners();
  }

  Future<void> addItem(T item) async {
    _items.add(item);
    await _saveToPrefs();
    notifyListeners();
  }

  Future<void> deleteItem(String id) async {
    _items.removeWhere((item) => item.id == id);
    await _saveToPrefs();
    notifyListeners();
  }

  Future<void> _saveToPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final data = _encoder(_items);
    await prefs.setString(_prefKey, data);
  }
}
