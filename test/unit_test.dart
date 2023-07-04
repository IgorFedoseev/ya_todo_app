// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ya_todo_list/model/task_item.dart';
import 'mock_data/getting_data_mock.mocks.dart';
import 'mock_data/mock_tasks.dart';

void main() {
  group('ApiClient', () {
    late MockApiClient mockApiClient;

    setUp(() {
      mockApiClient = MockApiClient();
    });

    test('getData() should return Map with data', () async {
      // arrange
      when(mockApiClient.getData())
          .thenAnswer((_) async => MockTasks.mockTasks);

      // act
      final data = await mockApiClient.getData();

      // assert
      expect(data, isA<Map<String, dynamic>>());
      expect(data, MockTasks.mockTasks);
    });

    test('addTask() should add a task successfully', () async {
      // arrange
      when(mockApiClient.addTask(any, any)).thenAnswer((_) async {});

      // act
      const revision = 1;
      final taskMap = MockTasks.mockTasks["list"][1] as Map<String, dynamic>;
      final task = TaskItem.fromJson(taskMap);
      await mockApiClient.addTask(revision, task);

      // assert
      verify(mockApiClient.addTask(revision, task)).called(1);
    });
  });

  group('HiveDataBase', () {
    late MockHiveDataBase mockDataBase;
    final taskMapOne = MockTasks.mockTasks["list"][0] as Map<String, dynamic>;
    final taskMapTwo = MockTasks.mockTasks["list"][0] as Map<String, dynamic>;
    final taskOne = TaskItem.fromJson(taskMapOne);
    final taskTwo = TaskItem.fromJson(taskMapTwo);

    test('getTasks() should return a list of tasks', () async {
      // arrange
      mockDataBase = MockHiveDataBase();
      final expectedTasks = [taskOne, taskTwo];
      when(mockDataBase.getTasks())
          .thenAnswer((_) => Future.value(expectedTasks));

      // act
      final tasks = await mockDataBase.getTasks();

      // assert
      expect(tasks, equals(expectedTasks));
    });

    test('putTask() should save a task successfully', () async {
      // arrange
      mockDataBase = MockHiveDataBase();
      final task = taskOne;

      // act
      await mockDataBase.putTask(task);

      // assert
      verify(mockDataBase.putTask(task)).called(1);
    });
  });

  group('SharedPrefsStorage', () {
    late MockSharedPrefsStorage mockSharedPrefsStorage;

    test('setRevision() should set the revision successfully', () async {
      // arrange
      mockSharedPrefsStorage = MockSharedPrefsStorage();
      const revision = 10;

      // act
      await mockSharedPrefsStorage.setRevision(revision);

      // assert
      verify(mockSharedPrefsStorage.setRevision(revision)).called(1);
    });

    test('getRevision() should return the revision successfully', () async {
      // arrange
      mockSharedPrefsStorage = MockSharedPrefsStorage();
      const expRevision = 1;
      when(mockSharedPrefsStorage.getRevision())
          .thenAnswer((_) => Future.value(expRevision));

      // act
      final revision = await mockSharedPrefsStorage.getRevision();

      // assert
      expect(revision, equals(expRevision));
    });
  });
}
