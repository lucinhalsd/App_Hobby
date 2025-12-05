import 'dart:convert';
import 'package:http/http.dart' as http;

class WeatherService {
  final String apiKey = "SUA_API_KEY_AQUI";

  Future<Map<String, dynamic>> getWeather(double lat, double lon) async {
    final url =
        "https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&units=metric&lang=pt_br&appid=$apiKey";

    final response = await http.get(Uri.parse(url));
    return jsonDecode(response.body);
  }
}
