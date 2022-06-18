import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:whatsapp/config/api.dart';

Future<List<String>> fetchNames() async {
  var api = Api.getStudentNames;
  try {
    final response = await http.get(Uri.parse(api));
    print("response $api: ${response.body}");
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      return List<String>.from(data);
    }
    throw Exception('Failed to load student names');
  } catch (e) {
    print("Failed to load student names: " + e.toString());
    throw Exception('Failed to load student names' + e.toString());
  }
}
