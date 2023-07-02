import 'dart:convert';
import 'dart:io';

import 'package:ya_todo_list/model/task_item.dart';

class ApiClient {
  final client = HttpClient();
  static const _baseUrl = 'https://beta.mrdekk.ru/todobackend/list';
  static const _authHeaderKey = 'Authorization';
  static const _authHeaderValue = 'Bearer restorative';
  static const _revisionHeaderKey = 'X-Last-Known-Revision';
  static const _elementKey = 'element';
  static const _listKey = 'list';
  static const _utf8HeaderValue = 'application/json; charset=utf-8';
  static const _noInternetExceptionText = 'No internet connection';
  static const Map<String, dynamic> _addTaskMap = {"status": "ok"};

  static Map<String, dynamic> _getBodyMap(TaskItem task) {
    final taskMap = task.toJson();
    final bodyMap = Map<String, dynamic>.of(_addTaskMap);
    bodyMap[_elementKey] = taskMap;
    return bodyMap;
  }

  Future<Map<String, dynamic>> getData() async {
    try {
      final url = Uri.parse(_baseUrl);
      final request = await client.getUrl(url);
      request.headers.add(_authHeaderKey, _authHeaderValue);
      final response = await request.close();
      if (response.statusCode == 200) {
        final jsonStrings = await response.transform(utf8.decoder).toList();
        final jsonString = jsonStrings.join();
        final json = jsonDecode(jsonString) as Map<String, dynamic>;
        return json;
      }
      throw Exception('${response.statusCode}');
    } catch (e) {
      throw Exception(_noInternetExceptionText);
    }
  }

  Future<void> addTask(int revision, TaskItem task) async {
    try {
      final url = Uri.parse(_baseUrl);
      final request = await client.postUrl(url);
      request.headers.set(HttpHeaders.contentTypeHeader, _utf8HeaderValue);
      request.headers.add(_authHeaderKey, _authHeaderValue);
      request.headers.add(_revisionHeaderKey, revision);
      final bodyMap = _getBodyMap(task);
      request.write(jsonEncode(bodyMap));
      final response = await request.close();
      if (response.statusCode != 200) {
        throw Exception('${response.statusCode}');
      }
    } catch (e) {
      throw Exception(_noInternetExceptionText);
    }
  }

  Future<void> deleteTask(int revision, String id) async {
    try {
      final url = Uri.parse('$_baseUrl/$id');
      final request = await client.deleteUrl(url);
      request.headers.add(_authHeaderKey, _authHeaderValue);
      request.headers.add(_revisionHeaderKey, revision);
      final response = await request.close();
      if (response.statusCode != 200) {
        throw Exception('${response.statusCode}');
      }
    } catch (e) {
      throw Exception(_noInternetExceptionText);
    }
  }

  Future<void> editTask(int revision, TaskItem task) async {
    try {
      final taskId = task.id;
      final url = Uri.parse('$_baseUrl/$taskId');
      final request = await client.putUrl(url);
      request.headers.set(HttpHeaders.contentTypeHeader, _utf8HeaderValue);
      request.headers.add(_authHeaderKey, _authHeaderValue);
      request.headers.add(_revisionHeaderKey, revision);
      final bodyMap = _getBodyMap(task);
      request.write(jsonEncode(bodyMap));
      final response = await request.close();
      if (response.statusCode != 200) {
        throw Exception('${response.statusCode}');
      }
    } catch (e) {
      throw Exception(_noInternetExceptionText);
    }
  }

  Future<void> patchTasks(int revision, List<TaskItem> tasks) async {
    try {
      final url = Uri.parse(_baseUrl);
      final request = await client.patchUrl(url);
      request.headers.set(HttpHeaders.contentTypeHeader, _utf8HeaderValue);
      request.headers.add(_authHeaderKey, _authHeaderValue);
      request.headers.add(_revisionHeaderKey, revision);
      final jsonTasks = tasks.map((task) => task.toJson()).toList();
      final bodyMap = Map<String, dynamic>.of(_addTaskMap);
      bodyMap[_listKey] = jsonTasks;
      print(bodyMap);
      request.write(jsonEncode(bodyMap));
      final response = await request.close();
      if (response.statusCode != 200) {
        throw Exception('${response.statusCode}');
      }
    } catch (e) {
      throw Exception(_noInternetExceptionText);
    }
  }
}
