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
  static const _utf8HeaderValue = 'application/json; charset=utf-8';
  static const Map<String, dynamic> _addTaskMap = {"status": "ok"};

  static Map<String, dynamic> _getBodyMap(TaskItem task) {
    final taskMap = task.toJson();
    final bodyMap = Map<String, dynamic>.of(_addTaskMap);
    bodyMap[_elementKey] = taskMap;
    return bodyMap;
  }

  Future<String> getData() async {
    final url = Uri.parse(_baseUrl);
    final request = await client.getUrl(url);
    request.headers.add(_authHeaderKey, _authHeaderValue);
    final response = await request.close();
    if (response.statusCode == 200) {
      final jsonStrings = await response.transform(utf8.decoder).toList();
      final jsonString = jsonStrings.join();
      return jsonString;
    }
    // TODO: throw error
    return '';
  }

  Future<void> addTask(int revision, TaskItem task) async {
    final url = Uri.parse(_baseUrl);
    final request = await client.postUrl(url);
    request.headers.set(HttpHeaders.contentTypeHeader, _utf8HeaderValue);
    request.headers.add(_authHeaderKey, _authHeaderValue);
    request.headers.add(_revisionHeaderKey, revision);
    final bodyMap = _getBodyMap(task);
    request.write(jsonEncode(bodyMap));
    await request.close();
  }

  Future<void> deleteTask(int revision, String id) async {
    final url = Uri.parse('$_baseUrl/$id');
    final request = await client.deleteUrl(url);
    request.headers.add(_authHeaderKey, _authHeaderValue);
    request.headers.add(_revisionHeaderKey, revision);
    await request.close();
  }

  Future<void> editTask(int revision, TaskItem task) async {
    final taskId = task.id;
    final url = Uri.parse('$_baseUrl/$taskId');
    final request = await client.putUrl(url);
    request.headers.set(HttpHeaders.contentTypeHeader, _utf8HeaderValue);
    request.headers.add(_authHeaderKey, _authHeaderValue);
    request.headers.add(_revisionHeaderKey, revision);
    final bodyMap = _getBodyMap(task);
    request.write(jsonEncode(bodyMap));
    await request.close();
  }
}
