import 'dart:convert';
import 'package:http/http.dart' as http;
import 'event.dart';

class ApiService {
  static const String url = 'http://127.0.0.1:8000/api/events';

  static Future<List<Event>> getEvents() async {
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        List<Event> list = parseEvents(response.body);
        return list;
      } else {
        throw Exception("Error");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static List<Event> parseEvents(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Event>((json) => Event.fromJson(json)).toList();
  }
}
