import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsStorage {
  static const _jsonKey = 'data';
  static final _storage = SharedPreferences.getInstance();

  Future<String?> readData() async {
    final storage = await _storage;
    final dataString = storage.getString(_jsonKey);
    return dataString;
  }

  Future<void> setData(String json) async {
    final storage = await _storage;
    storage.setString(_jsonKey, json);
  }
}
