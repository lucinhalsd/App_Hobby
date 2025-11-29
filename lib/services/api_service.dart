

import 'dart:convert';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;

class ApiService {
  Future<String> getQuote() async {
    final response = await http.get(Uri.parse("https://api.quotable.io/random"));
    final data = jsonDecode(response.body);
    return data["content"];
  }
}
