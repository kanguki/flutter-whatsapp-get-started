import 'dart:convert';

import 'package:whatsapp/config/api.dart';
import 'package:whatsapp/models/info.dart';
import 'package:http/http.dart' as http;

Future<List<Info>?> fetchInfo(String? name, int offset, int limit) async {
  name ??= "";
  var api = "${Api.getStudentsInfo}?name=$name&offset=$offset&limit=$limit"  ;
  try {
    final response = await http.get(Uri.parse(api));
    print("response $api: ${response.body}");
    if (response.statusCode == 200) {
      return Info.fromJson(jsonDecode(response.body));
    }
    throw Exception('Failed to load student personal info');
  } catch (e) {
    print("Failed to load student personal info: " + e.toString());
    throw Exception('Failed to load student personal info' + e.toString());
  }
}
