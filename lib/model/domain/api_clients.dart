import 'dart:convert';
import 'dart:io';

class ApiClient {
  static const _baseUrl = 'https://beta.mrdekk.ru/todobackend';

  final client = HttpClient();

  Future<Map<String, dynamic>> getData() async {
    final url = Uri.parse('$_baseUrl/list');
    final request = await client.getUrl(url);
    request.headers.add('Authorization', 'Bearer restorative');
    final response = await request.close();
    if (response.statusCode == 200) {
      final jsonStrings = await response.transform(utf8.decoder).toList();
      final body = jsonStrings.join();
      final json = jsonDecode(body) as Map<String, dynamic>;
      return json;
    }
    return {};
  }
}
