import 'package:mockito/annotations.dart';
import 'package:ya_todo_list/domain/api_clients.dart';
import 'package:ya_todo_list/storage/db_hive.dart';
import 'package:ya_todo_list/storage/shared_prefs_storage.dart';

@GenerateMocks([HiveDataBase, SharedPrefsStorage, ApiClient])
// ignore: unused_import
import 'getting_data_mock.mocks.dart';
