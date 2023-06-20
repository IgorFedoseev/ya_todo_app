import 'dart:convert';
import 'package:http/http.dart';

class ApiClient {
  static const _baseUrl = 'https://beta.mrdekk.ru/todobackend';
  static const _authHeader = {'Authorization': 'Bearer restorative'};

  Future<Map<String, dynamic>> getList() async {
    final uri = Uri.parse('$_baseUrl/list');
    final response = await get(uri, headers: _authHeader);
    if (response.statusCode == 200) {
      final body = response.body;
      final json = jsonDecode(body) as Map<String, dynamic>;
      return json;
    }
    throw ArgumentError("Unknown status code");
  }
}
