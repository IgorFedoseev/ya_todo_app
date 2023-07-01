import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsStorage {
  static const _jsonKey = 'data';
  static const _revisionKey = 'revision';
  static const _emptyListJson = {"list": []};
  static final _storage = SharedPreferences.getInstance();

  Future<int> getRevision() async {
    final storage = await _storage;
    final revision = storage.getInt(_revisionKey);
    if (revision != null) {
      return revision;
    }
    return 0;
  }

  Future<void> setRevision(int revision) async {
    final storage = await _storage;
    storage.setInt(_revisionKey, revision);
  }

  Future<String> readData() async {
    final storage = await _storage;
    final dataString = storage.getString(_jsonKey);
    if (dataString != null) {
      return dataString;
    }
    final emptyJsonString = jsonEncode(_emptyListJson);
    return emptyJsonString;
  }

  Future<void> setData(String json) async {
    final storage = await _storage;
    storage.setString(_jsonKey, json);
  }
}
