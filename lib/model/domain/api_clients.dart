import 'dart:convert';
import 'dart:io';

import 'package:ya_todo_list/model/task_item.dart';

class ApiClient {
  static const _baseUrl = 'https://beta.mrdekk.ru/todobackend';
  static const _authHeaderKey = 'Authorization';
  static const _authHeaderValue = 'Bearer restorative';
  static const _revisionHeaderKey = 'X-Last-Known-Revision';
  static const Map<String, dynamic> _addTaskMap = {"status": "ok"};

  final client = HttpClient();

  Future<Map<String, dynamic>> getData() async {
    final url = Uri.parse('$_baseUrl/list');
    final request = await client.getUrl(url);
    request.headers.add(_authHeaderKey, _authHeaderValue);
    final response = await request.close();
    if (response.statusCode == 200) {
      final jsonStrings = await response.transform(utf8.decoder).toList();
      final body = jsonStrings.join();
      final json = jsonDecode(body) as Map<String, dynamic>;
      return json;
    }
    return {};
  }

  Future<void> addTask(int revision, TaskItem task) async {
    final url = Uri.parse('$_baseUrl/list');
    final request = await client.postUrl(url);
    request.headers.add(_authHeaderKey, _authHeaderValue);
    request.headers.add(_revisionHeaderKey, revision);
    final taskMap = task.toJson();
    final bodyMap = Map.from(_addTaskMap);
    bodyMap["element"] = taskMap;
    request.write(jsonEncode(bodyMap));
    await request.close();
    // TODO: add alert window if statuscode != 200
  }

  Future<void> deleteTask(int revision, String id) async {
    final url = Uri.parse('$_baseUrl/list/$id');
    final request = await client.deleteUrl(url);
    request.headers.add(_authHeaderKey, _authHeaderValue);
    request.headers.add(_revisionHeaderKey, revision);
    await request.close();
  }
}
