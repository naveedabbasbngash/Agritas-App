import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/weather.dart';
import '../utils/logger.dart';

class WeatherApi {
  static const String _baseUrl = 'https://wttr.in';

  static Future<Weather> getWeather(String city) async {
    final url = Uri.parse('$_baseUrl/$city?format=j1');
    Logger.log('Fetching weather data from $url', tag: 'WeatherApi');

    try {
      final response = await http.get(url);

      Logger.apiResponse('Response status: ${response.statusCode}', tag: 'WeatherApi');
      Logger.apiResponse('Response body: ${response.body}', tag: 'WeatherApi');

      if (response.statusCode == 200) {
        final Map<String, dynamic> weatherJson = json.decode(response.body);
        Logger.log('Parsed weather data for $city', tag: 'WeatherApi');
        return Weather.fromJson(weatherJson);
      } else {
        Logger.error('Failed to load weather data: ${response.statusCode}', tag: 'WeatherApi');
        throw Exception('Failed to load weather data');
      }
    } catch (e) {
      Logger.error('Exception occurred: $e', tag: 'WeatherApi');
      throw Exception('Failed to load weather data');
    }
  }
}
